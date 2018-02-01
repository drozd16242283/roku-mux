'*****************************************************************
'* Copyright Roku 2011-2017
'* All Rights Reserved
'*****************************************************************

' Functions in this file:
'
'     TestSuite__Main
'     MainTestSuite__SetUp
'     MainTestSuite__TearDown
'     TestCase__Main_CheckDataCount
'     TestCase__Main_CheckItemAttributes
'     TestCase__Main_CheckStreamFormatType
'     TestCase__Main_TestAddPrefixFunction__Failed
'     TestCase__Main_TestAddPrefixFunction__Passed

'----------------------------------------------------------------
' Main setup function.
'
' @return A configured TestSuite object.
'----------------------------------------------------------------
Function TestSuite__Main() as Object
Print ">>>>>> TestSuite__ClassToTest"
    ' Inherite your test suite from BaseTestSuite
    this = BaseTestSuite()

    ' Test suite name for log statistics
    this.Name = "MainTestSuite"

    this.SetUp = MainTestSuite__SetUp
    this.TearDown = MainTestSuite__TearDown

    ' Add tests to suite's tests collection
    this.addTest("CheckDataCount", TestCase__Main_CheckDataCount)

    return this
End Function

'----------------------------------------------------------------
' This function called immediately before running tests of current suite.
' This function called to prepare all data for testing.
'----------------------------------------------------------------
Sub MainTestSuite__SetUp()
    ' Target testing object. To avoid the object creation in each test
    ' we create instance of target object here and use it in tests as m.targetTestObject.
    Print "::::MainTestSuite__SetUp:::"
    m.mainData  = GetApiArray()
    m.SUT = ClassToTest()
End Sub

'----------------------------------------------------------------
' This function called immediately after running tests of current suite.
' This function called to clean or remove all data for testing.
'----------------------------------------------------------------
Sub MainTestSuite__TearDown()
    ' Remove all the test data
    m.Delete("mainData")
End Sub

'----------------------------------------------------------------
' Check if data has an expected amount of items
'
' @return An empty string if test is success or error message if not.
'----------------------------------------------------------------
Function TestCase__Main_CheckDataCount() as String
    return m.assertArrayCount(m.mainData, 15)
End Function

sub TestCase__Main_CheckItemAttributes_Setup()
    ? "--- CheckItemAttributes Test Setup function"
end sub

'----------------------------------------------------------------
' Check if first item has mandatory attributes
'
' @return An empty string if test is success or error message if not.
'----------------------------------------------------------------
Function TestCase__Main_CheckItemAttributes() as String
    firstItem = m.mainData[0]
Print "firstItem:",firstItem
Print "m.SUT:",m.SUT
    mandatoryAttributes = ["url", "title", "hdposterurl"]

    return m.AssertAAHasKeys(firstItem, mandatoryAttributes)
End Function

sub TestCase__Main_CheckItemAttributes_TearDown()
    ? "--- CheckItemAttributes Test TearDown function"
end sub

'----------------------------------------------------------------
' Check if stream format of the item is expected
'
' @return An empty string if test is success or error message if not.
'----------------------------------------------------------------
Function TestCase__Main_CheckStreamFormatType() as String
    firstItem = m.mainData[0]

    return m.assertEqual(firstItem.streamFormat, "mp4")
End Function

'----------------------------------------------------------------
' Generates invalid input object and pass it to function.
'
' @return An empty string if test is success or error message if not.
'----------------------------------------------------------------
Function TestCase__Main_TestAddPrefixFunction__Failed() as String
    'Create scheme for item generator
    scheme = {
        key1  : "integer"
        key2  : "string"
        key3  : "boolean"
        key4  : {subKey1: "string"}
    }
    inputObject = ItemGenerator(scheme)

    'Pass generated item to your function
    result = AddPrefixToAAItems(inputObject)

    return m.assertNotInvalid(result, "Input data is invalid. All values should be strings.")
End Function

'----------------------------------------------------------------
' Generates valid input object and pass it to function.
'
' @return An empty string if test is success or error message if not.
'----------------------------------------------------------------
Function TestCase__Main_TestAddPrefixFunction__Passed() as string
    'Create scheme for item generator
    scheme = {
        key1  : "string"
        key2  : "string"
        key3  : "string"
        key4  : "string"
    }
    inputObject = ItemGenerator(scheme)

    'Pass generated item to your function
    result = AddPrefixToAAItems(inputObject)

    return m.assertNotInvalid(result, "Input data is invalid. All values should be strings.")
End Function

'----------------------------------------------------------------
' Compares two identical associative arrays
'
' @return An empty string if test is success or error message if not.
'----------------------------------------------------------------
Function TestCase__Main_TestComparesAssociativeArrays() as String
    array = { key1: "key1", key2: "key2" }

    return m.assertEqual(array, array)
End Function

'----------------------------------------------------------------
' Compares two identical arrays
'
' @return An empty string if test is success or error message if not.
'----------------------------------------------------------------
Function TestCase__Main_TestComparesArrays() as String
    array = ["one", "two"]

    return m.assertEqual(array, array)
End Function



' '----------------------------------------------------------------
' ' Compares two identical associative arrays
' '
' ' @return An empty string if test is success or error message if not.
' '----------------------------------------------------------------
' Function TestSuite__ClassToTest_TestComparesAssociativeArrays() as String
'     ' result = m.SUT.methodToTest("yes")
'     result = m.mainData[0]
'     return m.assertEqual("correct", result)
' End Function

' '----------------------------------------------------------------
' ' Compares two identical arrays
' '
' ' @return An empty string if test is success or error message if not.
' '----------------------------------------------------------------
' Function TestSuite__ClassToTest_TestComparesArrays() as String
'     ' result = m.SUT.methodToTest("no")
'     result = m.mainData[1]
'     return m.assertEqual("inncorrect", result)
' End Function
