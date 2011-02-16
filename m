Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com, padovan@profusion.mobi,
	Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 3/3] Add gatttool enhancements for UPF
Date: Wed, 16 Feb 2011 13:18:01 -0800
Message-Id: <1297891081-27976-4-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
References: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Including seperating write-cmd from write-char, and enabling
--listen to stand on it's own if needed. (PTS tester)
---
 attrib/gatttool.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 8e8ed8e..054adb1 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -63,6 +63,7 @@ static gboolean opt_listen = FALSE;
 static gboolean opt_char_desc = FALSE;
 static gboolean opt_le = FALSE;
 static gboolean opt_char_write = FALSE;
+static gboolean opt_char_cmd = FALSE;
 static GMainLoop *event_loop;
 static gboolean got_error = FALSE;
 
@@ -90,9 +91,9 @@ static GIOChannel *do_connect(gboolean le)
 
 	/* This check is required because currently setsockopt() returns no
 	 * errors for MTU values smaller than the allowed minimum. */
-	if (opt_mtu != 0 && opt_mtu < ATT_MIN_MTU_L2CAP) {
+	if (opt_mtu != 0 && opt_mtu < 23) {
 		g_printerr("MTU cannot be smaller than %d\n",
-							ATT_MIN_MTU_L2CAP);
+							23);
 		return NULL;
 	}
 
@@ -277,6 +278,14 @@ static gboolean characteristics(gpointer user_data)
 	return FALSE;
 }
 
+static void char_write_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	if (plen == 1)
+		g_print("Attrib Write Succeeded\n");
+	else
+		g_printerr("Attrib Write failed: %s\n", att_ecode2str(status));
+}
 static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -427,7 +436,40 @@ static gboolean characteristics_write(gpointer user_data)
 		goto error;
 	}
 
+	gatt_write_char(attrib, opt_handle, value, len, char_write_cb, value);
+	gatt_read_char(attrib, opt_handle, char_read_cb, attrib);
+
+	return FALSE;
+
+error:
+	g_main_loop_quit(event_loop);
+	return FALSE;
+}
+
+static gboolean characteristics_cmd(gpointer user_data)
+{
+	GAttrib *attrib = user_data;
+	uint8_t *value;
+	size_t len;
+
+	if (opt_handle <= 0) {
+		g_printerr("A valid handle is required\n");
+		goto error;
+	}
+
+	if (opt_value == NULL || opt_value[0] == '\0') {
+		g_printerr("A value is required\n");
+		goto error;
+	}
+
+	len = attr_data_from_string(opt_value, &value);
+	if (len == 0) {
+		g_printerr("Invalid value\n");
+		goto error;
+	}
+
 	gatt_write_cmd(attrib, opt_handle, value, len, mainloop_quit, value);
+	gatt_read_char(attrib, opt_handle, char_read_cb, attrib);
 
 	return FALSE;
 
@@ -531,6 +573,8 @@ static GOptionEntry gatt_options[] = {
 		"Characteristics Value/Descriptor Read", NULL },
 	{ "char-write", 0, 0, G_OPTION_ARG_NONE, &opt_char_write,
 		"Characteristics Value Write", NULL },
+	{ "char-cmd", 0, 0, G_OPTION_ARG_NONE, &opt_char_cmd,
+		"Characteristics Value Cmd", NULL },
 	{ "char-desc", 0, 0, G_OPTION_ARG_NONE, &opt_char_desc,
 		"Characteristics Descriptor Discovery", NULL },
 	{ "listen", 0, 0, G_OPTION_ARG_NONE, &opt_listen,
@@ -561,7 +605,7 @@ int main(int argc, char *argv[])
 	GError *gerr = NULL;
 	GAttrib *attrib;
 	GIOChannel *chan;
-	GSourceFunc callback;
+	GSourceFunc callback = NULL;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
@@ -602,9 +646,11 @@ int main(int argc, char *argv[])
 		callback = characteristics_read;
 	else if (opt_char_write)
 		callback = characteristics_write;
+	else if (opt_char_cmd)
+		callback = characteristics_cmd;
 	else if (opt_char_desc)
 		callback = characteristics_desc;
-	else {
+	else if (!opt_listen) {
 		gchar *help = g_option_context_get_help(context, TRUE, NULL);
 		g_print("%s\n", help);
 		g_free(help);
@@ -625,7 +671,8 @@ int main(int argc, char *argv[])
 	if (opt_listen)
 		g_idle_add(listen_start, attrib);
 
-	g_idle_add(callback, attrib);
+	if (callback)
+		g_idle_add(callback, attrib);
 
 	g_main_loop_run(event_loop);
 
-- 
1.7.1

--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
