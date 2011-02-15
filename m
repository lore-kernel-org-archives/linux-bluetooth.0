Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 2/2] Add Write Request operation in gatttool
Date: Tue, 15 Feb 2011 10:36:04 -0400
Message-Id: <1297780564-12414-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add option and callbacks for Write Request operation in gatttool.
---
 attrib/gatttool.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 8e8ed8e..b9f0087 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -63,6 +63,7 @@ static gboolean opt_listen = FALSE;
 static gboolean opt_char_desc = FALSE;
 static gboolean opt_le = FALSE;
 static gboolean opt_char_write = FALSE;
+static gboolean opt_char_write_req = FALSE;
 static GMainLoop *event_loop;
 static gboolean got_error = FALSE;
 
@@ -436,6 +437,59 @@ error:
 	return FALSE;
 }
 
+static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	if (status != 0) {
+		g_printerr("Characteristic Write Request failed: "
+						"%s\n", att_ecode2str(status));
+		goto done;
+	}
+
+	if (!dec_write_resp(pdu, plen)) {
+		g_printerr("Protocol error\n");
+		goto done;
+	}
+
+	g_print("Characteristic value was written sucessfully\n");
+
+done:
+	if (opt_listen == FALSE)
+		g_main_loop_quit(event_loop);
+}
+
+static gboolean characteristics_write_req(gpointer user_data)
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
+	gatt_write_char(attrib, opt_handle, value, len, char_write_req_cb,
+									NULL);
+
+	return FALSE;
+
+error:
+	g_main_loop_quit(event_loop);
+	return FALSE;
+}
+
 static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -530,7 +584,10 @@ static GOptionEntry gatt_options[] = {
 	{ "char-read", 0, 0, G_OPTION_ARG_NONE, &opt_char_read,
 		"Characteristics Value/Descriptor Read", NULL },
 	{ "char-write", 0, 0, G_OPTION_ARG_NONE, &opt_char_write,
-		"Characteristics Value Write", NULL },
+		"Characteristics Value Write Without Response (Write Command)",
+		NULL },
+	{ "char-write-req", 0, 0, G_OPTION_ARG_NONE, &opt_char_write_req,
+		"Characteristics Value Write (Write Request)", NULL },
 	{ "char-desc", 0, 0, G_OPTION_ARG_NONE, &opt_char_desc,
 		"Characteristics Descriptor Discovery", NULL },
 	{ "listen", 0, 0, G_OPTION_ARG_NONE, &opt_listen,
@@ -602,6 +659,8 @@ int main(int argc, char *argv[])
 		callback = characteristics_read;
 	else if (opt_char_write)
 		callback = characteristics_write;
+	else if (opt_char_write_req)
+		callback = characteristics_write_req;
 	else if (opt_char_desc)
 		callback = characteristics_desc;
 	else {
-- 
1.7.0.4

