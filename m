Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 8/8] android/tester: Expose pdu set and matching function to be reused
Date: Tue, 16 Sep 2014 10:49:37 +0200
Message-Id: <1410857377-3162-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

So far this is used by avrcp and a2dp tests, but we could try to
implement this way of pdu matching and responding in other testers.
---
 android/tester-a2dp.c    | 22 +++-------------------
 android/tester-avrcp.c   | 22 +++-------------------
 android/tester-gatt.c    |  1 -
 android/tester-hidhost.c |  1 -
 android/tester-main.c    | 24 +++++++++++++++++++++++-
 android/tester-main.h    | 10 ++++++++++
 6 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 7e06ec4..35ba27f 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -18,7 +18,6 @@
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
-#include "src/shared/util.h"
 
 #include "tester-main.h"
 #include "android/utils.h"
@@ -50,10 +49,7 @@ static struct emu_cid_data cid_data;
 #define req_suspend	0x50, 0x09, 0x04
 #define rsp_suspend	0x52, 0x09
 
-const struct pdu_set {
-	struct pdu req;
-	struct pdu rsp;
-} pdus[] = {
+const struct pdu_set pdus[] = {
 	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc) },
 	{ raw_pdu(req_get), raw_pdu(rsp_get) },
 	{ raw_pdu(req_cfg), raw_pdu(rsp_cfg) },
@@ -74,23 +70,11 @@ static void a2dp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct emu_cid_data *cid_data = user_data;
 	struct test_data *t_data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-	int i;
 
 	util_hexdump('>', data, len, print_data, NULL);
 
-	for (i = 0; pdus[i].req.data; i++) {
-		if (pdus[i].req.size != len)
-			continue;
-
-		if (memcmp(pdus[i].req.data, data, len))
-			continue;
-
-		util_hexdump('<', pdus[i].rsp.data, pdus[i].rsp.size,
-							print_data, NULL);
-
-		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-					pdus[i].rsp.data, pdus[i].rsp.size);
-	}
+	tester_send_matching_pdu_resp(bthost, cid_data->handle, cid_data->cid,
+						pdus, data, len, print_data);
 }
 
 static void a2dp_connect_request_cb(uint16_t handle, uint16_t cid,
diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 6beab7d..527fc25 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -18,7 +18,6 @@
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
-#include "src/shared/util.h"
 
 #include "tester-main.h"
 #include "android/utils.h"
@@ -73,10 +72,7 @@ static struct pdu sdp_rsp_pdu = raw_pdu(
 #define req_suspend 0x50, 0x09, 0x04
 #define rsp_suspend 0x52, 0x09
 
-static const struct pdu_set {
-	const struct pdu req;
-	const struct pdu rsp;
-} pdus[] = {
+static const struct pdu_set pdus[] = {
 	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc)},
 	{ raw_pdu(req_get), raw_pdu(rsp_get)},
 	{ raw_pdu(req_cfg), raw_pdu(rsp_cfg)},
@@ -126,23 +122,11 @@ static void a2dp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct emu_cid_data *cid_data = user_data;
 	struct test_data *t_data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-	int i;
 
 	util_hexdump('>', data, len, print_a2dp, NULL);
 
-	for (i = 0; pdus[i].req.data; i++) {
-		if (pdus[i].req.size != len)
-			continue;
-
-		if (memcmp(pdus[i].req.data, data, len))
-			continue;
-
-		util_hexdump('<', pdus[i].rsp.data, pdus[i].rsp.size,
-							print_a2dp, NULL);
-
-		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-					pdus[i].rsp.data, pdus[i].rsp.size);
-	}
+	tester_send_matching_pdu_resp(bthost, cid_data->handle, cid_data->cid,
+						pdus, data, len, print_a2dp);
 }
 
 static void a2dp_connect_request_cb(uint16_t handle, uint16_t cid,
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 5defce0..db6fede 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -19,7 +19,6 @@
 
 #include "emulator/bthost.h"
 #include "tester-main.h"
-#include "src/shared/util.h"
 
 #define L2CAP_ATT_EXCHANGE_MTU_REQ		0x02
 #define L2CAP_ATT_EXCHANGE_MTU_RSP		0x03
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 0fe9c0a..6f524f2 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -21,7 +21,6 @@
 #include "tester-main.h"
 
 #include "android/utils.h"
-#include "src/shared/util.h"
 
 #define HID_GET_REPORT_PROTOCOL		0x60
 #define HID_GET_BOOT_PROTOCOL		0x61
diff --git a/android/tester-main.c b/android/tester-main.c
index edbb35c..b254c89 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -20,7 +20,6 @@
 #include "tester-main.h"
 
 #include "monitor/bt.h"
-#include "src/shared/util.h"
 
 static char exec_dir[PATH_MAX + 1];
 
@@ -2247,6 +2246,29 @@ void tester_send_sdp_pdu(struct bthost *bthost, uint16_t handle, uint16_t cid,
 	g_free(sdp_buf);
 }
 
+void tester_send_matching_pdu_resp(struct bthost *bthost, uint16_t handle,
+				uint16_t cid, const struct pdu_set *pdus,
+				const uint8_t *data, uint16_t data_len,
+				util_debug_func_t function)
+{
+	int i;
+
+	for (i = 0; pdus[i].req.data; i++) {
+		if (pdus[i].req.size != data_len)
+			continue;
+
+		if (memcmp(pdus[i].req.data, data, data_len))
+			continue;
+
+		if (function)
+			util_hexdump('<', pdus[i].rsp.data, pdus[i].rsp.size,
+							function, NULL);
+
+		bthost_send_cid(bthost, handle, cid, pdus[i].rsp.data,
+							pdus[i].rsp.size);
+	}
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index e0b1693..e39e75e 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -41,6 +41,7 @@
 #include "src/shared/hciemu.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
+#include "src/shared/util.h"
 
 #include <hardware/hardware.h>
 #include <hardware/audio.h>
@@ -60,6 +61,11 @@ struct pdu {
 	uint16_t size;
 };
 
+struct pdu_set {
+	const struct pdu req;
+	const struct pdu rsp;
+};
+
 #define raw_data(args...) ((const unsigned char[]) { args })
 
 #define raw_pdu(args...)					\
@@ -472,6 +478,10 @@ bool tester_match_sdp_pdu(const uint8_t *pdu, uint16_t len,
 						const struct pdu *match_pdu);
 void tester_send_sdp_pdu(struct bthost *bthost, uint16_t handle, uint16_t cid,
 				uint16_t trans_id, const struct pdu *pdu);
+void tester_send_matching_pdu_resp(struct bthost *bthost, uint16_t handle,
+				uint16_t cid, const struct pdu_set *pdus,
+				const uint8_t *data, uint16_t data_len,
+				util_debug_func_t function);
 
 /* Get, remove test cases API */
 struct queue *get_bluetooth_tests(void);
-- 
1.9.3

