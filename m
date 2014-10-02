Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 03/13] android/tester: Make HidHost tests use io vectors for pdu
Date: Thu,  2 Oct 2014 10:10:51 +0200
Message-Id: <1412237461-20373-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hidhost.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index c7e3a67..0327369 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -59,14 +59,16 @@ struct emu_cid_data {
 
 static struct emu_cid_data cid_data;
 
-static const uint8_t did_req_pdu[] = { 0x06, /* PDU id */
+static const struct iovec did_req_pdu = raw_pdu(
+			0x06, /* PDU id */
 			0x00, 0x00, /* Transaction id */
 			0x00, 0x0f, /* Req length */
 			0x35, 0x03, /* Attributes length */
 			0x19, 0x12, 0x00, 0xff, 0xff, 0x35, 0x05, 0x0a, 0x00,
-			0x00, 0xff, 0xff, 0x00 }; /* no continuation */
+			0x00, 0xff, 0xff, 0x00); /* no continuation */
 
-static const uint8_t did_rsp_pdu[] = { 0x07, /* PDU id */
+static const struct iovec did_rsp_pdu = raw_pdu(
+			0x07, /* PDU id */
 			0x00, 0x00, /* Transaction id */
 			0x00, 0x4f, /* Response length */
 			0x00, 0x4c, /* Attributes length */
@@ -79,9 +81,10 @@ static const uint8_t did_rsp_pdu[] = { 0x07, /* PDU id */
 			0x02, 0x02, 0x09, 0x02, 0x46, 0x09, 0x02, 0x03, 0x09,
 			0x05, 0x0e, 0x09, 0x02, 0x04, 0x28, 0x01, 0x09, 0x02,
 			0x05, 0x09, 0x00, 0x02,
-			0x00 }; /* no continuation */
+			0x00); /* no continuation */
 
-static const uint8_t hid_rsp_pdu[] = { 0x07, /* PDU id */
+static const struct iovec hid_rsp_pdu = raw_pdu(
+			0x07, /* PDU id */
 			0x00, 0x01, /* Transaction id */
 			0x01, 0x71, /* Response length */
 			0x01, 0x6E, /* Attributes length */
@@ -126,7 +129,7 @@ static const uint8_t hid_rsp_pdu[] = { 0x07, /* PDU id */
 			0x28, 0x01, 0x09, 0x02, 0x0b, 0x09, 0x01, 0x00, 0x09,
 			0x02, 0x0c, 0x09, 0x0c, 0x80, 0x09, 0x02, 0x0d, 0x28,
 			0x00, 0x09, 0x02, 0x0e, 0x28, 0x01,
-			0x00 }; /* no continuation */
+			0x00); /* no continuation */
 
 static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
@@ -134,14 +137,14 @@ static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 	struct emu_cid_data *cid_data = user_data;
 
-	if (!memcmp(did_req_pdu, data, len)) {
-		bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
-					did_rsp_pdu, sizeof(did_rsp_pdu));
+	if (!memcmp(did_req_pdu.iov_base, data, len)) {
+		bthost_send_cid_v(bthost, cid_data->sdp_handle,
+					cid_data->sdp_cid, &did_rsp_pdu, 1);
 		return;
 	}
 
-	bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
-					hid_rsp_pdu, sizeof(hid_rsp_pdu));
+	bthost_send_cid_v(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
+							&hid_rsp_pdu, 1);
 }
 static void hid_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
 {
@@ -159,31 +162,20 @@ static void hid_prepare_reply_protocol_mode(struct emu_cid_data *cid_data)
 {
 	struct test_data *t_data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-	uint8_t pdu[2] = { 0, 0 };
-	uint16_t pdu_len = 0;
+	const struct iovec pdu = raw_pdu(0xa0, 0x00);
 
-	pdu_len = 2;
-	pdu[0] = 0xa0;
-	pdu[1] = 0x00;
-
-	bthost_send_cid(bthost, cid_data->ctrl_handle, cid_data->ctrl_cid,
-							(void *)pdu, pdu_len);
+	bthost_send_cid_v(bthost, cid_data->ctrl_handle, cid_data->ctrl_cid,
+								&pdu, 1);
 }
 
 static void hid_prepare_reply_report(struct emu_cid_data *cid_data)
 {
 	struct test_data *t_data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-	uint8_t pdu[3] = { 0, 0, 0 };
-	uint16_t pdu_len = 0;
-
-	pdu_len = 3;
-	pdu[0] = 0xa2;
-	pdu[1] = 0x01;
-	pdu[2] = 0x00;
+	const struct iovec pdu = raw_pdu(0xa2, 0x01, 0x00);
 
-	bthost_send_cid(bthost, cid_data->ctrl_handle, cid_data->ctrl_cid,
-							(void *)pdu, pdu_len);
+	bthost_send_cid_v(bthost, cid_data->ctrl_handle, cid_data->ctrl_cid,
+								&pdu, 1);
 }
 
 static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
-- 
1.9.1

