Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 2/4] android: Handle multiple init(register) and cleanup(unregister) calls properly
Date: Tue, 19 Nov 2013 16:56:26 +0200
Message-Id: <1384872988-19914-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384872988-19914-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384872988-19914-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This can be tested with haltest.
---
 android/a2dp.c      | 6 ++++++
 android/bluetooth.c | 6 ++++++
 android/hidhost.c   | 6 ++++++
 android/pan.c       | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 74d0082..a9e7c65 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -332,6 +332,9 @@ bool bt_a2dp_register(int sk, const bdaddr_t *addr)
 
 	DBG("");
 
+	if (notification_sk >= 0)
+		return false;
+
 	bacpy(&adapter_addr, addr);
 
 	server = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
@@ -365,6 +368,9 @@ void bt_a2dp_unregister(void)
 {
 	DBG("");
 
+	if (notification_sk < 0)
+		return;
+
 	notification_sk = -1;
 
 	bt_adapter_remove_record(record_id);
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 7dc2ec3..11b9d76 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2275,6 +2275,9 @@ bool bt_bluetooth_register(int sk)
 {
 	DBG("");
 
+	if (notification_sk >= 0)
+		return false;
+
 	notification_sk = sk;
 
 	return true;
@@ -2284,5 +2287,8 @@ void bt_bluetooth_unregister(void)
 {
 	DBG("");
 
+	if (notification_sk < 0)
+		return;
+
 	notification_sk = -1;
 }
diff --git a/android/hidhost.c b/android/hidhost.c
index 842b8ad..df21f81 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1190,6 +1190,9 @@ bool bt_hid_register(int sk, const bdaddr_t *addr)
 
 	DBG("");
 
+	if (notification_sk >= 0)
+		return false;
+
 	bacpy(&adapter_addr, addr);
 
 	ctrl_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
@@ -1224,6 +1227,9 @@ void bt_hid_unregister(void)
 {
 	DBG("");
 
+	if (notification_sk < 0)
+		return;
+
 	notification_sk = -1;
 
 	if (ctrl_io) {
diff --git a/android/pan.c b/android/pan.c
index fba86b8..ada458a 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -95,6 +95,9 @@ bool bt_pan_register(int sk, const bdaddr_t *addr)
 {
 	DBG("");
 
+	if (notification_sk >= 0)
+		return false;
+
 	notification_sk = sk;
 
 	return true;
@@ -104,5 +107,8 @@ void bt_pan_unregister(void)
 {
 	DBG("");
 
+	if (notification_sk < 0)
+		return;
+
 	notification_sk = -1;
 }
-- 
1.8.3.2

