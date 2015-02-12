Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 4/5] client/display: Rename to client/interactive
Date: Thu, 12 Feb 2015 18:52:12 +0100
Message-Id: <1423763533-15071-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423763533-15071-1-git-send-email-szymon.janc@tieto.com>
References: <1423763533-15071-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This code is now handling other interactive mode functionality, not
only display.
---
 Makefile.tools                      | 12 ++++++------
 attrib/interactive.c                |  2 +-
 client/agent.c                      |  2 +-
 client/gatt.c                       |  2 +-
 client/{display.c => interactive.c} |  2 +-
 client/{display.h => interactive.h} |  0
 client/main.c                       |  2 +-
 tools/bluetooth-player.c            |  2 +-
 tools/btmgmt.c                      |  2 +-
 tools/obexctl.c                     |  2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)
 rename client/{display.c => interactive.c} (99%)
 rename client/{display.h => interactive.h} (100%)

diff --git a/Makefile.tools b/Makefile.tools
index d721b4a..d112691 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -3,7 +3,7 @@ if CLIENT
 bin_PROGRAMS += client/bluetoothctl
 
 client_bluetoothctl_SOURCES = client/main.c \
-					client/display.h client/display.c \
+					client/interactive.h client/interactive.c \
 					client/agent.h client/agent.c \
 					client/gatt.h client/gatt.c \
 					monitor/uuid.h monitor/uuid.c
@@ -243,7 +243,7 @@ tools_hwdb_LDADD = lib/libbluetooth-internal.la
 
 tools_hcieventmask_LDADD = lib/libbluetooth-internal.la
 
-tools_btmgmt_SOURCES = tools/btmgmt.c src/uuid-helper.c client/display.c
+tools_btmgmt_SOURCES = tools/btmgmt.c src/uuid-helper.c client/interactive.c
 tools_btmgmt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la \
 				-lreadline
 
@@ -298,8 +298,8 @@ noinst_PROGRAMS += attrib/gatttool \
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 				attrib/gattrib.c btio/btio.c \
 				attrib/gatttool.h attrib/interactive.c \
-				attrib/utils.c src/log.c client/display.c \
-				client/display.h
+				attrib/utils.c src/log.c client/interactive.c \
+				client/interactive.h
 attrib_gatttool_LDADD = lib/libbluetooth-internal.la \
 			src/libshared-mainloop.la \
 			src/libshared-glib.la @GLIB_LIBS@ -lreadline
@@ -314,13 +314,13 @@ tools_obex_server_tool_SOURCES = $(gobex_sources) $(btio_sources) \
 tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_bluetooth_player_SOURCES = tools/bluetooth-player.c \
-				client/display.h client/display.c
+				client/interactive.h client/interactive.c
 tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
 				src/libshared-mainloop.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 
 tools_obexctl_SOURCES = tools/obexctl.c \
-				client/display.h client/display.c
+				client/interactive.h client/interactive.c
 tools_obexctl_LDADD = gdbus/libgdbus-internal.la src/libshared-mainloop.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 endif
diff --git a/attrib/interactive.c b/attrib/interactive.c
index da8bcb9..56e1cae 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -45,7 +45,7 @@
 #include "gattrib.h"
 #include "gatt.h"
 #include "gatttool.h"
-#include "client/display.h"
+#include "client/interactive.h"
 
 static GIOChannel *iochannel = NULL;
 static GAttrib *attrib = NULL;
diff --git a/client/agent.c b/client/agent.c
index 4691afe..e9ba2a9 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -31,7 +31,7 @@
 #include <readline/readline.h>
 #include <gdbus.h>
 
-#include "display.h"
+#include "interactive.h"
 #include "agent.h"
 
 #define AGENT_PATH "/org/bluez/agent"
diff --git a/client/gatt.c b/client/gatt.c
index 4bdbaba..14985a8 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -38,7 +38,7 @@
 #include <gdbus.h>
 
 #include "monitor/uuid.h"
-#include "display.h"
+#include "interactive.h"
 #include "gatt.h"
 
 /* String display constants */
diff --git a/client/display.c b/client/interactive.c
similarity index 99%
rename from client/display.c
rename to client/interactive.c
index 25eafe3..1089f4d 100644
--- a/client/display.c
+++ b/client/interactive.c
@@ -37,7 +37,7 @@
 #include "src/shared/mainloop.h"
 #include "src/shared/io.h"
 
-#include "display.h"
+#include "interactive.h"
 
 static char *saved_prompt = NULL;
 static int saved_point = 0;
diff --git a/client/display.h b/client/interactive.h
similarity index 100%
rename from client/display.h
rename to client/interactive.h
diff --git a/client/main.c b/client/main.c
index 96781b2..17d596a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -40,7 +40,7 @@
 
 #include "monitor/uuid.h"
 #include "agent.h"
-#include "display.h"
+#include "interactive.h"
 #include "gatt.h"
 
 /* String display constants */
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 22e0557..abc77e9 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -38,7 +38,7 @@
 #include <glib.h>
 #include <gdbus.h>
 
-#include <client/display.h>
+#include "client/interactive.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index b02af35..46b2f7c 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -48,7 +48,7 @@
 #include "src/uuid-helper.h"
 #include "lib/mgmt.h"
 
-#include "client/display.h"
+#include "client/interactive.h"
 #include "src/shared/mainloop.h"
 #include "src/shared/io.h"
 #include "src/shared/util.h"
diff --git a/tools/obexctl.c b/tools/obexctl.c
index c105b2f..493ae7f 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -40,7 +40,7 @@
 #include <glib.h>
 #include <gdbus.h>
 
-#include <client/display.h>
+#include "client/interactive.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
-- 
1.9.3

