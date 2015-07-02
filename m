Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 01/13] build: Add configure-time checks for soletta
Date: Thu,  2 Jul 2015 11:33:42 -0300
Message-Id: <1435847634-22831-2-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The idea will be to re-use the work done in peripheral/ so we can easily
export node types for common Bluetooth profiles (the focus right now is
GATT profiles).

[1] https://github.com/solettaproject/soletta
---
 configure.ac | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/configure.ac b/configure.ac
index c65d19a..5c3f832 100644
--- a/configure.ac
+++ b/configure.ac
@@ -283,4 +283,42 @@ fi
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
+AC_ARG_ENABLE(soletta, AC_HELP_STRING([--enable-soletta],
+			[enable building BlueZ soletta nodes]),
+					[enable_soletta=${enableval}])
+AM_CONDITIONAL(SOLETTA, test "${enable_soletta}" = "yes")
+
+if (test "${enable_soletta}" = "yes"); then
+	PKG_CHECK_MODULES(SOLETTA, soletta, dummy=yes,
+					AC_MSG_ERROR(soletta is required))
+	AC_SUBST(SOLETTA_CFLAGS)
+	AC_SUBST(SOLETTA_LIBS)
+	solettaprefix="`$PKG_CONFIG --variable=prefix soletta`"
+	AC_SUBST(SOLETTA_PREFIX, [${solettaprefix}])
+fi
+
+AC_ARG_WITH([solettamodulesdir], AC_HELP_STRING([--with-solettamodulesdir=DIR],
+			[path to soletta modules directory]), [path_solettamodulesdir=${withval}])
+if (test "${enable_soletta}" != "no" && test -z "${path_solettamodulesdir}"); then
+	AC_MSG_CHECKING([soletta modules directory])
+	path_solettamodulesdir="`$PKG_CONFIG --variable=modulesdir soletta`"
+	if (test -z "${path_solettamodulesdir=}"); then
+		AC_MSG_ERROR([soletta modules directory is required])
+	fi
+	AC_MSG_RESULT([${path_solettamodulesdir}])
+fi
+AC_SUBST(SOLETTA_MODULESDIR, [${path_solettamodulesdir}])
+
+AC_ARG_WITH([solettadescdir], AC_HELP_STRING([--with-solettadescdir=DIR],
+			[path to soletta node type descriptions directory]), [path_solettadescdir=${withval}])
+if (test "${enable_soletta}" != "no" && test -z "${path_solettadescdir}"); then
+	AC_MSG_CHECKING([soletta modules directory])
+	path_solettadescdir="`$PKG_CONFIG --variable=pkgdatadir soletta`"
+	if (test -z "${path_solettadescdir=}"); then
+		AC_MSG_ERROR([soletta descriptions directory is required])
+	fi
+	AC_MSG_RESULT([${path_solettadescdir}])
+fi
+AC_SUBST(SOLETTA_DESCDIR, [${path_solettadescdir}])
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
2.4.5

