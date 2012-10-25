Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 12/18] cyclingspeed: Add stub to use SC Control Point
Date: Thu, 25 Oct 2012 16:43:42 +0200
Message-ID: <1351176228-5789-13-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements common functions to use SC Control Point.
Individual procedures will be implemented in subsequent patches.
---
 profiles/cyclingspeed/cyclingspeed.c | 145 +++++++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 5 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 4f48121..93b91a2 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -41,6 +41,11 @@
 #include "log.h"
 #include "cyclingspeed.h"
 
+/* min length for ATT indication or notification: opcode (1b) + handle (2b) */
+#define ATT_HDR_LEN 3
+
+#define ATT_TIMEOUT 30
+
 #define CYCLINGSPEED_MANAGER_INTERFACE	"org.bluez.CyclingSpeedManager"
 #define CYCLINGSPEED_WATCHER_INTERFACE	"org.bluez.CyclingSpeedWatcher"
 #define CYCLINGSPEED_INTERFACE		"org.bluez.CyclingSpeed"
@@ -52,6 +57,25 @@
 #define WHEEL_REV_PRESENT	0x01
 #define CRANK_REV_PRESENT	0x02
 
+#define SET_CUMULATIVE_VALUE		0x01
+#define START_SENSOR_CALIBRATION	0x02
+#define UPDATE_SENSOR_LOC		0x03
+#define REQUEST_SUPPORTED_SENSOR_LOC	0x04
+#define RESPONSE_CODE			0x10
+
+#define RSP_SUCCESS		0x01
+#define RSP_NOT_SUPPORTED	0x02
+#define RSP_INVALID_PARAM	0x03
+#define RSP_FAILED		0x04
+
+struct csc;
+
+struct controlpoint_req {
+	struct csc		*csc;
+	uint8_t			opcode;
+	guint			timeout;
+};
+
 struct csc_adapter {
 	struct btd_adapter	*adapter;
 	GSList			*devices;	/* list of registered devices */
@@ -66,6 +90,8 @@ struct csc {
 	guint			attioid;
 	/* attio id for measurement characteristics value notifications */
 	guint			attio_measurement_id;
+	/* attio id for SC Control Point characteristics value indications */
+	guint			attio_controlpoint_id;
 
 	struct att_range	*svc_range;
 
@@ -75,6 +101,8 @@ struct csc {
 	uint16_t		feature;
 	gboolean		has_location;
 	uint8_t			location;
+
+	struct controlpoint_req	*pending_req;
 };
 
 struct watcher {
@@ -216,6 +244,7 @@ static void destroy_csc(gpointer user_data)
 
 	if (csc->attrib != NULL) {
 		g_attrib_unregister(csc->attrib, csc->attio_measurement_id);
+		g_attrib_unregister(csc->attrib, csc->attio_controlpoint_id);
 		g_attrib_unref(csc->attrib);
 	}
 
@@ -235,6 +264,35 @@ static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
 	g_free(msg);
 }
 
+static gboolean controlpoint_timeout(gpointer user_data)
+{
+	struct controlpoint_req *req = user_data;
+
+	req->csc->pending_req = NULL;
+	g_free(req);
+
+	return FALSE;
+}
+
+__attribute__((unused)) /* TODO: remove once controlpoint ops are implemented */
+static void controlpoint_write_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct controlpoint_req *req = user_data;
+
+	if (status != 0) {
+		error("SC Control Point write failed (opcode=%d)", req->opcode);
+
+		req->csc->pending_req = NULL;
+		g_free(req);
+
+		return;
+	}
+
+	req->timeout = g_timeout_add_seconds(ATT_TIMEOUT, controlpoint_timeout,
+									req);
+}
+
 static void read_feature_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -312,6 +370,8 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 	for (i = 0; i < list->num; i++) {
 		uint8_t *value;
 		uint16_t handle, uuid;
+		uint8_t attr_val[2];
+		char *msg;
 
 		value = list->data[i];
 		handle = att_get_u16(value);
@@ -321,9 +381,6 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 			continue;
 
 		if (g_strcmp0(ch->uuid, CSC_MEASUREMENT_UUID) == 0) {
-			char *msg;
-			uint8_t attr_val[2];
-
 			ch->csc->measurement_ccc_handle = handle;
 
 			if (g_slist_length(ch->csc->cadapter->watchers) == 0) {
@@ -335,10 +392,16 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 				msg = g_strdup("Enable measurement");
 			}
 
-			gatt_write_char(ch->csc->attrib, handle, attr_val,
-					sizeof(attr_val), char_write_cb, msg);
+		} else if (g_strcmp0(ch->uuid, SC_CONTROL_POINT_UUID) == 0) {
+			att_put_u16(GATT_CLIENT_CHARAC_CFG_IND_BIT, attr_val);
+			msg = g_strdup("Enable SC Control Point indications");
+		} else {
+			break;
 		}
 
+		gatt_write_char(ch->csc->attrib, handle, attr_val,
+					sizeof(attr_val), char_write_cb, msg);
+
 		/* We only want CCC, can break here */
 		break;
 	}
@@ -476,6 +539,67 @@ static void measurement_notify_handler(const uint8_t *pdu, uint16_t len,
 	process_measurement(csc, pdu + 3, len - 3);
 }
 
+static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct csc *csc = user_data;
+	struct controlpoint_req *req = csc->pending_req;
+	uint8_t opcode;
+	uint8_t req_opcode;
+	uint8_t *opdu;
+	uint16_t olen;
+	size_t plen;
+
+	if (len < ATT_HDR_LEN) {
+		error("Invalid PDU received");
+		return;
+	}
+
+	/* skip ATT header */
+	pdu += ATT_HDR_LEN;
+	len -= ATT_HDR_LEN;
+
+	if (len < 1) {
+		error("Op Code missing");
+		goto done;
+	}
+
+	opcode = *pdu;
+	pdu++;
+	len--;
+
+	if (opcode != RESPONSE_CODE) {
+		DBG("Unsupported Op Code received (%d)", opcode);
+		goto done;
+	}
+
+	if (len < 2) {
+		error("Invalid Response Code PDU received");
+		goto done;
+	}
+
+	req_opcode = *pdu;
+	/* skip response code for now */
+	pdu += 2;
+	len -= 2;
+
+	if (req == NULL || req->opcode != req_opcode) {
+		DBG("Indication received without pending request");
+		goto done;
+	}
+
+	/* TODO: handle response */
+
+	csc->pending_req = NULL;
+	g_source_remove(req->timeout);
+	g_free(req);
+
+done:
+	opdu = g_attrib_get_buffer(csc->attrib, &plen);
+	olen = enc_confirmation(opdu, plen);
+	if (olen > 0)
+		g_attrib_send(csc->attrib, 0, opdu, olen, NULL, NULL, NULL);
+}
 
 static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 {
@@ -509,6 +633,12 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 		} else if (g_strcmp0(c->uuid, SC_CONTROL_POINT_UUID) == 0) {
 			DBG("SC Control Point supported");
 			csc->controlpoint_val_handle = c->value_handle;
+
+			csc->attio_controlpoint_id = g_attrib_register(
+					csc->attrib, ATT_OP_HANDLE_IND,
+					c->value_handle,
+					controlpoint_ind_handler, csc, NULL);
+
 			discover_desc(csc, c, c_next);
 		}
 	}
@@ -576,6 +706,11 @@ static void attio_disconnected_cb(gpointer user_data)
 		csc->attio_measurement_id = 0;
 	}
 
+	if (csc->attio_controlpoint_id > 0) {
+		g_attrib_unregister(csc->attrib, csc->attio_controlpoint_id);
+		csc->attio_controlpoint_id = 0;
+	}
+
 	g_attrib_unref(csc->attrib);
 	csc->attrib = NULL;
 }
-- 
1.8.0

