Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 4/4] android/pan: Remove connected PAN devices on profile unregister call
Date: Tue,  7 Jan 2014 14:31:20 +0200
Message-Id: <1389097880-14783-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389097880-14783-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389097880-14783-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/pan.c b/android/pan.c
index 0e12245..b933196 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -760,10 +760,20 @@ bool bt_pan_register(const bdaddr_t *addr)
 	return true;
 }
 
+static void pan_device_disconnected(gpointer data, gpointer user_data)
+{
+	struct pan_device *dev = data;
+
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+}
+
 void bt_pan_unregister(void)
 {
 	DBG("");
 
+	g_slist_foreach(devices, pan_device_disconnected, NULL);
+	devices = NULL;
+
 	bnep_cleanup();
 
 	ipc_unregister(HAL_SERVICE_ID_PAN);
-- 
1.8.3.2

