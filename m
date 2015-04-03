Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 05/27] android/hog: Use bt_gatt_client to read characteristic value
Date: Fri,  3 Apr 2015 15:43:34 +0200
Message-Id: <1428068636-13073-6-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces gatt_read_char from gattib library with equivalent
bt_gatt_client_read_value function. It requires some changes in declaration
list of callbacks. Since the actual value is read, not pdu, some changes
in code are necessary.
---
 android/hog.c | 149 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 69 insertions(+), 80 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 458ddc4..32109c2 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -204,25 +204,26 @@ static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 	write_ccc(report->hog, report->hog->attrib, report->ccc_handle, report);
 }
 
-static void report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void report_reference_cb(bool success, uint8_t status,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
 {
 	struct report *report = user_data;
 
-	if (status != 0) {
+	if (!success) {
 		error("Read Report Reference descriptor failed: %s",
 							att_ecode2str(status));
 		return;
 	}
 
-	if (plen != 3) {
+	if (length != 2) {
 		error("Malformed ATT read response");
 		return;
 	}
 
-	report->id = pdu[1];
-	report->type = pdu[2];
-	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
+	report->id = value[0];
+	report->type = value[1];
+	DBG("Report ID: 0x%02x Report type: 0x%02x", value[0], value[1]);
 
 	/* Enable notifications only for Input Reports */
 	if (report->type == HOG_REPORT_TYPE_INPUT)
@@ -230,8 +231,9 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 							ccc_read_cb, report);
 }
 
-static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data);
+static void external_report_reference_cb(bool success, uint8_t status,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
 
 static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
 {
@@ -246,9 +248,8 @@ static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
 	for ( ; descs; descs = descs->next) {
 		struct gatt_desc *desc = descs->data;
 
-		gatt_read_char(hog->attrib, desc->handle,
-						external_report_reference_cb,
-						hog);
+		bt_gatt_client_read_value(hog->client, desc->handle,
+				external_report_reference_cb, hog, NULL);
 	}
 }
 
@@ -286,8 +287,8 @@ static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
 			report->ccc_handle = desc->handle;
 			break;
 		case GATT_REPORT_REFERENCE:
-			gatt_read_char(hog->attrib, desc->handle,
-						report_reference_cb, report);
+			bt_gatt_client_read_value(hog->client, desc->handle,
+					report_reference_cb, report, NULL);
 			break;
 		}
 	}
@@ -304,20 +305,22 @@ static void discover_report(struct bt_hog *hog, GAttrib *attrib,
 								user_data);
 }
 
-static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void report_read_cb(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t len,
+				void *user_data)
 {
 	struct report *report = user_data;
 
-	if (status != 0) {
-		error("Error reading Report value: %s", att_ecode2str(status));
+	if (!success) {
+		error("Error reading Report value: %s",
+						att_ecode2str(att_ecode));
 		return;
 	}
 
 	if (report->value)
 		g_free(report->value);
 
-	report->value = g_memdup(pdu, len);
+	report->value = g_memdup(value, len);
 	report->len = len;
 }
 
@@ -330,7 +333,8 @@ static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
 	report->decl = g_memdup(chr, sizeof(*chr));
 	hog->reports = g_slist_append(hog->reports, report);
 
-	gatt_read_char(hog->attrib, chr->value_handle, report_read_cb, report);
+	bt_gatt_client_read_value(hog->client, chr->value_handle,
+						report_read_cb, report, NULL);
 
 	return report;
 }
@@ -366,25 +370,26 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 	}
 }
 
-static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void external_report_reference_cb(bool success, uint8_t status,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
 {
 	struct bt_hog *hog = user_data;
 	uint16_t uuid16;
 	bt_uuid_t uuid;
 
-	if (status != 0) {
+	if (!success) {
 		error("Read External Report Reference descriptor failed: %s",
 							att_ecode2str(status));
 		return;
 	}
 
-	if (plen != 3) {
+	if (length != 2) {
 		error("Malformed ATT read response");
 		return;
 	}
 
-	uuid16 = get_le16(&pdu[1]);
+	uuid16 = get_le16(value);
 	DBG("External report reference read, external report characteristic "
 						"UUID: 0x%04x", uuid16);
 
@@ -595,8 +600,8 @@ fail:
 	set_report_cb(err, NULL, 0, hog);
 }
 
-static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void get_report_cb(bool success, uint8_t status, const uint8_t *value,
+					uint16_t len, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 	struct uhid_event rsp;
@@ -608,7 +613,7 @@ static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
 	rsp.type = UHID_GET_REPORT_REPLY;
 	rsp.u.get_report_reply.id = hog->getrep_id;
 
-	if (status != 0) {
+	if (!success) {
 		error("Error reading Report value: %s", att_ecode2str(status));
 		goto exit;
 	}
@@ -619,21 +624,21 @@ static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
 		goto exit;
 	}
 
-	if (pdu[0] != 0x0b) {
-		error("Error reading Report, invalid response: %02x", pdu[0]);
+	if (value[0] != 0x0b) {
+		error("Error reading Report, invalid response: %02x", value[0]);
 		status = EPROTO;
 		goto exit;
 	}
 
 	--len;
-	++pdu;
+	++value;
 	if (hog->has_report_id && len > 0) {
 		--len;
-		++pdu;
+		++value;
 	}
 
 	rsp.u.get_report_reply.size = len;
-	memcpy(rsp.u.get_report_reply.data, pdu, len);
+	memcpy(rsp.u.get_report_reply.data, value, len);
 
 exit:
 	rsp.u.get_report_reply.err = status;
@@ -650,7 +655,7 @@ static void get_report(struct uhid_event *ev, void *user_data)
 
 	/* uhid never sends reqs in parallel; if there's a req, it timed out */
 	if (hog->getrep_att) {
-		g_attrib_cancel(hog->attrib, hog->getrep_att);
+		bt_gatt_client_cancel(hog->client, hog->getrep_att);
 		hog->getrep_att = 0;
 	}
 
@@ -663,9 +668,9 @@ static void get_report(struct uhid_event *ev, void *user_data)
 		goto fail;
 	}
 
-	hog->getrep_att = gatt_read_char(hog->attrib,
+	hog->getrep_att = bt_gatt_client_read_value(hog->client,
 						report->decl->value_handle,
-						get_report_cb, hog);
+						get_report_cb, hog, NULL);
 	if (!hog->getrep_att) {
 		err = ENOMEM;
 		goto fail;
@@ -675,11 +680,11 @@ static void get_report(struct uhid_event *ev, void *user_data)
 
 fail:
 	/* cancel the request on failure */
-	get_report_cb(err, NULL, 0, hog);
+	get_report_cb(false, err, NULL, 0, hog);
 }
 
-static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
-								bool *is_long)
+static bool get_descriptor_item_info(const uint8_t *buf, ssize_t blen,
+						ssize_t *len, bool *is_long)
 {
 	if (!blen)
 		return false;
@@ -718,7 +723,7 @@ static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
 	return *len <= blen;
 }
 
-static char *item2string(char *str, uint8_t *buf, uint8_t len)
+static char *item2string(char *str, const uint8_t *buf, uint8_t len)
 {
 	char *p = str;
 	int i;
@@ -740,25 +745,18 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
 	return str;
 }
 
-static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void report_map_read_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t vlen,
+					void *user_data)
 {
 	struct bt_hog *hog = user_data;
-	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
 	struct uhid_event ev;
-	ssize_t vlen;
 	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
 	int i, err;
 	GError *gerr = NULL;
 
-	if (status != 0) {
-		error("Report Map read failed: %s", att_ecode2str(status));
-		return;
-	}
-
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
-	if (vlen < 0) {
-		error("ATT protocol error");
+	if (!success) {
+		error("Report Map read failed: %s", att_ecode2str(att_ecode));
 		return;
 	}
 
@@ -805,7 +803,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	ev.u.create.version = hog->version;
 	ev.u.create.country = hog->bcountrycode;
 	ev.u.create.bus = BUS_BLUETOOTH;
-	ev.u.create.rd_data = value;
+	ev.u.create.rd_data = (uint8_t *) value;
 	ev.u.create.rd_size = vlen;
 
 	err = bt_uhid_send(hog->uhid, &ev);
@@ -820,20 +818,16 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
 }
 
-static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void info_read_cb(bool success, uint8_t status, const uint8_t *value,
+					uint16_t vlen, void *user_data)
 {
 	struct bt_hog *hog = user_data;
-	uint8_t value[HID_INFO_SIZE];
-	ssize_t vlen;
 
-	if (status != 0) {
-		error("HID Information read failed: %s",
-						att_ecode2str(status));
+	if (!success) {
+		error("HID Information read failed: %s", att_ecode2str(status));
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
 	if (vlen != 4) {
 		error("ATT protocol error");
 		return;
@@ -847,33 +841,26 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			hog->bcdhid, hog->bcountrycode, hog->flags);
 }
 
-static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void proto_mode_read_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
 {
 	struct bt_hog *hog = user_data;
-	uint8_t value;
-	ssize_t vlen;
 
-	if (status != 0) {
+	if (!success) {
 		error("Protocol Mode characteristic read failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	vlen = dec_read_resp(pdu, plen, &value, sizeof(value));
-	if (vlen < 0) {
-		error("ATT protocol error");
+						att_ecode2str(att_ecode));
 		return;
 	}
 
-	if (value == HOG_PROTO_MODE_BOOT) {
+	if (value[0] == HOG_PROTO_MODE_BOOT) {
 		uint8_t nval = HOG_PROTO_MODE_REPORT;
 
 		DBG("HoG is operating in Boot Procotol Mode");
 
 		gatt_write_cmd(hog->attrib, hog->proto_mode_handle, &nval,
 						sizeof(nval), NULL, NULL);
-	} else if (value == HOG_PROTO_MODE_REPORT)
+	} else if (value[0] == HOG_PROTO_MODE_REPORT)
 		DBG("HoG is operating in Report Protocol Mode");
 }
 
@@ -919,8 +906,9 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 			report = report_new(hog, chr);
 			discover_report(hog, hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
-			gatt_read_char(hog->attrib, chr->value_handle,
-						report_map_read_cb, hog);
+			bt_gatt_client_read_long_value(hog->client,
+				chr->value_handle, 0, report_map_read_cb,
+				hog, NULL);
 			discover_external(hog, hog->attrib, start, end, hog);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
@@ -932,12 +920,13 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	if (proto_mode_handle) {
 		hog->proto_mode_handle = proto_mode_handle;
-		gatt_read_char(hog->attrib, proto_mode_handle,
-						proto_mode_read_cb, hog);
+		bt_gatt_client_read_value(hog->client, proto_mode_handle,
+						proto_mode_read_cb, hog, NULL);
 	}
 
 	if (info_handle)
-		gatt_read_char(hog->attrib, info_handle, info_read_cb, hog);
+		bt_gatt_client_read_value(hog->client, info_handle,
+						info_read_cb, hog, NULL);
 }
 
 static void report_free(void *data)
-- 
1.9.1

