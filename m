Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 2/3] android/pan: Add notify method to PAN notifications
Date: Wed, 13 Nov 2013 11:25:26 +0200
Message-Id: <1384334727-25940-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384334727-25940-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384334727-25940-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-pan.c | 6 ++++++
 android/hal.h     | 1 +
 2 files changed, 7 insertions(+)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index bec179f..851c5d2 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -31,6 +31,12 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
+void bt_notify_pan(uint8_t opcode, void *buf, uint16_t len)
+{
+	if (!interface_ready())
+		return;
+}
+
 static bt_status_t pan_enable(int local_role)
 {
 	struct hal_cmd_pan_enable cmd;
diff --git a/android/hal.h b/android/hal.h
index baa4754..72090fe 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -31,3 +31,4 @@ void bt_thread_associate(void);
 void bt_thread_disassociate(void);
 void bt_notify_hidhost(uint8_t opcode, void *buf, uint16_t len);
 void bt_notify_a2dp(uint8_t opcode, void *buf, uint16_t len);
+void bt_notify_pan(uint8_t opcode, void *buf, uint16_t len);
-- 
1.8.3.2

