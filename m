Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/8] android/tester: Add helper functions for sending sdp responses
Date: Tue, 16 Sep 2014 10:49:35 +0200
Message-Id: <1410857377-3162-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These are to help comparing and sending sdp data.
---
 android/tester-main.c | 28 ++++++++++++++++++++++++++++
 android/tester-main.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index 385c00d..edbb35c 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -20,6 +20,7 @@
 #include "tester-main.h"
 
 #include "monitor/bt.h"
+#include "src/shared/util.h"
 
 static char exec_dir[PATH_MAX + 1];
 
@@ -2219,6 +2220,33 @@ void set_default_ssp_request_handler(void)
 	schedule_action_verification(step);
 }
 
+bool tester_match_sdp_pdu(const uint8_t *pdu, uint16_t len,
+						const struct pdu *match_pdu)
+{
+	if (match_pdu->size != len)
+		return false;
+
+	/* Verify PDU ID */
+	if (pdu[0] != match_pdu->data[0])
+		return false;
+
+	/* Skip the transaction id and verify data */
+	return !!!memcmp(pdu + 2, match_pdu + 2, match_pdu->size - 2);
+}
+
+void tester_send_sdp_pdu(struct bthost *bthost, uint16_t handle, uint16_t cid,
+				uint16_t trans_id, const struct pdu *pdu)
+{
+	uint8_t *sdp_buf;
+
+	/* overwrite transaction id */
+	sdp_buf = g_memdup(pdu->data, pdu->size);
+	put_be16(trans_id, sdp_buf + 1);
+
+	bthost_send_cid(bthost, handle, cid, sdp_buf, pdu->size);
+	g_free(sdp_buf);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index 237242f..e0b1693 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -468,6 +468,11 @@ struct test_case {
 	const struct step *step;
 };
 
+bool tester_match_sdp_pdu(const uint8_t *pdu, uint16_t len,
+						const struct pdu *match_pdu);
+void tester_send_sdp_pdu(struct bthost *bthost, uint16_t handle, uint16_t cid,
+				uint16_t trans_id, const struct pdu *pdu);
+
 /* Get, remove test cases API */
 struct queue *get_bluetooth_tests(void);
 void remove_bluetooth_tests(void);
-- 
1.9.3

