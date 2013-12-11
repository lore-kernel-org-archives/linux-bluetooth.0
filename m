Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 09/10] android/pan: Free connected pan devices on profile unregister call
Date: Wed, 11 Dec 2013 12:13:44 +0200
Message-Id: <1386756825-934-10-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/pan.c b/android/pan.c
index 0783357..29b0a54 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -361,10 +361,20 @@ bool bt_pan_register(const bdaddr_t *addr)
 	return true;
 }
 
+static void free_pan_devices(gpointer data, gpointer user_data)
+{
+	struct pan_device *dev = data;
+
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+	pan_device_free(dev);
+}
+
 void bt_pan_unregister(void)
 {
 	DBG("");
 
+	g_slist_foreach(devices, free_pan_devices, NULL);
+	devices = NULL;
 	bnep_cleanup();
 
 	ipc_unregister(HAL_SERVICE_ID_PAN);
-- 
1.8.3.2

