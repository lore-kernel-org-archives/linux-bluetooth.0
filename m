Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] obexd: Add support for retrieving messages in fractions
Date: Thu, 28 Feb 2013 16:08:44 +0100
Message-Id: <1362064124-29787-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1362064124-29787-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1362064124-29787-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Fractioned messages can be requested if the reception_status is fractioned.
For requesting Message.Get has been extended with a FractionRequest
parameter that can be set to 'first' or 'next'.
After a part of the message has been transfered, the client can query
the message's properties. The property FractionDelivery is set to 'more'
or 'last' depending if more fractions exist or not.
---
 doc/obex-api.txt   | 13 +++++++++
 obexd/client/map.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 0dd1261..4d15190 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -738,6 +738,19 @@ Methods		object, dict Get(string targetfile, dict args)
 					Request message attachment,
 					defaults to True
 
+				string FractionRequest:
+
+					Message status "fractioned" indicates
+					that a message is only partially
+					available on the server for now (used
+					by some push-email services).
+					It can be received in fractions.
+					Omitting this parameter causes the
+					server to download and transfer the
+					complete message.
+
+					Possible values: first, next
+
 			Possible errors: org.bluez.obex.Error.InvalidArguments
 					 org.bluez.obex.Error.Failed
 
diff --git a/obexd/client/map.c b/obexd/client/map.c
index b7e6428..e4ea9a0 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -55,6 +55,13 @@
 #define CHARSET_NATIVE 0
 #define CHARSET_UTF8 1
 
+#define FRACTION_REQUEST_FIRST 0
+#define FRACTION_REQUEST_NEXT 1
+
+#define FRACTION_DELIVER_NONE 0xFF
+#define FRACTION_DELIVER_MORE 0
+#define FRACTION_DELIVER_LAST 1
+
 static const char * const filter_list[] = {
 	"subject",
 	"timestamp",
@@ -118,6 +125,7 @@ struct map_msg {
 	char *status;
 	uint64_t attachment_size;
 	uint8_t flags;
+	uint8_t fraction_deliver;
 	GDBusPendingPropertySet pending;
 };
 
@@ -385,6 +393,24 @@ static void map_msg_free(void *data)
 	g_free(msg);
 }
 
+static void msg_get_cb(struct obc_session *session,
+				struct obc_transfer *transfer,
+				GError *err, void *user_data)
+{
+	struct map_msg *msg = user_data;
+	guint8 fraction_deliver;
+	GObexApparam *apparam;
+
+	apparam = obc_transfer_get_apparam(transfer);
+
+	if (apparam && g_obex_apparam_get_uint8(apparam, MAP_AP_FRACTIONDELIVER,
+							&fraction_deliver)) {
+		msg->fraction_deliver = fraction_deliver;
+	} else {
+		msg->fraction_deliver = FRACTION_DELIVER_NONE;
+	}
+}
+
 static GObexApparam *parse_attachment(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
@@ -399,6 +425,28 @@ static GObexApparam *parse_attachment(GObexApparam *apparam,
 						attachment ? TRUE : FALSE);
 }
 
+static GObexApparam *parse_fraction_request(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	guint8 fraction_request;
+	const char *request;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &request);
+
+	if (!g_ascii_strcasecmp(request, "first"))
+		fraction_request = FRACTION_REQUEST_FIRST;
+	else if (!g_ascii_strcasecmp(request, "next"))
+		fraction_request = FRACTION_REQUEST_NEXT;
+	else
+		return NULL;
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_FRACTIONREQUEST,
+							fraction_request);
+}
+
 static GObexApparam *parse_get_options(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
@@ -424,6 +472,9 @@ static GObexApparam *parse_get_options(GObexApparam *apparam,
 		if (strcasecmp(key, "Attachment") == 0) {
 			if (parse_attachment(apparam, &value) == NULL)
 				return NULL;
+		} else if (strcasecmp(key, "FractionRequest") == 0) {
+			if (parse_fraction_request(apparam, &value) == NULL)
+				return NULL;
 		}
 
 		dbus_message_iter_next(&array);
@@ -472,7 +523,8 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 
 	obc_transfer_set_apparam(transfer, apparam);
 
-	if (!obc_session_queue(msg->data->session, transfer, NULL, NULL, &err))
+	if (!obc_session_queue(msg->data->session, transfer,
+							msg_get_cb, msg, &err))
 		goto fail;
 
 	return obc_transfer_create_dbus_reply(transfer, message);
@@ -785,6 +837,31 @@ static void set_deleted(const GDBusPropertyTable *property,
 	set_status(property, iter, id, STATUS_DELETE, data);
 }
 
+static gboolean get_fraction_deliver(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+	const char *fraction_deliver;
+
+	if (msg->fraction_deliver == FRACTION_DELIVER_MORE)
+		fraction_deliver = "more";
+	else if (msg->fraction_deliver == FRACTION_DELIVER_LAST)
+		fraction_deliver = "last";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&fraction_deliver);
+
+	return TRUE;
+}
+
+static gboolean fraction_deliver_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->fraction_deliver != FRACTION_DELIVER_NONE;
+}
+
 static const GDBusMethodTable map_msg_methods[] = {
 	{ GDBUS_METHOD("Get",
 			GDBUS_ARGS({ "targetfile", "s" },
@@ -815,6 +892,8 @@ static const GDBusPropertyTable map_msg_properties[] = {
 	{ "Sent", "b", get_sent },
 	{ "Protected", "b", get_sent },
 	{ "Deleted", "b", NULL, set_deleted },
+	{ "FractionDeliver", "s", get_fraction_deliver, NULL,
+						fraction_deliver_exists },
 	{ }
 };
 
@@ -837,6 +916,7 @@ static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
 	}
 
 	msg->handle = g_strdup(handle);
+	msg->fraction_deliver = FRACTION_DELIVER_NONE;
 	g_hash_table_insert(data->messages, msg->handle, msg);
 
 	return msg;
-- 
1.8.1.4

