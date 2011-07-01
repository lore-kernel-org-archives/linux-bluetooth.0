Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/2] Add common macro for safely deriving the size of array
Date: Fri,  1 Jul 2011 15:53:20 -0300
Message-Id: <1309546401-19867-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This provides a simple ARRAY_SIZE() macro, which (given a good compiler)
will also break compile if you try to use it on a pointer. This can
ensure your code is robust to changes, without needing a gratuitous
macro or constant. Credits to Rusty Russell
(http://ccan.ozlabs.org/info/array_size.html)

Having a util.h file, this kind of things can be shared among all users
and we can remove all the declarations of ARRAY_SIZE.
---
 acinclude.m4 |   22 ++++++++++++++++++++++
 configure.ac |    1 +
 src/util.h   |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 src/util.h

diff --git a/acinclude.m4 b/acinclude.m4
index a37959a..8c2ae92 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -31,6 +31,28 @@ AC_DEFUN([AC_FUNC_PPOLL], [
 			[Define to 1 if you need the ppoll() function.]))
 ])
 
+AC_DEFUN([AC_FUNC_TYPES_COMPATIBLE_P], [
+	AC_CACHE_CHECK([if compiler has __builtin_types_compatible_p function],
+		[cc_cv_func_types_compatible_p],
+		[ac_save_CFLAGS="$CFLAGS"
+		CFLAGS="$CFLAGS -Werror"
+		AC_COMPILE_IFELSE([AC_LANG_SOURCE(
+			[int some_function();
+			int some_function() {
+			return __builtin_types_compatible_p(char *, int) ? 1 : 0;
+			}])],
+			[cc_cv_func_types_compatible_p=yes],
+			[cc_cv_func_types_compatible_p=no])
+		CFLAGS="$ac_save_CFLAGS"
+	])
+
+	AS_IF([test "x$cc_cv_func_types_compatible_p" = "xyes"],
+		[AC_DEFINE([SUPPORT__BUILTIN_TYPES_COMPATIBLE_P], 1,
+			[Define this if the compiler supports __builtin_types_compatible_p() function])
+			$1],
+		[$2])
+])
+
 AC_DEFUN([AC_INIT_BLUEZ], [
 	AC_PREFIX_DEFAULT(/usr/local)
 
diff --git a/configure.ac b/configure.ac
index 223c9d1..fed730f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -31,6 +31,7 @@ AC_DISABLE_STATIC
 AC_PROG_LIBTOOL
 
 AC_FUNC_PPOLL
+AC_FUNC_TYPES_COMPATIBLE_P
 
 AC_CHECK_LIB(dl, dlopen, dummy=yes,
 			AC_MSG_ERROR(dynamic linking loader is required))
diff --git a/src/util.h b/src/util.h
new file mode 100644
index 0000000..2c8a554
--- /dev/null
+++ b/src/util.h
@@ -0,0 +1,55 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Texas Instruments, Inc.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+/**
+ * BUILD_ASSERT_OR_ZERO - assert a build-time dependency, as an expression.
+ * @cond: the compile-time condition which must be true.
+ *
+ * Your compile will fail if the condition isn't true, or can't be evaluated
+ * by the compiler.  This can be used in an expression: its value is "0".
+ *
+ * Example:
+ *      #define foo_to_char(foo)                                            \
+ *              ((char *)(foo)                                              \
+ *              + BUILD_ASSERT_OR_ZERO(offsetof(struct foo, string) == 0))
+ */
+#define BUILD_ASSERT_OR_ZERO(cond) \
+	(sizeof(char [1 - 2*!(cond)]) - 1)
+
+#if SUPPORT__BUILTIN_TYPES_COMPATIBLE_P
+#define _array_size_chk(arr)						\
+	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(typeof(arr), \
+							typeof(&(arr)[0])))
+#else
+#define _array_size_chk(arr) 0
+#endif
+
+/**
+ * ARRAY_SIZE - get the number of elements in a visible array
+ * @arr: the array whose size you want.
+ *
+ * This does not work on pointers, or arrays declared as [], or
+ * function parameters.  With correct compiler support, such usage
+ * will cause a build error (see build_assert).
+ */
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + _array_size_chk(arr))
-- 
1.7.6

