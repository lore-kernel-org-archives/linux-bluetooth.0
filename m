Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 14/18] cyclingspeed: Add support for Update Sensor Location
Date: Thu, 25 Oct 2012 16:43:44 +0200
Message-ID: <1351176228-5789-15-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 116 ++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 164a525..bf8ea46 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -74,6 +74,7 @@ struct controlpoint_req {
 	struct csc		*csc;
 	uint8_t			opcode;
 	guint			timeout;
+	GDBusPendingReply	reply_id;
 };
 
 struct csc_adapter {
@@ -148,6 +149,17 @@ static const gchar *location2str(uint8_t value)
 	return location_enum[0];
 }
 
+static int str2location(const char *location)
+{
+	size_t i;
+
+	for (i = 0; i < G_N_ELEMENTS(location_enum); i++)
+		if (!strcmp(location_enum[i], location))
+			return i;
+
+	return -1;
+}
+
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
 {
 	const struct csc_adapter *cadapter = a;
@@ -271,6 +283,12 @@ static gboolean controlpoint_timeout(gpointer user_data)
 {
 	struct controlpoint_req *req = user_data;
 
+	if (req->opcode == UPDATE_SENSOR_LOC) {
+		g_dbus_pending_property_error(req->reply_id,
+				ERROR_INTERFACE ".Failed",
+				"Operation failed (timeout)");
+	}
+
 	req->csc->pending_req = NULL;
 	g_free(req);
 
@@ -285,6 +303,12 @@ static void controlpoint_write_cb(guint8 status, const guint8 *pdu, guint16 len,
 	if (status != 0) {
 		error("SC Control Point write failed (opcode=%d)", req->opcode);
 
+		if (req->opcode == UPDATE_SENSOR_LOC) {
+			g_dbus_pending_property_error(req->reply_id,
+					ERROR_INTERFACE ".Failed",
+					"Operation failed (%d)", status);
+		}
+
 		req->csc->pending_req = NULL;
 		g_free(req);
 
@@ -558,6 +582,40 @@ static void measurement_notify_handler(const uint8_t *pdu, uint16_t len,
 	process_measurement(csc, pdu + 3, len - 3);
 }
 
+static void controlpoint_property_reply(struct controlpoint_req *req,
+								uint8_t code)
+{
+	switch (code) {
+	case RSP_SUCCESS:
+		g_dbus_pending_property_success(req->reply_id);
+		break;
+
+	case RSP_NOT_SUPPORTED:
+		g_dbus_pending_property_error(req->reply_id,
+					ERROR_INTERFACE ".NotSupported",
+					"Feature is not supported");
+		break;
+
+	case RSP_INVALID_PARAM:
+		g_dbus_pending_property_error(req->reply_id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		break;
+
+	case RSP_FAILED:
+		g_dbus_pending_property_error(req->reply_id,
+					ERROR_INTERFACE ".Failed",
+					"Operation failed");
+		break;
+
+	default:
+		g_dbus_pending_property_error(req->reply_id,
+					ERROR_INTERFACE ".Failed",
+					"Operation failed (%d)", code);
+		break;
+	}
+}
+
 static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
@@ -565,6 +623,7 @@ static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
 	struct controlpoint_req *req = csc->pending_req;
 	uint8_t opcode;
 	uint8_t req_opcode;
+	uint8_t rsp_code;
 	uint8_t *opdu;
 	uint16_t olen;
 	size_t plen;
@@ -598,7 +657,7 @@ static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
 	}
 
 	req_opcode = *pdu;
-	/* skip response code for now */
+	rsp_code = *(pdu + 1);
 	pdu += 2;
 	len -= 2;
 
@@ -616,6 +675,10 @@ static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
 			error("Failed to read Supported Sendor Locations");
 		}
 		break;
+
+	case UPDATE_SENSOR_LOC:
+		controlpoint_property_reply(req, rsp_code);
+		break;
 	}
 
 	csc->pending_req = NULL;
@@ -884,6 +947,55 @@ static gboolean property_get_location(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void property_set_location(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					GDBusPendingPropertySet id, void *data)
+{
+	struct csc *csc = data;
+	char *loc;
+	int loc_val;
+	uint8_t att_val[2];
+	struct controlpoint_req *req;
+
+	if (csc->pending_req != NULL)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InProgress",
+					"Operation already in progress");
+
+	if (!(csc->feature & MULTI_SENSOR_LOC_SUPPORT))
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".NotSupported",
+					"Feature is not supported");
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(iter, &loc);
+
+	loc_val = str2location(loc);
+
+	if (loc_val < 0)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	req = g_new(struct controlpoint_req, 1);
+	req->csc = csc;
+	req->reply_id = id;
+	req->opcode = UPDATE_SENSOR_LOC;
+
+	csc->pending_req = req;
+
+	att_val[0] = UPDATE_SENSOR_LOC;
+	att_val[1] = loc_val;
+
+	gatt_write_char(csc->attrib, csc->controlpoint_val_handle, att_val,
+		sizeof(att_val), controlpoint_write_cb, req);
+
+}
+
 static gboolean property_exists_location(const GDBusPropertyTable *property,
 								void *data)
 {
@@ -948,7 +1060,7 @@ static gboolean property_get_multi_loc_sup(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable cyclingspeed_device_properties[] = {
-	{ "Location", "s", property_get_location, NULL,
+	{ "Location", "s", property_get_location, property_set_location,
 						property_exists_location },
 	{ "SupportedLocations", "as", property_get_locations, NULL,
 						property_exists_locations },
-- 
1.8.0

