Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/4] android/pan: Add notify method to PAN notifications
Date: Tue, 12 Nov 2013 16:20:41 +0200
Message-Id: <1384266042-6344-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384266042-6344-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384266042-6344-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-pan.c | 6 ++++++
 android/hal.h     | 1 +
 2 files changed, 7 insertions(+)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index bec179f..78d526c 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -31,6 +31,12 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
+void bt_notify_pan(uint16_t opcode, void *buf, uint16_t len)
+{
+	if (!interface_ready())
+		return;
+}
+
 static bt_status_t pan_enable(int local_role)
 {
 	struct hal_cmd_pan_enable cmd;
diff --git a/android/hal.h b/android/hal.h
index 2ce7932..be5d491 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -31,3 +31,4 @@ void bt_thread_associate(void);
 void bt_thread_disassociate(void);
 void bt_notify_hidhost(uint16_t opcode, void *buf, uint16_t len);
 void bt_notify_a2dp(uint16_t opcode, void *buf, uint16_t len);
+void bt_notify_pan(uint16_t opcode, void *buf, uint16_t len);
-- 
1.8.3.2

