Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 06/13] android/tester: Add generic hook to handle pdu exchange
Date: Thu,  2 Oct 2014 10:10:54 +0200
Message-Id: <1412237461-20373-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows tester-main to register hooks for certain CID to
automatically perform pdu exchange by registering array of pdu pairs
(request_pdu, response_pdu). When end_pdu is used instead of
request_pdu, response is sent immediately without incoming pdu
verification. A pair with end_pdus set as request and response is
considered as the end of pdu pairs array.

This callback can also handle sdp request<->response while transaction
ID for the response is swaped to match the one from SDP request.

'emu_l2cap_cid_data' is used to pass tha appropriate data to the hook
mechanism. It is similar to 'emu_cid_data" used in other testers and
eventually will replace those.
---
 android/tester-main.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h | 10 +++++++++
 2 files changed, 71 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index 5bf9096..5ef0401 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -16,6 +16,7 @@
  */
 #include <stdbool.h>
 
+#include "src/shared/util.h"
 #include "emulator/bthost.h"
 #include "tester-main.h"
 
@@ -2127,6 +2128,66 @@ void emu_add_l2cap_server_action(void)
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
+	const struct pdu_set *pdus = cid_data->pdu;
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	int i;
+
+	for (i = 0; pdus[i].rsp.iov_base; i++) {
+		if (pdus[i].req.iov_base) {
+			if (pdus[i].req.iov_len != len)
+				continue;
+
+			if (memcmp(pdus[i].req.iov_base, data, len))
+				continue;
+		}
+
+		if (pdus[i].rsp.iov_base) {
+			util_hexdump('>', pdus[i].rsp.iov_base,
+					pdus[i].rsp.iov_len, print_data, NULL);
+
+			/* if its sdp pdu use transaction ID from request */
+			if (cid_data->is_sdp) {
+				struct iovec rsp[3];
+
+				rsp[0].iov_base = pdus[i].rsp.iov_base;
+				rsp[0].iov_len = 1;
+
+				rsp[1].iov_base = ((uint8_t *) data) + 1;
+				rsp[1].iov_len = 2;
+
+				rsp[2].iov_base = pdus[i].rsp.iov_base + 3;
+				rsp[2].iov_len = pdus[i].rsp.iov_len - 3;
+
+				bthost_send_cid_v(bthost, cid_data->handle,
+							cid_data->cid, rsp, 3);
+			} else {
+				bthost_send_cid_v(bthost, cid_data->handle,
+						cid_data->cid, &pdus[i].rsp, 1);
+			}
+
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
index 3ebad2b..aa56cd2 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -439,6 +439,14 @@ struct emu_set_l2cap_data {
 	void *user_data;
 };
 
+struct emu_l2cap_cid_data {
+	const struct pdu_set *pdu;
+
+	uint16_t handle;
+	uint16_t cid;
+	bool is_sdp;
+};
+
 /*
  * Callback data structure should be enhanced with data
  * returned by callbacks. It's used for test case step
@@ -501,6 +509,8 @@ struct test_case {
 	const struct step *step;
 };
 
+void tester_handle_l2cap_data_exchange(struct emu_l2cap_cid_data *cid_data);
+
 /* Get, remove test cases API */
 struct queue *get_bluetooth_tests(void);
 void remove_bluetooth_tests(void);
-- 
1.9.1

