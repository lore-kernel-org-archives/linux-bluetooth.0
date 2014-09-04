Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/6] android/tester: Allow HIDHost to use custom sdp response
Date: Thu,  4 Sep 2014 14:54:56 +0200
Message-Id: <1409835301-12092-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed to test security levels for different devices. So far we
had Mouse device but, we need to test security level elevation for
keyboards.
---
 android/tester-hidhost.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index c7e3a67..b454db4 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -55,10 +55,17 @@ struct emu_cid_data {
 	uint16_t ctrl_cid;
 	uint16_t intr_handle;
 	uint16_t intr_cid;
+
+	void *user_data;
 };
 
 static struct emu_cid_data cid_data;
 
+struct raw_dataset {
+	const void *pdu;
+	int len;
+};
+
 static const uint8_t did_req_pdu[] = { 0x06, /* PDU id */
 			0x00, 0x00, /* Transaction id */
 			0x00, 0x0f, /* Req length */
@@ -128,11 +135,17 @@ static const uint8_t hid_rsp_pdu[] = { 0x07, /* PDU id */
 			0x00, 0x09, 0x02, 0x0e, 0x28, 0x01,
 			0x00 }; /* no continuation */
 
+static struct raw_dataset hid_rsp_data = {
+	.pdu = hid_rsp_pdu,
+	.len = sizeof(hid_rsp_pdu),
+};
+
 static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 	struct emu_cid_data *cid_data = user_data;
+	struct raw_dataset *sdp_data = cid_data->user_data;
 
 	if (!memcmp(did_req_pdu, data, len)) {
 		bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
@@ -141,7 +154,7 @@ static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	}
 
 	bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
-					hid_rsp_pdu, sizeof(hid_rsp_pdu));
+					sdp_data->pdu, sdp_data->len);
 }
 static void hid_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
 {
@@ -150,6 +163,7 @@ static void hid_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
 
 	cid_data.sdp_handle = handle;
 	cid_data.sdp_cid = cid;
+	cid_data.user_data = user_data;
 
 	bthost_add_cid_hook(bthost, handle, cid, hid_sdp_cid_hook_cb,
 								&cid_data);
@@ -267,7 +281,7 @@ static void hid_intr_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
 static struct emu_set_l2cap_data l2cap_setup_sdp_data = {
 	.psm = 1,
 	.func = hid_sdp_search_cb,
-	.user_data = NULL,
+	.user_data = &hid_rsp_data,
 };
 
 /* Emulate Control Channel (PSM = 17) */
-- 
1.9.1

