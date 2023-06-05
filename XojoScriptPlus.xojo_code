#tag Class
Protected Class XojoScriptPlus
Inherits XojoScript
	#tag Event
		Function CompilerError(location As XojoScriptLocation, error As XojoScript.Errors, errorInfo As Dictionary) As Boolean
		  
		  Dim row As Integer = location.Line
		  
		  Dim rowtext As String = Self.Source.NthField(EndOfLine, row)
		  
		  Dim errorStr As String = "Compile error on line " + row.ToString("0") + ": " + rowtext + EndOfLine + CompileErrorLookup(error, errorInfo)
		  
		  Return CompilerError(location, error, errorInfo, errorStr)
		End Function
	#tag EndEvent

	#tag Event
		Sub CompilerWarning(location As XojoScriptLocation, warning As XojoScript.Warnings, warningInfo As Dictionary)
		  
		  Dim row As Integer = location.Line
		  
		  Dim rowtext As String = Self.Source.NthField(EndOfLine, row)
		  
		  Dim warningStr As String = "Compile warning on line " + row.ToString("0") + ": " + rowtext + EndOfLine + CompileWarningLookup(warning, warningInfo)
		  
		  RaiseEvent CompilerWarning(location, warning, warningInfo, warningStr)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CompileErrorLookup(error as xojoscript.Errors, errorInfo as Dictionary) As String
		  Static dict As Dictionary
		  If dict = Nil Then
		    dict = New Dictionary
		    dict.value(1) = "Syntax error."
		    dict.value(2) = "Type mismatch error."
		    dict.value(3) = "Only modules can be imported, but this is not a module."
		    dict.value(4) = "Can't import symbols over an existing symbol."
		    dict.value(5) = "The parser's internal stack has overflowed."
		    dict.value(6) = "Too many parameters for this function."
		    dict.value(7) = "Not enough parameters for this function call."
		    dict.value(8) = "Wrong number of parameters for this function call."
		    dict.value(9) = "Parameters are incompatible with this function."
		    dict.value(10) = "Assignment of an incompatible data type."
		    dict.value(11) = "Undefined identifier."
		    dict.value(12) = "Undefined operator."
		    dict.value(13) = "Logic operations require Boolean operands."
		    dict.value(14) = "Array bounds must be integers."
		    dict.value(15) = "Can't call something that isn't a function."
		    dict.value(16) = "This is not an array but you are using it as one."
		    dict.value(17) = "This array has more dimensions than you have provided."
		    dict.value(18) = "This array has fewer dimensions than you have provided."
		    dict.value(19) = "Can't assign an entire array."
		    dict.value(20) = "Can't use an entire array in an expression."
		    dict.value(21) = "You can't pass an expression as a parameter that is defined as ByRef."
		    dict.value(22) = "Redefined identifier."
		    dict.value(23) = "The backend code generator failed."
		    dict.value(24) = "Ambiguous call to overloaded method."
		    dict.value(25) = "Multiple inheritance is not allowed."
		    dict.value(26) = "You cannot create an instance of interface with New because it is not a class."
		    dict.value(27) = "One of the interfaces of this class is not of type class interface."
		    dict.value(28) = "You can only inherit from a class."
		    dict.value(29) = "This class does not fully implement the specified interface."
		    dict.value(30) = "Event handlers cannot live outside of a class."
		    dict.value(31) = "You must use the value returned by this function."
		    dict.value(32) = """Self"" doesn't mean anything in a module method."
		    dict.value(33) = """Me"" doesn't mean anything in a module method."
		    dict.value(34) = "You cannot return a value because this method has not defined a return type."
		    dict.value(35) = "Exception objects must be subclasses of RuntimeException."
		    dict.value(36) = "Return type does not match the interface method's return type."
		    dict.value(37) = "Return type does not match overridden method's return type."
		    dict.value(38) = "You cannot implement a nonexistent event."
		    dict.value(39) = "You cannot implement a nonexistent event."
		    dict.value(40) = "Destructors can't have parameters."
		    dict.value(41) = "Modules do not have superclasses. So ""Super"" does not mean anything in a module method."
		    dict.value(42) = "The current class does not have a superclass, so ""Super"" does not mean anything in this method."
		    dict.value(43) = "This #else does not have a matching #if preceding it."
		    dict.value(44) = "This #endif does not have a matching #if preceding it."
		    dict.value(45) = "Only Boolean constants can be used with #if."
		    dict.value(46) = "Only constants expressions can be used with #if."
		    dict.value(47) = "The Next variable does not match the loop's counter variable."
		    dict.value(48) = "The size of an array must be a constant or number."
		    dict.value(49) = "You can't pass an array to an external function."
		    dict.value(50) = "External functions cannot use objects as parameters."
		    dict.value(51) = "External functions cannot use ordinary strings as parameters. Use CString, PString, WString, or CFStringRef instead."
		    dict.value(52) = "This kind of array can not be sorted."
		    dict.value(53) = "This property is protected. It can only be used from within its class."
		    dict.value(54) = "This method is protected. It can only be called from within its class."
		    dict.value(55) = "This local variable or constant has the same name as a Declare in this method. You must resolve this conflict."
		    dict.value(56) = "This global variable has the same name as a global function."
		    dict.value(57) = "This property has the same name as a method. You must resolve this conflict."
		    dict.value(58) = "This property has the same name as an event. You must resolve this conflict."
		    dict.value(59) = "This global variable has the same name as a class."
		    dict.value(60) = "This global variable has the same name as a module."
		    dict.value(61) = "This local variable or parameter has the same name as a constant. You must resolve this conflict."
		    dict.value(62) = "This identifier is reserved and can't be used as a variable or property name."
		    dict.value(63) = "There is no class with this name. Can't find a type with this name."
		    dict.value(64) = "The library name must be a string constant."
		    dict.value(65) = "This Declare Function statement is missing its return type."
		    dict.value(66) = "You can't use the New operator with this class."
		    dict.value(67) = "This method doesn't return a value."
		    dict.value(68) = "End quote missing."
		    dict.value(69) = "A class cannot be its own superclass."
		    dict.value(70) = "Cannot assign a value to this property."
		    dict.value(71) = "Cannot get this property's value."
		    dict.value(72) = "The If statement is missing its condition."
		    dict.value(73) = "The current function must return a value, but this Return statement does not specify any value."
		    dict.value(74) = "Parameter options are incompatible."
		    dict.value(75) = "Parameter option was already specified."
		    dict.value(76) = "A parameter passed by reference cannot have a default value."
		    dict.value(77) = "A ParamArray cannot have a default value."
		    dict.value(78) = "An Assigns parameter cannot have a default value."
		    dict.value(79) = "An Extends parameter cannot have a default value."
		    dict.value(80) = "Only the first parameter may use the Extends option."
		    dict.value(81) = "Only the last parameter may use the Assigns option."
		    dict.value(82) = "An ordinary parameter cannot follow a ParamArray."
		    dict.value(83) = "Only one parameter may use the Assigns option."
		    dict.value(84) = "Only one parameter may use the ParamArray option."
		    dict.value(85) = "A ParamArray cannot have more than one dimension."
		    dict.value(86) = "The keyword ""Then"" is expected after this If statement's condition."
		    dict.value(87) = "Undefined member identifier."
		    dict.value(88) = "Constants must be defined with constant values."
		    dict.value(89) = "Illegal use of the Call keyword."
		    dict.value(90) = "No cases may follow the Else block."
		    dict.value(91) = "A computed property can only contain ""Get"" and ""Set"" blocks."
		    dict.value(92) = "A computed property getter or setter block ends with the wrong ""End"" line. For example, if you start the block with ""Get"", it must end with ""End Get""."
		    dict.value(93) = "Duplicate method definition."
		    dict.value(94) = "Syntax Error: The library name for this declaration is blank."
		    dict.value(95) = "This If statement is missing an End If statement."
		    dict.value(96) = "This Select Case statement is missing an End Select statement."
		    dict.value(97) = "This For loop is missing its Next statement."
		    dict.value(98) = "This While loop is missing its Wend statement."
		    dict.value(99) = "This Try statement is missing an End Try statement."
		    dict.value(100) = "This Do loop is missing its Loop statement."
		    dict.value(101) = "Too few parentheses."
		    dict.value(102) = "Too many parentheses."
		    dict.value(103) = "There is no block to continue here."
		    dict.value(104) = "There is no (%1) block to (%2) here."
		    dict.value(105) = "Shared methods cannot access instance properties."
		    dict.value(106) = "Instance methods need an object: call this on an instance."
		    dict.value(107) = "Shared computed property accessors cannot access instance properties."
		    dict.value(108) = "Shared computed property accessors cannot access instance methods."
		    dict.value(109) = "The Constructor of this class is protected, and can only be called from within this class."
		    dict.value(110) = "This string field needs to specify its length."
		    dict.value(111) = "Structures cannot contain fields of this type."
		    dict.value(112) = "Syntax Error: Structures cannot contain multidimensional arrays."
		    dict.value(113) = "Enumerated types can only contain integers."
		    dict.value(114) = "An enumeration cannot be defined in terms of another enumeration."
		    dict.value(115) = "This is a constant; its value can't be changed."
		    dict.value(116) = "A String field must be at least 1 byte long."
		    dict.value(117) = "The storage size specifier only applies to String fields."
		    dict.value(118) = "A structure cannot contain itself."
		    dict.value(119) = "Cannot create an instance of structure with New because it is not a class."
		    dict.value(120) = "Cannot create an instance of enum with New because it is not a class."
		    dict.value(121) = "This type is private, and can only be used within its module."
		    dict.value(122) = "Class members cannot be global."
		    dict.value(123) = "Module members must be public or private; they cannot be protected."
		    dict.value(124) = "Members of inner modules cannot be global."
		    dict.value(125) = "A Dim/Var statement creates only one new object at a time."
		    dict.value(126) = "A constant was expected here, but this is some other kind of expression."
		    dict.value(127) = "This module is private, and can only be used within its containing module."
		    dict.value(128) = "Duplicate property definition."
		    dict.value(129) = "This datatype cannot be used as an array element."
		    dict.value(130) = "Delegate parameters cannot be optional."
		    dict.value(131) = "Delegates cannot use Extends, Assigns, or ParamArray."
		    dict.value(132) = "The Declare statement is illegal in XojoScript."
		    dict.value(133) = "It is not legal to dereference a Ptr value in XojoScript."
		    dict.value(134) = "Delegate creation from Ptr values is not allowed in XojoScript."
		    dict.value(135) = "Duplicate constant definition."
		    dict.value(136) = "Ambiguous interface method implementation."
		    dict.value(137) = "Illegal explicit interface method implementation. The class does not claim to implement this interface."
		    dict.value(138) = "The interface does not declare this method."
		    dict.value(139) = "This method contains a #If without a closing #endif statement."
		    dict.value(140) = "This interface contains a cyclical interface aggregation."
		    dict.value(141) = "The Extends modifier cannot be used on a class method."
		    dict.value(142) = "You cannot assign a non-value type to a value."
		    dict.value(143) = "Duplicate attribute name."
		    dict.value(144) = "Delegates cannot return structures."
		    dict.value(145) = "You cannot use AddressOf on this method. Possible causes include using AddressOf on event declarations or soft declares."
		    dict.value(146) = "You cannot use an Operator_Convert method to perform a convert-to operation on an interface."
		    dict.value(147) = "Syntax Error: The ElseIf statement is missing its condition."
		    dict.value(148) = "This type cannot be used as an explicit constant type."
		    dict.value(149) = "Recursive constant declaration error."
		    dict.value(150) = "Custom error created using ""Error"" pragma."
		    dict.value(151) = "This is not a local variable or parameter."
		    dict.value(152) = "The maximum units in last position parameter must be a constant."
		    dict.value(153) = "The maximum units in last position parameter is out of range."
		    dict.value(154) = "The StructureAlignment attribute's value must be of the following: 1, 2, 4, 8, 16, 32, 64, or 128."
		    dict.value(155) = "Pair creation via the ":" operator is not allowed in XojoScript."
		    dict.value(156) = "Introspection via the GetTypeInfo operator is not allowed in XojoScript."
		    dict.value(157) = "The For statement is missing its condition."
		    dict.value(158) = "The While statement is missing its condition."
		    dict.value(159) = "Unsigned integer used in negative step loops can cause an infinite loop."
		    dict.value(160) = "Must use Objects with Is."
		    dict.value(161) = "Only objects can be used with AddHandler and RemoveHandler."
		    dict.value(162) = "The object you are passing to AddHandler does not have the specified event."
		    dict.value(163) = "Converting Delegates to Ptrs is not allowed in XojoScript."
		    dict.value(164) = "WeakAddressOf can only be used on instance methods."
		    dict.value(165) = "Declares directly into the runtime via Lib "" are no longer allowed."
		    dict.value(166) = "Objective-C declares must have at least one parameter (the target of the message send)."
		    dict.value(167) = "This property shadows a property of a different type."
		    dict.value(168) = "Goto target not found."
		    dict.value(169) = "'#pragma warning' requires a warning message."
		    dict.value(170) = "'#pragma error' requires an error message."
		    dict.value(171) = "Duplicate label."
		    dict.value(172) = "Object properties cannot have default values."
		    dict.value(173) = "Array properties cannot have default values."
		    dict.value(174) = "For Each loops over iterable objects cannot be used in XojoScript."
		    dict.value(175) = "This object does not implement the Iterable interface and cannot be used in a For Each loop."
		    dict.value(178) = "This is a type name, not a variable; values can't be assigned to it."
		    dict.value(179) = "This is a module, not a variable; values can't be assigned to it."
		    dict.value(180) = "Can't find a type with this name."
		    dict.value(181) = "Expected a type name but found %1 instead."
		    dict.value(182) = "Can't find a type or module with this name."
		    dict.value(183) = "Expected a type or module name here but found %1 instead."
		    dict.value(184) = "Extension method %1 requires a conversion from %2 to %3; use CType to explicitly convert first."
		    dict.value(185) = "Can't find a type with this name. Did you mean %1?"
		    dict.value(186) = "Undefined operator. Type %1 does not define ""%2"" with type %3."
		    dict.value(187) = "Undefined operator. Type %1 does not define ""%2""."
		    dict.value(188) = "Cannot import %1 from %2 because it is Global, not Public."
		    dict.value(189) = "Cannot import %1 from %2 because it is Private to its container, not Public."
		    dict.value(190) = "Expected a value of type %1, but found a static namespace reference to %2."
		    dict.value(191) = "Cannot create an instance of %1 with New because it is not a class."
		    dict.value(192) = "Cannot create an instance of %1 with New because it is not a class. Did you mean %2?"
		    dict.value(193) = "%1 is not available."
		    dict.value(194) = "Too many arguments: got %1, expected only %2."
		    dict.value(195) = "Too many arguments: got %1, expected no more than %2."
		    dict.value(196) = "Not enough arguments: missing %3 value for parameter ""%4""."
		    dict.value(197) = "Not enough arguments: got %1, expected %2."
		    dict.value(198) = "Not enough arguments: got %1, expected at least %2."
		    dict.value(199) = "Assignment accessor must be invoked by assigning a value."
		    dict.value(200) = "This method cannot accept an assigned value (it lacks an Assigns parameter)."
		    dict.value(201) = "Parameter ""%1"" expects %2, but this is %3."
		    dict.value(202) = "Expected (%1), but these arguments are (%2)."
		    dict.value(203) = "ParamArray ""%1"" expects values of %2, but this is %3."
		    dict.value(204) = "Instance methods need an object: call this on an instance of %1."
		    dict.value(205) = "Extension methods need a base expression: call this on a value of %1."
		    dict.value(206) = "Static reference to instance method: call this on an instance of %1."
		    dict.value(207) = "Static reference to extension method: call this on a value of %1."
		    dict.value(208) = "This method extends %1, but the base expression is %2."
		    dict.value(209) = "Cannot convert from %1 to %2 because %3 is protected."
		    dict.value(210) = "Fixed-length string fields are no longer supported; use an array of Byte instead."
		  End If
		  
		  Dim msg As String = dict.Lookup(CType(error, Integer), "Unknown: An unknown error has occurred")
		  
		  Dim keys() As Variant = errorInfo.keys
		  For i As Integer = UBound(keys) DownTo 0
		    msg = msg.ReplaceAll("%" + Str(i+1), errorInfo.Value(keys(i)))
		  Next
		  
		  Return msg
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CompileWarningLookup(warning as xojoscript.Warnings, warningInfo as Dictionary) As String
		  Static dict As Dictionary
		  If dict = Nil Then
		    dict = New Dictionary
		    
		    dict.value(1) = "%Name is deprecated."
		    dict.value(2) = "%Name is deprecated. You should use %Replacement instead."
		    dict.value(3) = "Old-style constructor methods are no longer supported. You should use ""Constructor"" instead."
		    dict.value(4) = "Unknown pragma name."
		    dict.value(5) = "Converting from %OriginalType to %NewType causes a possible loss of precision, which can lead to unexpected results."
		    dict.value(6) = "Converting from %OriginalType to %NewType causes the sign information to be lost, which can lead to unexpected results."
		    dict.value(7) = "Performing a %Operator comparison on floating-point values can yield unexpected results due to their inexact binary representation."
		    dict.value(8) = "A custom warning displayed by Pragma Warning."
		    dict.value(9) = "%Name is an unused local variable."
		    dict.value(10) = "%Name is an unused method parameter."
		    dict.value(11) = "%Name is an unused event parameter."
		    dict.value(12) = "This property shadows one already defined by %Superclass."
		    dict.value(13) = "This constant shadows one already defined by %Superclass."
		    dict.value(14) = "Before 2014r3, this would have referred to the %OldPath but now it refers to the %NewPath."
		  End If
		  
		  Dim msg As String = dict.Lookup(CType(warning, Integer), "Unknown: An unknown error has occurred")
		  
		  Dim keys() As Variant = warningInfo.keys
		  For i As Integer = UBound(keys) DownTo 0
		    msg = msg.ReplaceAll("%" + keys(i).StringValue, warningInfo.Value(keys(i)))
		  Next
		  
		  Return msg
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CompilerError(location as XojoScriptLocation, error as XojoScript.Errors, errorInfo as Dictionary, errorMessage as string) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CompilerWarning(location as XojoScriptLocation, warning as XojoScript.Warnings, warningInfo as Dictionary, warningMessage as String)
	#tag EndHook


	#tag ViewBehavior
		#tag ViewProperty
			Name="State"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="States"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Source"
			Visible=true
			Group=""
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
