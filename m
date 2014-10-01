Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 09/17] android/tester: Add generic hook to handle pdu exchange
Date: Wed,  1 Oct 2014 11:01:31 +0200
Message-Id: <1412154099-28014-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows tester-main to register hooks for certain CID to
automatically perform pdu exchange by registering array of pdu pairs
(request_pdu, response_pdu). When null_pdu is used instead of
request_pdu, response is sent immediately without incoming pdu
verification.

This callback can also handle sdp request<->response with automaticaly
overwriting the transaction ID inside the response pdu to match the one
from request.

'emu_l2cap_cid_data' is used to pass tha appropriate data to the hook
mechanism. It is similar to 'emu_cid_data" used in other testers and
eventually will replace those.
---
 android/tester-a2dp.c  |  1 -
 android/tester-avrcp.c |  1 -
 android/tester-gatt.c  |  1 -
 android/tester-main.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h  | 11 +++++++++++
 5 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index e12844e..59384f9 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -18,7 +18,6 @@
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
-#include "src/shared/util.h"
 
 #include "tester-main.h"
 #include "android/utils.h"
diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 13ffd74..647c0fd 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -18,7 +18,6 @@
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
-#include "src/shared/util.h"
 
 #include "tester-main.h"
 #include "android/utils.h"
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index f182c56..6898935 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -19,7 +19,6 @@
 
 #include "emulator/bthost.h"
 #include "tester-main.h"
-#include "src/shared/util.h"
 
 #define L2CAP_ATT_EXCHANGE_MTU_REQ	0x02
 #define L2CAP_ATT_EXCHANGE_MTU_RSP	0x03
diff --git a/android/tester-main.c b/android/tester-main.c
index 5bf9096..0152374 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2127,6 +2127,54 @@ void emu_add_l2cap_server_action(void)
 	schedule_action_verification(step);
 }
 
+static void print_data(const char *str, void *user_data)
+{
+	tester_debug("tester: %s", str);
+}
+
+static void emu_generic_cid_hook_cb(const void *data, uint16_t len,
+								void *user_data)
+{
+	struct test_data *t_data = tester_get_data();
+	struct emu_l2cap_cid_data *cid_data = user_data;
+	struct pdu_set *pdus = cid_data->pdu;
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	int i;
+
+	for (i = 0; pdus[i].rsp.data; i++) {
+		if (pdus[i].req.data) {
+			if (pdus[i].req.size != len)
+				continue;
+
+			if (memcmp(pdus[i].req.data, data, len))
+				continue;
+		}
+
+		if (pdus[i].rsp.data) {
+			/* overwrite transaction id if its sdp pdu */
+			if (cid_data->is_sdp) {
+				pdus[i].rsp.data[1] = ((uint8_t *) data)[1];
+				pdus[i].rsp.data[2] = ((uint8_t *) data)[2];
+			}
+
+			util_hexdump('>', pdus[i].rsp.data, pdus[i].rsp.size,
+							print_data, NULL);
+
+			bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
+					pdus[i].rsp.data, pdus[i].rsp.size);
+		}
+	}
+}
+
+void tester_handle_l2cap_data_exchange(struct emu_l2cap_cid_data *cid_data)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+
+	bthost_add_cid_hook(bthost, cid_data->handle, cid_data->cid,
+					emu_generic_cid_hook_cb, cid_data);
+}
+
 static void rfcomm_connect_cb(uint16_t handle, uint16_t cid, void *user_data,
 								bool status)
 {
diff --git a/android/tester-main.h b/android/tester-main.h
index 3484c3e..8c619da 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -40,6 +40,7 @@
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
+#include "src/shared/util.h"
 #include "emulator/hciemu.h"
 
 #include <hardware/hardware.h>
@@ -444,6 +445,14 @@ struct emu_set_l2cap_data {
 	void *user_data;
 };
 
+struct emu_l2cap_cid_data {
+	struct pdu_set *pdu;
+
+	uint16_t handle;
+	uint16_t cid;
+	bool is_sdp;
+};
+
 /*
  * Callback data structure should be enhanced with data
  * returned by callbacks. It's used for test case step
@@ -506,6 +515,8 @@ struct test_case {
 	const struct step *step;
 };
 
+void tester_handle_l2cap_data_exchange(struct emu_l2cap_cid_data *cid_data);
+
 /* Get, remove test cases API */
 struct queue *get_bluetooth_tests(void);
 void remove_bluetooth_tests(void);
-- 
1.9.1

