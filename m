Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 06/17] android/tester: Make PAN tests use generic pdu struct
Date: Wed,  1 Oct 2014 11:01:28 +0200
Message-Id: <1412154099-28014-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-pan.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index 8d41d34..dfc8c04 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -29,9 +29,9 @@ struct emu_cid_data {
 };
 
 static struct emu_cid_data cid_data;
-static uint8_t pan_conn_req_pdu[] = { 0x01, 0x01, 0x02, 0x11, 0x16,
-								0x11, 0x15 };
-static uint8_t pan_conn_rsp_pdu[] = { 0x01, 0x02, 0x00, 0x00 };
+static const struct pdu pan_conn_req_pdu = raw_pdu(0x01, 0x01, 0x02, 0x11, 0x16,
+								0x11, 0x15);
+static const struct pdu pan_conn_rsp_pdu = raw_pdu(0x01, 0x02, 0x00, 0x00);
 
 static void pan_nap_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
@@ -39,10 +39,10 @@ static void pan_nap_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct emu_cid_data *cid_data = user_data;
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 
-	if (!memcmp((uint8_t *) data, pan_conn_req_pdu,
-						sizeof(pan_conn_req_pdu)))
+	if (!memcmp((uint8_t *) data, pan_conn_req_pdu.data,
+							pan_conn_req_pdu.size))
 		bthost_send_cid(bthost, cid_data->nap_handle, cid_data->nap_cid,
-				pan_conn_rsp_pdu, sizeof(pan_conn_rsp_pdu));
+				pan_conn_rsp_pdu.data, pan_conn_rsp_pdu.size);
 }
 
 static void pan_connect_request_cb(uint16_t handle, uint16_t cid,
-- 
1.9.1

