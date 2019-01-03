(** Copyright (c) 2016-present, Facebook, Inc.

    This source code is licensed under the MIT license found in the
    LICENSE file in the root directory of this source tree. *)

open OUnit2
open IntegrationTest


let test_check_assign _ =
  assert_type_errors
    {|
      def foo() -> None:
        x = 1
        x = 'string'  # Reassignment is okay.
    |}
    [];

  assert_type_errors
    {|
      def foo() -> None:
        x = 1
        x += 'asdf'
    |}
    ["Incompatible parameter type [6]: " ^
     "Expected `int` for 1st anonymous parameter to call `int.__add__` but got `str`."]



let () =
  "assign">:::[
    "check_assign">::test_check_assign;
  ]
  |> Test.run