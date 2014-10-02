Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 05/13] android/tester: Make HDP tests use io vectors for pdu
Date: Thu,  2 Oct 2014 10:10:53 +0200
Message-Id: <1412237461-20373-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hdp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index 9ecef21..5602636 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -184,7 +184,8 @@ static void hdp_unregister_app_action(void)
 	schedule_action_verification(step);
 }
 
-static uint8_t hdp_rsp_pdu[] = { 0x07, /* PDU id */
+static const struct iovec hdp_rsp_pdu = raw_pdu(
+			0x07, /* PDU id */
 			0x00, 0x00, /* Transaction id */
 			0x01, 0xc8, /* Response length */
 			0x01, 0xc5, /* Attributes length */
@@ -239,7 +240,7 @@ static uint8_t hdp_rsp_pdu[] = { 0x07, /* PDU id */
 			0x63, 0x6f, 0x73, 0x65, 0x20, 0x4d, 0x65, 0x74, 0x65,
 			0x72, 0x0d, 0x09, 0x03, 0x01, 0x08, 0x01, 0x09, 0x03,
 			0x02, 0x08, 0x00,
-			0x00 };
+			0x00);
 
 static void hdp_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
@@ -247,11 +248,11 @@ static void hdp_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 	struct emu_cid_data *cid_data = user_data;
 
-	hdp_rsp_pdu[1] = ((uint8_t *) data)[1];
-	hdp_rsp_pdu[2] = ((uint8_t *) data)[2];
+	((uint8_t *) hdp_rsp_pdu.iov_base)[1] = ((uint8_t *) data)[1];
+	((uint8_t *) hdp_rsp_pdu.iov_base)[2] = ((uint8_t *) data)[2];
 
-	bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
-					hdp_rsp_pdu, sizeof(hdp_rsp_pdu));
+	bthost_send_cid_v(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
+							&hdp_rsp_pdu, 1);
 }
 
 static void hdp_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
-- 
1.9.1

