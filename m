Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/8] client: Fix not sending parameters to get message in map module
Date: Thu, 13 Sep 2012 16:06:59 +0300
Message-Id: <1347541621-26858-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
References: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Attachment and charset are mandatory, so Message.Get now takes an
additional boolean parameter which the user application should set
if it wants the attachments to be downloaded, charset is always set
to UTF8.
---
 client/map.c       | 20 +++++++++++++++++++-
 doc/client-api.txt |  2 +-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/client/map.c b/client/map.c
index cf3d8ed..4b5f8a2 100644
--- a/client/map.c
+++ b/client/map.c
@@ -53,6 +53,8 @@
 #define DEFAULT_COUNT 1024
 #define DEFAULT_OFFSET 0
 
+#define CHARSET_UTF8 1
+
 static const char * const filter_list[] = {
 	"subject",
 	"timestamp",
@@ -377,11 +379,16 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 	struct map_msg *msg = user_data;
 	struct obc_transfer *transfer;
 	const char *target_file;
+	gboolean attachment;
 	GError *err = NULL;
 	DBusMessage *reply;
+	GObexApparam *apparam;
+	guint8 buf[6];
+	gsize len;
 
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &target_file,
+				DBUS_TYPE_BOOLEAN, &attachment,
 				DBUS_TYPE_INVALID) == FALSE)
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
@@ -391,6 +398,16 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
+	apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_ATTACHMENT,
+								attachment);
+	apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_CHARSET,
+								CHARSET_UTF8);
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+
+	obc_transfer_set_params(transfer, buf, len);
+
+	g_obex_apparam_free(apparam);
+
 	if (!obc_session_queue(msg->data->session, transfer, NULL, NULL, &err))
 		goto fail;
 
@@ -405,7 +422,8 @@ fail:
 
 static const GDBusMethodTable map_msg_methods[] = {
 	{ GDBUS_METHOD("Get",
-			GDBUS_ARGS({ "targetfile", "s" }),
+			GDBUS_ARGS({ "targetfile", "s" },
+						{ "attachment", "b" }),
 			GDBUS_ARGS({ "transfer", "o" },
 						{ "properties", "a{sv}" }),
 			map_msg_get) },
diff --git a/doc/client-api.txt b/doc/client-api.txt
index f78b8fe..25fd3e4 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -520,7 +520,7 @@ Service		org.bluez.obex.client
 Interface	org.bluez.obex.Message
 Object path	[variable prefix]/{session0,session1,...}/{message0,...}
 
-Methods		object, dict Get(string targetfile)
+Methods		object, dict Get(string targetfile, boolean attachment)
 
 			Download message and store it in the target file.
 
-- 
1.7.11.4

