Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 3/4] Add response handling for MAP client
Date: Tue, 22 Nov 2011 15:46:37 +0100
Message-Id: <1321973198-23091-3-git-send-email-bulislaw@linux.com>
In-Reply-To: <1321973198-23091-1-git-send-email-bulislaw@linux.com>
References: <1321973198-23091-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/map.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/client/map.c b/client/map.c
index 54ab9c0..4f3eb89 100644
--- a/client/map.c
+++ b/client/map.c
@@ -50,13 +50,41 @@ struct map_data {
 	DBusMessage *msg;
 };
 
+static struct error_code {
+	const char *name;
+	guint8 code;
+} map_errors[] = {
+	{"Success", G_OBEX_RSP_SUCCESS},
+	{"Bad Request", G_OBEX_RSP_BAD_REQUEST},
+	{"Not Implemented", G_OBEX_RSP_NOT_IMPLEMENTED},
+	{"Service Unavailable", G_OBEX_RSP_SERVICE_UNAVAILABLE},
+	{"Forbidden", G_OBEX_RSP_FORBIDDEN},
+	{"Unauthorized", G_OBEX_RSP_UNAUTHORIZED},
+	{"Precondition Failed", G_OBEX_RSP_PRECONDITION_FAILED},
+	{"Not Acceptable", G_OBEX_RSP_NOT_ACCEPTABLE},
+	{"Not Found", G_OBEX_RSP_NOT_FOUND},
+	{ }
+};
+
 static DBusConnection *conn = NULL;
 
+static const char *get_error_string(guint8 err_code)
+{
+	struct error_code *error;
+
+	for (error = map_errors; error != NULL; error++)
+		if (error->code == err_code)
+			return error->name;
+
+	return NULL;
+}
+
 static void simple_cb(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
 	DBusMessage *reply;
 	struct map_data *map = user_data;
+	guint8 err_code = g_obex_packet_get_operation(rsp, NULL);
 
 	if (err != NULL) {
 		reply = g_dbus_create_error(map->msg,
@@ -64,6 +92,11 @@ static void simple_cb(GObex *obex, GError *err, GObexPacket *rsp,
 						"%s", err->message);
 
 		g_error_free(err);
+	} else if (err_code != G_OBEX_RSP_SUCCESS) {
+		reply = g_dbus_create_error(map->msg,
+					"org.openobex.Error.Response",
+					"%s(0x%X)", get_error_string(err_code),
+					err_code);
 	} else {
 		reply = dbus_message_new_method_return(map->msg);
 	}
-- 
1.7.4.1

