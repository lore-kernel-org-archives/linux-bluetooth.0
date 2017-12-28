Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Iain Hibbert <plunky@netbsd.org>
To: linux-bluetooth@vger.kernel.org
Cc: Iain Hibbert <plunky@netbsd.org>
Subject: [PATCH] don't use == in /bin/sh script (bash-specific)
Date: Thu, 28 Dec 2017 23:05:03 +0000
Message-Id: <20171228230503.21610-1-plunky@netbsd.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index a7d936c0f..7baf9bbce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -216,7 +216,7 @@ AC_ARG_ENABLE(mesh, AC_HELP_STRING([--enable-mesh],
 		[enable Mesh profile support]), [enable_mesh=${enableval}])
 AM_CONDITIONAL(MESH, test "${enable_mesh}" = "yes")
 
-if (test "${enable_mesh}" == "yes"); then
+if (test "${enable_mesh}" = "yes"); then
 	PKG_CHECK_MODULES(JSONC, json-c, dummy=yes,
 				AC_MSG_ERROR(json-c is required))
 	AC_SUBST(JSON_CFLAGS)
@@ -259,7 +259,7 @@ AC_ARG_ENABLE(client, AC_HELP_STRING([--disable-client],
 		[disable command line client]), [enable_client=${enableval}])
 AM_CONDITIONAL(CLIENT, test "${enable_client}" != "no")
 
-if (test "${enable_client}" != "no" || test "${enable_mesh}" == "yes"); then
+if (test "${enable_client}" != "no" || test "${enable_mesh}" = "yes"); then
         AC_CHECK_HEADERS(readline/readline.h, enable_readline=yes,
                 AC_MSG_ERROR(readline header files are required))
 fi
-- 
2.15.1

