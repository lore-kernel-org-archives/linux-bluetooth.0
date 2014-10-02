Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 07/13] android/tester: Make A2DP use generic pdu exchange mechanism
Date: Thu,  2 Oct 2014 10:10:55 +0200
Message-Id: <1412237461-20373-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-a2dp.c | 51 +++++++++------------------------------------------
 1 file changed, 9 insertions(+), 42 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 1ff628e..dcb7f79 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -25,13 +25,6 @@
 
 static struct queue *list;
 
-struct emu_cid_data {
-	uint16_t handle;
-	uint16_t cid;
-};
-
-static struct emu_cid_data cid_data;
-
 #define req_dsc 0x00, 0x01
 #define rsp_dsc 0x02, 0x01, 0x04, 0x08
 #define req_get 0x10, 0x02, 0x04
@@ -61,54 +54,28 @@ static const struct pdu_set pdus[] = {
 	{ end_pdu, end_pdu },
 };
 
-static void print_data(const char *str, void *user_data)
-{
-	tester_debug("a2dp: %s", str);
-}
-
-static void a2dp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
-{
-	struct emu_cid_data *cid_data = user_data;
-	struct test_data *t_data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-	int i;
-
-	util_hexdump('>', data, len, print_data, NULL);
-
-	for (i = 0; pdus[i].req.iov_base; i++) {
-		if (pdus[i].req.iov_len != len)
-			continue;
-
-		if (memcmp(pdus[i].req.iov_base, data, len))
-			continue;
-
-		util_hexdump('<', pdus[i].rsp.iov_base, pdus[i].rsp.iov_len,
-							print_data, NULL);
-
-		bthost_send_cid_v(bthost, cid_data->handle, cid_data->cid,
-							&pdus[i].rsp, 1);
-	}
-}
+static struct emu_l2cap_cid_data cid_data = {
+	.pdu = pdus,
+};
 
 static void a2dp_connect_request_cb(uint16_t handle, uint16_t cid,
 							void *user_data)
 {
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct emu_l2cap_cid_data *cid_data = user_data;
 
-	if (cid_data.handle)
+	if (cid_data->handle)
 		return;
 
-	cid_data.handle = handle;
-	cid_data.cid = cid;
+	cid_data->handle = handle;
+	cid_data->cid = cid;
 
-	bthost_add_cid_hook(bthost, handle, cid, a2dp_cid_hook_cb, &cid_data);
+	tester_handle_l2cap_data_exchange(cid_data);
 }
 
 static struct emu_set_l2cap_data l2cap_setup_data = {
 	.psm = 25,
 	.func = a2dp_connect_request_cb,
-	.user_data = NULL,
+	.user_data = &cid_data,
 };
 
 static void a2dp_connect_action(void)
-- 
1.9.1

