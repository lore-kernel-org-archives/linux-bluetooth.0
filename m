Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 09/13] android/tester: Make GATT use generic cid_data
Date: Thu,  2 Oct 2014 10:10:57 +0200
Message-Id: <1412237461-20373-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-gatt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index cb0b377..acad195 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -41,14 +41,6 @@ static bt_uuid_t app1_uuid = {
 				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
 };
 
-struct emu_cid_data {
-	const int pdu_len;
-	const void *pdu;
-
-	uint16_t handle;
-	uint16_t cid;
-};
-
 struct gatt_connect_data {
 	const int app_id;
 	const int conn_id;
@@ -124,7 +116,7 @@ static bt_property_t prop_test_scan_mode_conn = {
 	.len = sizeof(setprop_scan_mode_conn_val),
 };
 
-static struct emu_cid_data cid_data;
+static struct emu_l2cap_cid_data cid_data;
 
 static struct gatt_connect_data app1_conn_req = {
 	.app_id = APP1_ID,
@@ -854,7 +846,7 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-	struct emu_cid_data *cid_data = user_data;
+	struct emu_l2cap_cid_data *cid_data = user_data;
 	const uint8_t *pdu = data;
 	struct iovec *gatt_pdu = queue_peek_head(t_data->pdus);
 
-- 
1.9.1

