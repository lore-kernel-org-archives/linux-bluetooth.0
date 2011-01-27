Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 4/6] Add support to characteristics read on interactive mode in gatttool
Date: Thu, 27 Jan 2011 16:09:00 -0300
Message-Id: <1296155342-31956-4-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
References: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 4e650a5..f7d6056 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -424,21 +424,32 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	int i, vlen;
 
 	if (status != 0) {
-		g_printerr("Characteristic value/descriptor read failed: %s\n",
-							att_ecode2str(status));
+		show_message("Characteristic value/descriptor read "
+					"failed: %s\n", att_ecode2str(status));
 		goto done;
 	}
 	if (!dec_read_resp(pdu, plen, value, &vlen)) {
-		g_printerr("Protocol error\n");
+		show_message("Protocol error\n");
 		goto done;
 	}
+
+	if (opt_interactive) {
+		g_print("\nCharacteristic value/descriptor: ");
+		for (i = 0; i < vlen; i++)
+			g_print("%02x ", value[i]);
+		g_print("\n");
+		rl_forced_update_display();
+
+		return;
+	}
+
 	g_print("Characteristic value/descriptor: ");
 	for (i = 0; i < vlen; i++)
 		g_print("%02x ", value[i]);
 	g_print("\n");
 
 done:
-	if (opt_listen == FALSE)
+	if ((opt_listen == FALSE) && (opt_interactive == FALSE))
 		g_main_loop_quit(event_loop);
 }
 
@@ -474,6 +485,9 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 		for (j = 0; j < list->len - 2; j++, value++)
 			g_print("%02x ", *value);
 		g_print("\n");
+
+		if( opt_interactive)
+			rl_forced_update_display();
 	}
 
 	att_data_list_free(list);
@@ -486,12 +500,16 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 	return;
 done:
 	g_free(char_data);
-	g_main_loop_quit(event_loop);
+	if (!opt_interactive)
+		g_main_loop_quit(event_loop);
 }
 
 static gboolean characteristics_read(gpointer user_data)
 {
-	GAttrib *attrib = user_data;
+	if (opt_interactive && conn_state != STATE_CONNECTED) {
+		show_message("Fail: disconnected\n");
+		return FALSE;
+	}
 
 	if (opt_uuid != NULL) {
 		struct characteristic_data *char_data;
@@ -509,7 +527,8 @@ static gboolean characteristics_read(gpointer user_data)
 
 	if (opt_handle <= 0) {
 		g_printerr("A valid handle is required\n");
-		g_main_loop_quit(event_loop);
+		if (!opt_interactive)
+			g_main_loop_quit(event_loop);
 		return FALSE;
 	}
 
@@ -663,6 +682,7 @@ static struct {
 						"Characteristcs Discovery"},
 	{ "primary",	primary,	NULL,
 						"Primary Service Discovery"},
+	{ "char-read",	characteristics_read,	NULL,	"Characteristcs read"},
 	{ NULL, NULL, NULL, NULL}
 };
 
-- 
1.7.1

