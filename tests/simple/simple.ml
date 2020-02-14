let () =
  Test_framework.assert_eq String.equal Format.pp_print_string
    [%meta Metapp_preutils.expression_of_string Sys.ocaml_version]
      Sys.ocaml_version

let () =
  match true with
  | [%meta Metapp_preutils.pattern_construct (Lident (string_of_bool true)) []]
      -> ()
  | _ -> assert false

let () =
  match false with
  | [%meta Metapp_preutils.pattern_construct (Lident (string_of_bool true)) []]
      -> assert false
  | _ -> ()

let r = ref None

[%%meta Ast_helper.Str.eval (Metapp_preutils.apply
  (Metapp_preutils.ident (Lident ":="))
  [Metapp_preutils.ident (Lident "r");
    Metapp_preutils.construct (Lident "Some")
      [Metapp_preutils.expression_of_string "Hello"]])]

let () =
  Test_framework.assert_eq (=)
    (Stdcompat__format.pp_print_option Format.pp_print_string)
    (!r) (Some "Hello")
