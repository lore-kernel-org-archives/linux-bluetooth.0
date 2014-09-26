Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 15/16] android/tester: Make PAN use generic PDU exchange mechanism
Date: Fri, 26 Sep 2014 08:31:16 +0200
Message-Id: <1411713077-19757-16-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1411713077-19757-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411713077-19757-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-pan.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index 1a15d7f..503b9ed 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -23,45 +23,33 @@
 
 static struct queue *list; /* List of pan test cases */
 
-struct emu_cid_data {
-	uint16_t nap_handle;
-	uint16_t nap_cid;
-};
+#define pan_conn_req_pdu 0x01, 0x01, 0x02, 0x11, 0x16, 0x11, 0x15
+#define pan_conn_rsp_pdu 0x01, 0x02, 0x00, 0x00
 
-static struct emu_cid_data cid_data;
-static struct pdu pan_conn_req_pdu = raw_pdu(0x01, 0x01, 0x02, 0x11, 0x16,
-								0x11, 0x15);
-static struct pdu pan_conn_rsp_pdu = raw_pdu(0x01, 0x02, 0x00, 0x00);
+static struct pdu_set pdus[] = {
+	{ raw_pdu(pan_conn_req_pdu), raw_pdu(pan_conn_rsp_pdu) },
+	{ null_pdu, null_pdu },
+};
 
-static void pan_nap_cid_hook_cb(const void *data, uint16_t len, void *user_data)
-{
-	struct test_data *t_data = tester_get_data();
-	struct emu_cid_data *cid_data = user_data;
-	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-
-	if (!memcmp((uint8_t *) data, pan_conn_req_pdu.data,
-							pan_conn_req_pdu.size))
-		bthost_send_cid(bthost, cid_data->nap_handle, cid_data->nap_cid,
-				pan_conn_rsp_pdu.data, pan_conn_rsp_pdu.size);
-}
+static struct emu_l2cap_cid_data cid_data = {
+	.pdu = pdus,
+};
 
 static void pan_connect_request_cb(uint16_t handle, uint16_t cid,
 							void *user_data)
 {
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct emu_l2cap_cid_data *cid_data = user_data;
 
-	cid_data.nap_handle = handle;
-	cid_data.nap_cid = cid;
+	cid_data->handle = handle;
+	cid_data->cid = cid;
 
-	bthost_add_cid_hook(bthost, handle, cid, pan_nap_cid_hook_cb,
-								&cid_data);
+	tester_handle_l2cap_data_exchange(cid_data);
 }
 
 static struct emu_set_l2cap_data l2cap_setup_data = {
 	.psm = 15,
 	.func = pan_connect_request_cb,
-	.user_data = NULL,
+	.user_data = &cid_data,
 };
 
 static void pan_connect_action(void)
-- 
1.9.1

