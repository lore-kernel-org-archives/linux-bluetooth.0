Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] build: Fix conditional check for enable-mesh
Date: Wed,  1 Aug 2018 11:10:58 -0700
Message-Id: <20180801181058.4279-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 24fa4a789..ec810fcf4 100644
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
@@ -260,7 +260,7 @@ AC_ARG_ENABLE(client, AC_HELP_STRING([--disable-client],
 		[disable command line client]), [enable_client=${enableval}])
 AM_CONDITIONAL(CLIENT, test "${enable_client}" != "no")
 
-if (test "${enable_client}" != "no" || test "${enable_mesh}" == "yes"); then
+if (test "${enable_client}" != "no" || test "${enable_mesh}" = "yes"); then
         AC_CHECK_HEADERS(readline/readline.h, enable_readline=yes,
                 AC_MSG_ERROR(readline header files are required))
 fi
-- 
2.14.4

