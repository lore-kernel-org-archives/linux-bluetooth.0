Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/8] android/tester: Simplify ACTION_FAIL and ACTION_SUCCESS defines
Date: Tue,  2 Sep 2014 14:04:24 +0200
Message-Id: <1409659471-25171-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-main.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/android/tester-main.h b/android/tester-main.h
index 77f7660..171dbee 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -68,24 +68,18 @@
 		(struct step[]) {__VA_ARGS__}, \
 	}
 
-#define ACTION_SUCCESS(act_fun, data_set) { \
-		.action_status = BT_STATUS_SUCCESS, \
-		.action = act_fun, \
-		.set_data = data_set, \
-	}
-
-#define ACTION_FAIL(act_fun, data_set) { \
-		.action_status = BT_STATUS_FAIL, \
-		.action = act_fun, \
-		.set_data = data_set, \
-	}
-
 #define ACTION(status, act_fun, data_set) { \
 		.action_status = status, \
 		.action = act_fun, \
 		.set_data = data_set, \
 	}
 
+#define ACTION_FAIL(act_fun, data_set) \
+		ACTION(BT_STATUS_FAIL, act_fun, data_set)
+
+#define ACTION_SUCCESS(act_fun, data_set) \
+		ACTION(BT_STATUS_SUCCESS, act_fun, data_set)
+
 #define CALLBACK(cb) { \
 		.callback = cb, \
 	}
-- 
1.9.0

