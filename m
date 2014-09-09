Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 6/7] android/tester: Fix HIDHost cases sending fixed tid sdp responses
Date: Tue,  9 Sep 2014 09:47:02 +0200
Message-Id: <1410248823-8975-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Multiple cases were affected because of hardcoded transaction id for
emulated remote's SDP responses.

This resulted in the following error in the daemon:
	bluetoothd[13486]: sdp_process: Protocol error.
---
 android/tester-hidhost.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index abff837..d5741f9 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -21,6 +21,7 @@
 #include "tester-main.h"
 
 #include "android/utils.h"
+#include "src/shared/util.h"
 
 #define HID_GET_REPORT_PROTOCOL		0x60
 #define HID_GET_BOOT_PROTOCOL		0x61
@@ -214,15 +215,24 @@ static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 	struct emu_cid_data *cid_data = user_data;
 	struct raw_dataset *sdp_data = cid_data->user_data;
+	const uint8_t *req_buf = data;
+	uint8_t *sdp_buf;
 
-	if (!memcmp(did_req_pdu, data, len)) {
+	if (!memcmp(did_req_pdu, req_buf, len)) {
 		bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
 					did_rsp_pdu, sizeof(did_rsp_pdu));
 		return;
 	}
 
+	/* Get transaction ID from the request */
+	sdp_buf = g_memdup(sdp_data->pdu, sdp_data->len);
+	sdp_buf[1] = req_buf[1];
+	sdp_buf[2] = req_buf[2];
+
 	bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
-					sdp_data->pdu, sdp_data->len);
+							sdp_buf, sdp_data->len);
+
+	g_free(sdp_buf);
 }
 static void hid_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
 {
-- 
1.9.1

