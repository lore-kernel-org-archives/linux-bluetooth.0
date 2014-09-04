Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 4/6] android/tester: Fix HIDHost cases sending fixed tid sdp responses
Date: Thu,  4 Sep 2014 14:54:59 +0200
Message-Id: <1409835301-12092-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Multiple cases were affected because of hardcoded transaction id for
emulated remote's SDP responses.

This resulted in the following error in the daemon:
	bluetoothd[13486]: sdp_process: Protocol error.

To solve this, sdp response counter was added.
---
 android/tester-hidhost.c | 10 +++++++++-
 android/tester-main.h    |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 479be1e..143b5a6 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -21,6 +21,7 @@
 #include "tester-main.h"
 
 #include "android/utils.h"
+#include "src/shared/util.h"
 
 #define HID_GET_REPORT_PROTOCOL		0x60
 #define HID_GET_BOOT_PROTOCOL		0x61
@@ -214,6 +215,7 @@ static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 	struct emu_cid_data *cid_data = user_data;
 	struct raw_dataset *sdp_data = cid_data->user_data;
+	uint8_t *sdp_buf;
 
 	if (!memcmp(did_req_pdu, data, len)) {
 		bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
@@ -221,8 +223,14 @@ static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 		return;
 	}
 
+	/* Increment transaction id for each SDP response */
+	sdp_buf = g_memdup(sdp_data->pdu, sdp_data->len);
+	put_be16(++t_data->sdp_call_cnt, &sdp_buf[1]);
+
 	bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
-					sdp_data->pdu, sdp_data->len);
+							sdp_buf, sdp_data->len);
+
+	g_free(sdp_buf);
 }
 static void hid_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
 {
diff --git a/android/tester-main.h b/android/tester-main.h
index cb8300d..5fa4649 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -332,6 +332,8 @@ struct test_data {
 
 	struct queue *pdus;
 	bool is_encrypted;
+
+	uint16_t sdp_call_cnt;
 };
 
 /*
-- 
1.9.1

