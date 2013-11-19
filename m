Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 5/5] android/hidhost: Free all connected devices in profile cleanup call
Date: Tue, 19 Nov 2013 14:21:16 +0200
Message-Id: <1384863676-12358-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384863676-12358-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384863676-12358-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hidhost.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index 05a3fe4..20dedc4 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1226,6 +1226,14 @@ bool bt_hid_register(int sk, const bdaddr_t *addr)
 	return true;
 }
 
+static void free_hid_devices(gpointer data, gpointer user_data)
+{
+	struct hid_device *dev = data;
+
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
+	hid_device_free(dev);
+}
+
 void bt_hid_unregister(void)
 {
 	DBG("");
@@ -1233,6 +1241,8 @@ void bt_hid_unregister(void)
 	if (notification_sk < 0)
 		return;
 
+	g_slist_foreach(devices, free_hid_devices, NULL);
+
 	notification_sk = -1;
 
 	if (ctrl_io) {
-- 
1.8.3.2

