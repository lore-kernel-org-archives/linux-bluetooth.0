Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 21/25] android/dis: Add guard for GATT callbacks
Date: Tue,  9 Dec 2014 16:11:43 +0100
Message-Id: <1418137907-16981-22-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/dis.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/dis.c b/android/dis.c
index 0200ab8..e754084 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -75,6 +75,15 @@ static void destroy_gatt_req(struct gatt_request *req)
 	free(req);
 }
 
+static bool dis_is_connected(struct bt_dis *dis)
+{
+	if (dis && dis->attrib)
+		return true;
+
+	info("dis: DIS disconnected!");
+	return false;
+}
+
 static void dis_free(struct bt_dis *dis)
 {
 	bt_dis_detach(dis);
@@ -158,6 +167,9 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 
 	destroy_gatt_req(req);
 
+	if (!dis_is_connected(dis))
+		return;
+
 	if (status != 0) {
 		error("Error reading PNP_ID value: %s", att_ecode2str(status));
 		return;
@@ -238,6 +250,9 @@ static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
 
 	destroy_gatt_req(req);
 
+	if (!dis_is_connected(d))
+		return;
+
 	if (status != 0) {
 		error("Discover deviceinfo characteristics: %s",
 							att_ecode2str(status));
-- 
1.8.4

