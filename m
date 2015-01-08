Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 03/11] android/tester: Support remote sending pdu from fragments
Date: Thu,  8 Jan 2015 10:17:41 +0100
Message-Id: <1420708669-32600-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This handles multiple iovectors instead of one assembled pdu.
---
 android/tester-gatt.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 610c1b4..a8dbd35 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -1704,17 +1704,44 @@ static void gatt_remote_send_raw_pdu_action(void)
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct iovec *pdu = current_data_step->set_data;
+	struct iovec *pdu2 = current_data_step->set_data_2;
+	struct iovec *pdu3 = current_data_step->set_data_3;
 	struct step *step = g_new0(struct step, 1);
 
 	if (cid_data.handle && cid_data.cid) {
-		bthost_send_cid_v(bthost, cid_data.handle, cid_data.cid,
-									pdu, 1);
+		struct iovec rsp[3];
+		size_t len = 0;
+
+		if (!pdu) {
+			step->action_status = BT_STATUS_FAIL;
+			goto done;
+		}
+
+		rsp[0].iov_base = pdu->iov_base;
+		rsp[0].iov_len = pdu->iov_len;
+		len++;
+
+		if (pdu2) {
+			rsp[1].iov_base = pdu2->iov_base;
+			rsp[1].iov_len = pdu2->iov_len;
+			len++;
+		}
+
+		if (pdu3) {
+			rsp[2].iov_base = pdu3->iov_base;
+			rsp[2].iov_len = pdu3->iov_len;
+			len++;
+		}
+
+		bthost_send_cid_v(bthost, cid_data.handle, cid_data.cid, rsp,
+									len);
 		step->action_status = BT_STATUS_SUCCESS;
 	} else {
 		tester_debug("No connection set up");
 		step->action_status = BT_STATUS_FAIL;
 	}
 
+done:
 	schedule_action_verification(step);
 }
 
-- 
1.9.1

