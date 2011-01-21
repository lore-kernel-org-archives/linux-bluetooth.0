Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 7/7] Initial primary service discovery in igatttool
Date: Fri, 21 Jan 2011 10:46:26 -0300
Message-Id: <1295617586-3398-7-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
References: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am        |    3 ++-
 attrib/igatttool.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f9e05fd..ef9afb2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -188,7 +188,8 @@ bin_PROGRAMS += attrib/igatttool
 
 attrib_igatttool_SOURCES = attrib/igatttool.c btio/btio.c \
 			   attrib/gtcommon.h attrib/gtcommon.c \
-			  src/glib-helper.h src/glib-helper.c
+			   src/glib-helper.h src/glib-helper.c \
+			   attrib/gattrib.c attrib/att.c attrib/gatt.c
 attrib_igatttool_LDADD =  lib/libbluetooth.la @GLIB_LIBS@ @READLINE_LIBS@
 endif
 
diff --git a/attrib/igatttool.c b/attrib/igatttool.c
index e0d8b44..d3084d6 100644
--- a/attrib/igatttool.c
+++ b/attrib/igatttool.c
@@ -30,8 +30,12 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
+#include "gattrib.h"
+#include "gatt.h"
 #include "btio.h"
+#include "att.h"
 
 #include "gtcommon.h"
 
@@ -39,6 +43,7 @@ GIOChannel *iochannel = NULL;
 GMainLoop *main_loop = NULL;
 gboolean status = FALSE;
 GString *prompt = NULL;
+GAttrib *attrib = NULL;
 
 enum state {
 	STATE_DISCONNECTED,
@@ -96,9 +101,32 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		return;
 	}
 
+	attrib = g_attrib_new(iochannel);
 	set_state(STATE_CONNECTED);
 }
 
+static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+{
+	GSList *l;
+
+	if (status) {
+		show_message("Discover all primary services failed: %s\n",
+							att_ecode2str(status));
+		return;
+	}
+
+	rl_save_prompt();
+	for (l = services; l; l = l->next) {
+		struct att_primary *prim = l->data;
+		rl_message("attr handle = 0x%04x, end grp handle = 0x%04x "
+			"uuid: %s\n", prim->start, prim->end, prim->uuid);
+		rl_on_new_line();
+	}
+
+	rl_restore_prompt();
+	rl_forced_update_display();
+}
+
 static void cmd_connect(char **cmd)
 {
 	if (conn_state != STATE_DISCONNECTED)
@@ -125,6 +153,9 @@ static void cmd_disconnect(char **cmd)
 	if (conn_state == STATE_DISCONNECTED)
 		return;
 
+	g_attrib_unref(attrib);
+	attrib = NULL;
+
 	g_io_channel_shutdown(iochannel, FALSE, NULL);
 	g_io_channel_unref(iochannel);
 	iochannel = NULL;
@@ -166,6 +197,16 @@ static void cmd_psm(char **opt)
 	rl_redisplay();
 }
 
+static void cmd_primary(char **cmd)
+{
+	if (conn_state != STATE_CONNECTED) {
+		show_message("Fail: disconnected\n");
+		return;
+	}
+
+	gatt_discover_primary(attrib, NULL, primary_all_cb, NULL);
+}
+
 static struct {
 	char *cmd;
 	void (*func)(char **cmd);
@@ -177,6 +218,7 @@ static struct {
 	{ "exit",	cmd_exit,	NULL,		"Exit"},
 	{ "transport",	cmd_transport,	"<LE | BR>",	"Set transport"},
 	{ "psm",	cmd_psm,	"<psm>",	"Set psm"},
+	{ "primary",	cmd_primary,	NULL,		"Primary Service Discovery"},
 	{ NULL, NULL, NULL, NULL}
 };
 
@@ -234,7 +276,6 @@ int main(int argc, char *argv[])
 	}
 
 	main_loop = g_main_loop_new(NULL, FALSE);
-
 	prompt = g_string_new(NULL);
 
 	pchan = g_io_channel_unix_new(fileno(stdin));
@@ -247,6 +288,7 @@ int main(int argc, char *argv[])
 	g_main_loop_run(main_loop);
 
 	cmd_disconnect(NULL);
+	g_attrib_unref(attrib);
 	rl_callback_handler_remove();
 	g_io_channel_unref(pchan);
 	g_main_loop_unref(main_loop);
-- 
1.7.1

