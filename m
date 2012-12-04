Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 14/20] cyclingspeed: Add support for Set Cumulative Value
Date: Tue, 4 Dec 2012 13:43:40 +0100
Message-ID: <1354625026-29358-15-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 92 +++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 58ccf74..8cc7028 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -76,6 +76,7 @@ struct controlpoint_req {
 	uint8_t			opcode;
 	guint			timeout;
 	GDBusPendingReply	reply_id;
+	DBusMessage		*msg;
 
 	uint8_t			pending_location;
 };
@@ -290,6 +291,15 @@ static gboolean controlpoint_timeout(gpointer user_data)
 		g_dbus_pending_property_error(req->reply_id,
 				ERROR_INTERFACE ".Failed",
 				"Operation failed (timeout)");
+	} else if (req->opcode == SET_CUMULATIVE_VALUE) {
+		DBusMessage *reply;
+
+		reply = btd_error_failed(req->msg,
+						"Operation failed (timeout)");
+
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+		dbus_message_unref(req->msg);
 	}
 
 	req->csc->pending_req = NULL;
@@ -310,6 +320,15 @@ static void controlpoint_write_cb(guint8 status, const guint8 *pdu, guint16 len,
 			g_dbus_pending_property_error(req->reply_id,
 					ERROR_INTERFACE ".Failed",
 					"Operation failed (%d)", status);
+		} else if  (req->opcode == SET_CUMULATIVE_VALUE) {
+			DBusMessage *reply;
+
+			reply = btd_error_failed(req->msg,
+						"Operation failed");
+
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+			dbus_message_unref(req->msg);
 		}
 
 		req->csc->pending_req = NULL;
@@ -624,6 +643,34 @@ static void controlpoint_property_reply(struct controlpoint_req *req,
 	}
 }
 
+static void controlpoint_method_reply(struct controlpoint_req *req,
+								uint8_t code)
+{
+	DBusMessage *reply;
+
+	switch (code) {
+	case RSP_SUCCESS:
+		reply = dbus_message_new_method_return(req->msg);
+		break;
+	case RSP_NOT_SUPPORTED:
+		reply = btd_error_not_supported(req->msg);
+		break;
+	case RSP_INVALID_PARAM:
+		reply = btd_error_invalid_args(req->msg);
+		break;
+	case RSP_FAILED:
+		reply = btd_error_failed(req->msg, "Failed");
+		break;
+	default:
+		reply = btd_error_failed(req->msg, "Unknown error");
+		break;
+	}
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	dbus_message_unref(req->msg);
+}
+
 static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
@@ -675,6 +722,10 @@ static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
 	}
 
 	switch (req->opcode) {
+	case SET_CUMULATIVE_VALUE:
+		controlpoint_method_reply(req, rsp_code);
+		break;
+
 	case REQUEST_SUPPORTED_SENSOR_LOC:
 		if (rsp_code == RSP_SUCCESS) {
 			csc->num_locations = len;
@@ -1083,6 +1134,44 @@ static const GDBusPropertyTable cyclingspeed_device_properties[] = {
 	{ }
 };
 
+static DBusMessage *set_cumulative_wheel_rev(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct csc *csc = data;
+	dbus_uint32_t value;
+	struct controlpoint_req *req;
+	uint8_t att_val[5]; /* uint8 opcode + uint32 value */
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &value,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	if (csc->pending_req != NULL)
+		return btd_error_in_progress(msg);
+
+	req = g_new(struct controlpoint_req, 1);
+	req->csc = csc;
+	req->opcode = SET_CUMULATIVE_VALUE;
+	req->msg = dbus_message_ref(msg);
+
+	csc->pending_req = req;
+
+	att_val[0] = SET_CUMULATIVE_VALUE;
+	att_put_u32(value, att_val + 1);
+
+	gatt_write_char(csc->attrib, csc->controlpoint_val_handle, att_val,
+		sizeof(att_val), controlpoint_write_cb, req);
+
+	return NULL;
+}
+
+static const GDBusMethodTable cyclingspeed_device_methods[] = {
+	{ GDBUS_ASYNC_METHOD("SetCumulativeWheelRevolutions",
+			GDBUS_ARGS({ "value", "u" }), NULL,
+			set_cumulative_wheel_rev) },
+	{ }
+};
+
 static gint cmp_primary_uuid(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_primary *prim = a;
@@ -1122,7 +1211,8 @@ static int csc_device_probe(struct btd_profile *p,
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 						device_get_path(device),
 						CYCLINGSPEED_INTERFACE,
-						NULL, NULL,
+						cyclingspeed_device_methods,
+						NULL,
 						cyclingspeed_device_properties,
 						csc, destroy_csc)) {
 		error("D-Bus failed to register %s interface",
-- 
1.8.0

