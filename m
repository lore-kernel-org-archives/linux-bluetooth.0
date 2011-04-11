Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Fix race condition on gatttool
Date: Mon, 11 Apr 2011 14:57:04 -0300
Message-Id: <1302544624-5216-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the connect_cb() takes too long to be called the event_loop goes to idle
state and executes the callback too early
---
 attrib/gatttool.c |  128 +++++++++++++++++++++++++---------------------------
 1 files changed, 62 insertions(+), 66 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index be91967..cf052db 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -63,6 +63,7 @@ static gboolean opt_char_write_req = FALSE;
 static gboolean opt_interactive = FALSE;
 static GMainLoop *event_loop;
 static gboolean got_error = FALSE;
+static GSourceFunc operation;
 
 struct characteristic_data {
 	GAttrib *attrib;
@@ -70,13 +71,68 @@ struct characteristic_data {
 	uint16_t end;
 };
 
+static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	GAttrib *attrib = user_data;
+	uint8_t opdu[ATT_MAX_MTU];
+	uint16_t handle, i, olen = 0;
+
+	handle = att_get_u16(&pdu[1]);
+
+	switch (pdu[0]) {
+	case ATT_OP_HANDLE_NOTIFY:
+		g_print("Notification handle = 0x%04x value: ", handle);
+		break;
+	case ATT_OP_HANDLE_IND:
+		g_print("Indication   handle = 0x%04x value: ", handle);
+		break;
+	default:
+		g_print("Invalid opcode\n");
+		return;
+	}
+
+	for (i = 3; i < len; i++)
+		g_print("%02x ", pdu[i]);
+
+	g_print("\n");
+
+	if (pdu[0] == ATT_OP_HANDLE_NOTIFY)
+		return;
+
+	olen = enc_confirmation(opdu, sizeof(opdu));
+
+	if (olen > 0)
+		g_attrib_send(attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
+}
+
+static gboolean listen_start(gpointer user_data)
+{
+	GAttrib *attrib = user_data;
+
+	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY, events_handler,
+							attrib, NULL);
+	g_attrib_register(attrib, ATT_OP_HANDLE_IND, events_handler,
+							attrib, NULL);
+
+	return FALSE;
+}
+
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
+	GAttrib *attrib;
+
 	if (err) {
 		g_printerr("%s\n", err->message);
 		got_error = TRUE;
 		g_main_loop_quit(event_loop);
 	}
+
+	attrib = g_attrib_new(io);
+
+	if (opt_listen)
+		g_idle_add(listen_start, attrib);
+
+	operation(attrib);
 }
 
 static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
@@ -120,52 +176,6 @@ done:
 	g_main_loop_quit(event_loop);
 }
 
-static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
-{
-	GAttrib *attrib = user_data;
-	uint8_t opdu[ATT_MAX_MTU];
-	uint16_t handle, i, olen = 0;
-
-	handle = att_get_u16(&pdu[1]);
-
-	switch (pdu[0]) {
-	case ATT_OP_HANDLE_NOTIFY:
-		g_print("Notification handle = 0x%04x value: ", handle);
-		break;
-	case ATT_OP_HANDLE_IND:
-		g_print("Indication   handle = 0x%04x value: ", handle);
-		break;
-	default:
-		g_print("Invalid opcode\n");
-		return;
-	}
-
-	for (i = 3; i < len; i++)
-		g_print("%02x ", pdu[i]);
-
-	g_print("\n");
-
-	if (pdu[0] == ATT_OP_HANDLE_NOTIFY)
-		return;
-
-	olen = enc_confirmation(opdu, sizeof(opdu));
-
-	if (olen > 0)
-		g_attrib_send(attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
-}
-
-static gboolean listen_start(gpointer user_data)
-{
-	GAttrib *attrib = user_data;
-
-	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY, events_handler,
-							attrib, NULL);
-	g_attrib_register(attrib, ATT_OP_HANDLE_IND, events_handler,
-							attrib, NULL);
-
-	return FALSE;
-}
-
 static gboolean primary(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
@@ -527,9 +537,7 @@ int main(int argc, char *argv[])
 	GOptionContext *context;
 	GOptionGroup *gatt_group, *params_group, *char_rw_group;
 	GError *gerr = NULL;
-	GAttrib *attrib;
 	GIOChannel *chan;
-	GSourceFunc callback;
 
 	opt_sec_level = g_strdup("low");
 
@@ -570,17 +578,17 @@ int main(int argc, char *argv[])
 	}
 
 	if (opt_primary)
-		callback = primary;
+		operation = primary;
 	else if (opt_characteristics)
-		callback = characteristics;
+		operation = characteristics;
 	else if (opt_char_read)
-		callback = characteristics_read;
+		operation = characteristics_read;
 	else if (opt_char_write)
-		callback = characteristics_write;
+		operation = characteristics_write;
 	else if (opt_char_write_req)
-		callback = characteristics_write_req;
+		operation = characteristics_write_req;
 	else if (opt_char_desc)
-		callback = characteristics_desc;
+		operation = characteristics_desc;
 	else {
 		gchar *help = g_option_context_get_help(context, TRUE, NULL);
 		g_print("%s\n", help);
@@ -596,24 +604,12 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	attrib = g_attrib_new(chan);
-	g_io_channel_unref(chan);
-
 	event_loop = g_main_loop_new(NULL, FALSE);
 
-	if (opt_listen)
-		g_idle_add(listen_start, attrib);
-
-	g_idle_add(callback, attrib);
-
 	g_main_loop_run(event_loop);
 
-	g_attrib_unregister_all(attrib);
-
 	g_main_loop_unref(event_loop);
 
-	g_attrib_unref(attrib);
-
 done:
 	g_option_context_free(context);
 	g_free(opt_src);
-- 
1.7.1

