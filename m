Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 02/11] android/tester: Add macro improving pdu send procedure
Date: Thu,  8 Jan 2015 10:17:40 +0100
Message-Id: <1420708669-32600-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As of now when we want to send response from remote device, we compose
pdu from handle and value, which are then copied into fixed size pdu
with predefined header. With this macro we will be able to pass up to
3 iovectors which are then send without additional copying. It also
quite generic and can be used to any other kind of data processing nad
not only for sending pdus.
---
 android/tester-gatt.c |  2 +-
 android/tester-main.h | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index f4d22fd..610c1b4 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -1079,7 +1079,7 @@ static void gatt_att_pdu_modify(void)
 {
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
-	struct iovec *store_pdu = current_data_step->set_data_to;
+	struct iovec *store_pdu = current_data_step->set_data_2;
 	struct step *step = g_new0(struct step, 1);
 	unsigned char *raw_pdu = store_pdu->iov_base;
 	int set_data_len = current_data_step->set_data_len;
diff --git a/android/tester-main.h b/android/tester-main.h
index 7fe73fe..e35feec 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -68,10 +68,18 @@ struct pdu_set {
 		.action_status = status, \
 		.action = modif_fun, \
 		.set_data = from, \
-		.set_data_to = to, \
+		.set_data_2 = to, \
 		.set_data_len = len, \
 	}
 
+#define PROCESS_DATA(status, proc_fun, data1, data2, data3) { \
+		.action_status = status, \
+		.action = proc_fun, \
+		.set_data = data1, \
+		.set_data_2 = data2, \
+		.set_data_3 = data3, \
+	}
+
 #define ACTION(status, act_fun, data_set) { \
 		.action_status = status, \
 		.action = act_fun, \
@@ -706,7 +714,8 @@ struct step {
 	struct bt_callback_data callback_result;
 
 	void *set_data;
-	void *set_data_to;
+	void *set_data_2;
+	void *set_data_3;
 	int set_data_len;
 
 	uint16_t *store_srvc_handle;
-- 
1.9.1

