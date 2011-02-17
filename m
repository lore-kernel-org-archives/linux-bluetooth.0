Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Add Primary Discovery Services option to interactive gatttool
Date: Thu, 17 Feb 2011 17:20:30 -0300
Message-Id: <1297974030-20497-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 1df2b69..edc465a 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -25,11 +25,17 @@
 #include <stdio.h>
 #include <glib.h>
 
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
 #include <readline/readline.h>
 #include <readline/history.h>
 
+#include "att.h"
 #include "btio.h"
 #include "gattrib.h"
+#include "glib-helper.h"
+#include "gatt.h"
 #include "gatttool.h"
 
 static GIOChannel *iochannel = NULL;
@@ -98,6 +104,47 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	set_state(STATE_CONNECTED);
 }
 
+static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+{
+	GSList *l;
+
+	if (status) {
+		printf("Discover all primary services failed: %s\n",
+							att_ecode2str(status));
+		return;
+	}
+
+	printf("\n");
+	for (l = services; l; l = l->next) {
+		struct att_primary *prim = l->data;
+		printf("attr handle: 0x%04x, end grp handle: 0x%04x "
+			"uuid: %s\n", prim->start, prim->end, prim->uuid);
+	}
+
+	rl_forced_update_display();
+}
+
+static void primary_by_uuid_cb(GSList *ranges, guint8 status,
+							gpointer user_data)
+{
+	GSList *l;
+
+	if (status) {
+		printf("Discover primary services by UUID failed: %s\n",
+							att_ecode2str(status));
+		return;
+	}
+
+	printf("\n");
+	for (l = ranges; l; l = l->next) {
+		struct att_range *range = l->data;
+		g_print("Starting handle: 0x%04x Ending handle: 0x%04x\n",
+						range->start, range->end);
+	}
+
+	rl_forced_update_display();
+}
+
 static void cmd_exit(int argcp, char **argvp)
 {
 	rl_callback_handler_remove();
@@ -145,6 +192,28 @@ static void cmd_disconnect(int argcp, char **argvp)
 	return;
 }
 
+static void cmd_primary(int argcp, char **argvp)
+{
+	uuid_t uuid;
+
+	if (conn_state != STATE_CONNECTED) {
+		printf("Command failed: disconnected\n");
+		return;
+	}
+
+	if (argcp == 1) {
+		gatt_discover_primary(attrib, NULL, primary_all_cb, NULL);
+		return;
+	}
+
+	if (bt_string2uuid(&uuid, argvp[1]) < 0) {
+		printf("Invalid UUID\n");
+		return;
+	}
+
+	gatt_discover_primary(attrib, &uuid, primary_by_uuid_cb, NULL);
+}
+
 static struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
@@ -154,6 +223,7 @@ static struct {
 	{ "exit",	cmd_exit,	"Exit interactive mode"},
 	{ "connect",	cmd_connect,	"Connect to a remote device"},
 	{ "disconnect",	cmd_disconnect,	"Disconnect from a remote device"},
+	{ "primary",	cmd_primary,	"Primary Service Discovery"},
 	{ NULL, NULL, NULL}
 };
 
-- 
1.7.1

