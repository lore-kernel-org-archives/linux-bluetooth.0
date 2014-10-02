Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 04/13] android/tester: Make PAN tests use io vectors for pdu
Date: Thu,  2 Oct 2014 10:10:52 +0200
Message-Id: <1412237461-20373-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-pan.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index 8d41d34..5aa6c35 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -29,9 +29,10 @@ struct emu_cid_data {
 };
 
 static struct emu_cid_data cid_data;
-static uint8_t pan_conn_req_pdu[] = { 0x01, 0x01, 0x02, 0x11, 0x16,
-								0x11, 0x15 };
-static uint8_t pan_conn_rsp_pdu[] = { 0x01, 0x02, 0x00, 0x00 };
+
+static const struct iovec pan_conn_req_pdu = raw_pdu(0x01, 0x01, 0x02, 0x11,
+							0x16, 0x11, 0x15);
+static const struct iovec pan_conn_rsp_pdu = raw_pdu(0x01, 0x02, 0x00, 0x00);
 
 static void pan_nap_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
@@ -39,10 +40,10 @@ static void pan_nap_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct emu_cid_data *cid_data = user_data;
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 
-	if (!memcmp((uint8_t *) data, pan_conn_req_pdu,
-						sizeof(pan_conn_req_pdu)))
-		bthost_send_cid(bthost, cid_data->nap_handle, cid_data->nap_cid,
-				pan_conn_rsp_pdu, sizeof(pan_conn_rsp_pdu));
+	if (!memcmp((uint8_t *) data, pan_conn_req_pdu.iov_base, len))
+		bthost_send_cid_v(bthost, cid_data->nap_handle,
+							cid_data->nap_cid,
+							&pan_conn_rsp_pdu, 1);
 }
 
 static void pan_connect_request_cb(uint16_t handle, uint16_t cid,
-- 
1.9.1

