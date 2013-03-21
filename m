Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH 05/13] gatttool: Fix issues with printf() and readline prompt
Date: Thu, 21 Mar 2013 18:31:41 -0400
Message-Id: <1363905109-30839-6-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Use rl_printf() from bluetoothctl to consistently display messages. This
is specially important for asynchronous callbacks, where using printf()
may mess up the prompt created by readline.
---
 Makefile.tools       |    3 ++-
 attrib/interactive.c |    9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 4d45682..0de0a0d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -189,7 +189,8 @@ noinst_PROGRAMS += attrib/gatttool \
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 				attrib/gattrib.c btio/btio.c \
 				attrib/gatttool.h attrib/interactive.c \
-				attrib/utils.c src/log.c
+				attrib/utils.c src/log.c client/display.c \
+				client/display.h
 attrib_gatttool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ -lreadline
 
 tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
diff --git a/attrib/interactive.c b/attrib/interactive.c
index ce35218..d5da9ad 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -40,6 +40,7 @@
 #include "gattrib.h"
 #include "gatt.h"
 #include "gatttool.h"
+#include "client/display.h"
 
 static GIOChannel *iochannel = NULL;
 static GAttrib *attrib = NULL;
@@ -102,7 +103,6 @@ static void set_state(enum state st)
 {
 	conn_state = st;
 	rl_set_prompt(get_prompt());
-	rl_redisplay();
 }
 
 static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
@@ -145,8 +145,8 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	if (err) {
-		printf("connect error: %s\n", err->message);
 		set_state(STATE_DISCONNECTED);
+		rl_printf("%s\n", err->message);
 		return;
 	}
 
@@ -156,6 +156,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	g_attrib_register(attrib, ATT_OP_HANDLE_IND, GATTRIB_ALL_HANDLES,
 						events_handler, attrib, NULL);
 	set_state(STATE_CONNECTED);
+	rl_redisplay();
 }
 
 static void disconnect_io()
@@ -412,7 +413,7 @@ static void cmd_connect(int argcp, char **argvp)
 	}
 
 	if (opt_dst == NULL) {
-		printf("Remote Bluetooth address required\n");
+		rl_printf("Remote Bluetooth address required\n");
 		return;
 	}
 
@@ -420,8 +421,8 @@ static void cmd_connect(int argcp, char **argvp)
 	iochannel = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
 					opt_psm, opt_mtu, connect_cb, &gerr);
 	if (iochannel == NULL) {
-		printf("%s\n", gerr->message);
 		set_state(STATE_DISCONNECTED);
+		rl_printf("%s\n", gerr->message);
 		g_error_free(gerr);
 	} else
 		g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);
-- 
1.7.9.5

