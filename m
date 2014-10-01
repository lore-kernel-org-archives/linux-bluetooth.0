Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 12/17] android/tester: Make GATT use generic cid_data
Date: Wed,  1 Oct 2014 11:01:34 +0200
Message-Id: <1412154099-28014-13-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-gatt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 6898935..1460329 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -40,14 +40,6 @@ static bt_uuid_t app1_uuid = {
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
@@ -123,7 +115,7 @@ static bt_property_t prop_test_scan_mode_conn = {
 	.len = sizeof(setprop_scan_mode_conn_val),
 };
 
-static struct emu_cid_data cid_data;
+static struct emu_l2cap_cid_data cid_data;
 
 static struct gatt_connect_data app1_conn_req = {
 	.app_id = APP1_ID,
@@ -853,7 +845,7 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-	struct emu_cid_data *cid_data = user_data;
+	struct emu_l2cap_cid_data *cid_data = user_data;
 	const uint8_t *pdu = data;
 	struct pdu *gatt_pdu = queue_peek_head(t_data->pdus);
 
-- 
1.9.1

