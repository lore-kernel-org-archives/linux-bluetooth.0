Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 06/28] android/hog: Use bt_gatt_client to register for notifications
Date: Wed,  1 Apr 2015 18:40:22 +0200
Message-Id: <1427906444-11769-7-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces g_attrib_register with bt_gatt_client_register_notify
to register for notifications of report reference.

Since bt_gatt_client_notify_callback_t returns a pointer to value
not pdu, notification header is not present and
ATT_NOTIFICATION_HEADER_SIZE can be removed.

There is no need to read and store ccc_handle, because it's already cached
and keep by bt_gatt_client. To register for notification only
characteristic value handle is needed.
---
 android/hog.c | 73 +++++++++++++----------------------------------------------
 1 file changed, 16 insertions(+), 57 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index ec81f0f..3f28ecb 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -78,7 +78,6 @@
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
 #define HID_INFO_SIZE			4
-#define ATT_NOTIFICATION_HEADER_SIZE	3
 
 struct bt_hog {
 	int			ref_count;
@@ -113,14 +112,14 @@ struct report {
 	struct bt_hog		*hog;
 	uint8_t			id;
 	uint8_t			type;
-	uint16_t		ccc_handle;
-	guint			notifyid;
+	uint32_t		notifyid;
 	struct gatt_char	*decl;
 	uint16_t		len;
 	uint8_t			*value;
 };
 
-static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
+static void report_value_cb(uint16_t value_handle, const uint8_t *value,
+						uint16_t len, void *user_data)
 {
 	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
@@ -128,14 +127,6 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	uint8_t *buf;
 	int err;
 
-	if (len < ATT_NOTIFICATION_HEADER_SIZE) {
-		error("Malformed ATT notification");
-		return;
-	}
-
-	pdu += ATT_NOTIFICATION_HEADER_SIZE;
-	len -= ATT_NOTIFICATION_HEADER_SIZE;
-
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_INPUT;
 	buf = ev.u.input.data;
@@ -143,11 +134,11 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	if (hog->has_report_id) {
 		buf[0] = report->id;
 		len = MIN(len, sizeof(ev.u.input.data) - 1);
-		memcpy(buf + 1, pdu, len);
+		memcpy(buf + 1, value, len);
 		ev.u.input.size = ++len;
 	} else {
 		len = MIN(len, sizeof(ev.u.input.data));
-		memcpy(buf, pdu, len);
+		memcpy(buf, value, len);
 		ev.u.input.size = len;
 	}
 
@@ -160,55 +151,23 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	DBG("HoG report (%u bytes)", ev.u.input.size);
 }
 
-static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void report_ccc_written_cb(uint16_t status, void *user_data)
 {
-	struct report *report = user_data;
-	struct bt_hog *hog = report->hog;
-
 	if (status != 0) {
 		error("Write report characteristic descriptor failed: %s",
 							att_ecode2str(status));
 		return;
 	}
 
-	report->notifyid = g_attrib_register(hog->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					report->decl->value_handle,
-					report_value_cb, report, NULL);
-
 	DBG("Report characteristic descriptor written: notifications enabled");
 }
 
-static void write_ccc(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
-							void *user_data)
-{
-	uint8_t value[2];
-
-	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
-
-	gatt_write_char(attrib, handle, value, sizeof(value),
-					report_ccc_written_cb, user_data);
-}
-
-static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
-{
-	struct report *report = user_data;
-
-	if (status != 0) {
-		error("Error reading CCC value: %s", att_ecode2str(status));
-		return;
-	}
-
-	write_ccc(report->hog, report->hog->attrib, report->ccc_handle, report);
-}
-
 static void report_reference_cb(bool success, uint8_t status,
 					const uint8_t *value, uint16_t length,
 					void *user_data)
 {
 	struct report *report = user_data;
+	struct bt_gatt_client *client = report->hog->client;
 
 	if (!success) {
 		error("Read Report Reference descriptor failed: %s",
@@ -227,8 +186,10 @@ static void report_reference_cb(bool success, uint8_t status,
 
 	/* Enable notifications only for Input Reports */
 	if (report->type == HOG_REPORT_TYPE_INPUT)
-		gatt_read_char(report->hog->attrib, report->ccc_handle,
-							ccc_read_cb, report);
+		report->notifyid = bt_gatt_client_register_notify(client,
+						report->decl->value_handle,
+						report_ccc_written_cb,
+						report_value_cb, report, NULL);
 }
 
 static void external_report_reference_cb(bool success, uint8_t status,
@@ -283,9 +244,6 @@ static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
 		struct gatt_desc *desc = descs->data;
 
 		switch (desc->uuid16) {
-		case GATT_CLIENT_CHARAC_CFG_UUID:
-			report->ccc_handle = desc->handle;
-			break;
 		case GATT_REPORT_REFERENCE:
 			bt_gatt_client_read_value(hog->client, desc->handle,
 					report_reference_cb, report, NULL);
@@ -1198,10 +1156,10 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
-
-		r->notifyid = g_attrib_register(hog->attrib,
-					ATT_OP_HANDLE_NOTIFY,
+		if (r->type == HOG_REPORT_TYPE_INPUT)
+			r->notifyid = bt_gatt_client_register_notify(client,
 					r->decl->value_handle,
+					report_ccc_written_cb,
 					report_value_cb, r, NULL);
 	}
 
@@ -1227,7 +1185,8 @@ void bt_hog_detach(struct bt_hog *hog)
 		struct report *r = l->data;
 
 		if (r->notifyid > 0) {
-			g_attrib_unregister(hog->attrib, r->notifyid);
+			bt_gatt_client_unregister_notify(hog->client,
+								r->notifyid);
 			r->notifyid = 0;
 		}
 	}
-- 
1.9.1

