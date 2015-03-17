Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/hog: Remove read Protocol Mode characteristic
Date: Tue, 17 Mar 2015 15:57:44 +0100
Message-Id: <1426604264-791-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We can faster set up a connection with HOG device if we won't
read Protocol Mode characteristic. According to HOGP specification:
"There is no requirements on Report Host to use the Protocol Mode
characteristic" ... "The Report Host may discover the Protocol Mode
characteristic for each HID Service on the GATT server."
It is used mainly by Boot Host to set the value to Boot
Protocol mode.
According to HID specification "Report protocol is the default
mode for all HID devices" so every HID device shall operate in
report protocol mode by default.
---
 android/hog.c | 51 ++-------------------------------------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index ff77bb3..c27af86 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -63,16 +63,12 @@
 #define HOG_INFO_UUID		0x2A4A
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
-#define HOG_PROTO_MODE_UUID	0x2A4E
 #define HOG_CONTROL_POINT_UUID	0x2A4C
 
 #define HOG_REPORT_TYPE_INPUT	1
 #define HOG_REPORT_TYPE_OUTPUT	2
 #define HOG_REPORT_TYPE_FEATURE	3
 
-#define HOG_PROTO_MODE_BOOT    0
-#define HOG_PROTO_MODE_REPORT  1
-
 #define HOG_REPORT_MAP_MAX_SIZE        512
 #define HID_INFO_SIZE			4
 #define ATT_NOTIFICATION_HEADER_SIZE	3
@@ -91,7 +87,6 @@ struct bt_hog {
 	gboolean		has_report_id;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
-	uint16_t		proto_mode_handle;
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
 	unsigned int		getrep_att;
@@ -1038,49 +1033,16 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			hog->bcdhid, hog->bcountrycode, hog->flags);
 }
 
-static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-	uint8_t value;
-	ssize_t vlen;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Protocol Mode characteristic read failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	vlen = dec_read_resp(pdu, plen, &value, sizeof(value));
-	if (vlen < 0) {
-		error("ATT protocol error");
-		return;
-	}
-
-	if (value == HOG_PROTO_MODE_BOOT) {
-		uint8_t nval = HOG_PROTO_MODE_REPORT;
-
-		DBG("HoG is operating in Boot Procotol Mode");
-
-		gatt_write_cmd(hog->attrib, hog->proto_mode_handle, &nval,
-						sizeof(nval), NULL, NULL);
-	} else if (value == HOG_PROTO_MODE_REPORT)
-		DBG("HoG is operating in Report Protocol Mode");
-}
-
 static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
 	struct gatt_request *req = user_data;
 	struct bt_hog *hog = req->user_data;
 	struct gatt_primary *primary = hog->primary;
 	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
-	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
+	bt_uuid_t ctrlpt_uuid;
 	struct report *report;
 	GSList *l;
-	uint16_t info_handle = 0, proto_mode_handle = 0;
+	uint16_t info_handle = 0;
 
 	destroy_gatt_req(req);
 
@@ -1093,7 +1055,6 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
 	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
 	bt_uuid16_create(&info_uuid, HOG_INFO_UUID);
-	bt_uuid16_create(&proto_mode_uuid, HOG_PROTO_MODE_UUID);
 	bt_uuid16_create(&ctrlpt_uuid, HOG_CONTROL_POINT_UUID);
 
 	for (l = chars; l; l = g_slist_next(l)) {
@@ -1121,18 +1082,10 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 			discover_external(hog, hog->attrib, start, end, hog);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
-		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
-			proto_mode_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &ctrlpt_uuid) == 0)
 			hog->ctrlpt_handle = chr->value_handle;
 	}
 
-	if (proto_mode_handle) {
-		hog->proto_mode_handle = proto_mode_handle;
-		read_char(hog, hog->attrib, proto_mode_handle,
-						proto_mode_read_cb, hog);
-	}
-
 	if (info_handle)
 		read_char(hog, hog->attrib, info_handle, info_read_cb, hog);
 }
-- 
1.9.1

