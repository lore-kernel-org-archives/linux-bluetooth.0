Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 25/25] android/scpp: Add guard for GATT callbacks
Date: Tue,  9 Dec 2014 16:11:47 +0100
Message-Id: <1418137907-16981-26-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/scpp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/scpp.c b/android/scpp.c
index 448c7a5..5c75496 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -142,6 +142,15 @@ static void discover_desc(struct bt_scpp *scpp, GAttrib *attrib,
 	free(req);
 }
 
+static bool scpp_is_connected(struct bt_scpp *scpp)
+{
+	if (scpp && scpp->attrib)
+		return true;
+
+	info("scpp: SCPP disconnected!");
+	return false;
+}
+
 static void write_char(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
 					const uint8_t *value, size_t vlen,
 					GAttribResultFunc func,
@@ -248,6 +257,9 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 
 	destroy_gatt_req(req);
 
+	if (!scpp_is_connected(scan))
+		return;
+
 	if (status != 0) {
 		error("Write Scan Refresh CCC failed: %s",
 						att_ecode2str(status));
@@ -281,6 +293,9 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 
 	destroy_gatt_req(req);
 
+	if (!scpp_is_connected(scan))
+		return;
+
 	if (status != 0) {
 		error("Discover descriptors failed: %s", att_ecode2str(status));
 		return;
@@ -303,6 +318,9 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 
 	destroy_gatt_req(req);
 
+	if (!scpp_is_connected(scan))
+		return;
+
 	if (status) {
 		error("Scan Refresh %s", att_ecode2str(status));
 		return;
@@ -339,6 +357,9 @@ static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	destroy_gatt_req(req);
 
+	if (!scpp_is_connected(scan))
+		return;
+
 	if (status) {
 		error("Discover Scan Interval Window: %s",
 						att_ecode2str(status));
-- 
1.8.4

