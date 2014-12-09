Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 18/25] android/bas: Add guard to GATT callbacks
Date: Tue,  9 Dec 2014 16:11:40 +0100
Message-Id: <1418137907-16981-19-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bas.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/bas.c b/android/bas.c
index 8dcf4af..49ec8a5 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -225,6 +225,15 @@ static void discover_desc(struct bt_bas *bas, GAttrib *attrib,
 	free(req);
 }
 
+static bool bas_is_connected(struct bt_bas *bas)
+{
+	if (bas && bas->attrib)
+		return true;
+
+	info("bas: BAS is not connected");
+	return false;
+}
+
 static void value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	DBG("Battery Level at %u", pdu[ATT_NOTIFICATION_HEADER_SIZE]);
@@ -238,6 +247,9 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 
 	destroy_gatt_req(req);
 
+	if (!bas_is_connected(bas))
+		return;
+
 	if (status != 0) {
 		error("Write Scan Refresh CCC failed: %s",
 						att_ecode2str(status));
@@ -269,6 +281,9 @@ static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 
 	destroy_gatt_req(req);
 
+	if (!bas_is_connected(bas))
+		return;
+
 	if (status != 0) {
 		error("Error reading CCC value: %s", att_ecode2str(status));
 		return;
@@ -286,6 +301,9 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 
 	destroy_gatt_req(req);
 
+	if (!bas_is_connected(bas))
+		return;
+
 	if (status != 0) {
 		error("Discover descriptors failed: %s", att_ecode2str(status));
 		return;
@@ -308,6 +326,9 @@ static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	destroy_gatt_req(req);
 
+	if (!bas_is_connected(bas))
+		return;
+
 	if (status) {
 		error("Battery: %s", att_ecode2str(status));
 		return;
-- 
1.8.4

