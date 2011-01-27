Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 3/6] Add support to primary services discover on interactive mode in gatttool
Date: Thu, 27 Jan 2011 16:08:59 -0300
Message-Id: <1296155342-31956-3-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
References: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c |   48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index c347f6b..4e650a5 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -215,11 +215,27 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	GSList *l;
 
 	if (status) {
-		g_printerr("Discover all primary services failed: %s\n",
+		show_message("Discover all primary services failed: %s\n",
 							att_ecode2str(status));
 		goto done;
 	}
 
+	if (opt_interactive) {
+		rl_save_prompt();
+		for (l = services; l; l = l->next) {
+			struct att_primary *prim = l->data;
+			rl_message("attr handle = 0x%04x, end grp "
+				"handle = 0x%04x uuid: %s\n", prim->start,
+				prim->end, prim->uuid);
+			rl_on_new_line();
+		}
+
+		rl_restore_prompt();
+		rl_forced_update_display();
+
+		return;
+	}
+
 	for (l = services; l; l = l->next) {
 		struct att_primary *prim = l->data;
 		g_print("attr handle = 0x%04x, end grp handle = 0x%04x "
@@ -227,7 +243,8 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	}
 
 done:
-	g_main_loop_quit(event_loop);
+	if (!opt_interactive)
+		g_main_loop_quit(event_loop);
 }
 
 static void primary_by_uuid_cb(GSList *ranges, guint8 status,
@@ -236,11 +253,26 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	GSList *l;
 
 	if (status != 0) {
-		g_printerr("Discover primary services by UUID failed: %s\n",
+		show_message("Discover primary services by UUID failed: %s\n",
 							att_ecode2str(status));
 		goto done;
 	}
 
+	if (opt_interactive) {
+		rl_save_prompt();
+		for (l = ranges; l; l = l->next) {
+			struct att_range *range = l->data;
+			rl_message("Starting handle = 0x%04x Ending handle = 0x%04x",
+							range->start, range->end);
+			rl_on_new_line();
+		}
+
+		rl_restore_prompt();
+		rl_forced_update_display();
+
+		return;
+	}
+
 	for (l = ranges; l; l = l->next) {
 		struct att_range *range = l->data;
 		g_print("Starting handle: %04x Ending handle: %04x\n",
@@ -248,7 +280,8 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	}
 
 done:
-	g_main_loop_quit(event_loop);
+	if (!opt_interactive)
+		g_main_loop_quit(event_loop);
 }
 
 static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
@@ -316,7 +349,10 @@ static gboolean cmd_disconnect(gpointer cmd)
 
 static gboolean primary(gpointer user_data)
 {
-	GAttrib *attrib = user_data;
+	if (opt_interactive && conn_state != STATE_CONNECTED) {
+		show_message("Fail: disconnected\n");
+		return FALSE;
+	}
 
 	if (opt_uuid)
 		gatt_discover_primary(attrib, opt_uuid, primary_by_uuid_cb,
@@ -625,6 +661,8 @@ static struct {
 	{ "disconnect",	cmd_disconnect,	NULL,		"Disconnect"},
 	{ "characteristics",	characteristics,	NULL,
 						"Characteristcs Discovery"},
+	{ "primary",	primary,	NULL,
+						"Primary Service Discovery"},
 	{ NULL, NULL, NULL, NULL}
 };
 
-- 
1.7.1

