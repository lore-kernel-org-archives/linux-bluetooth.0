Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/5] android/hidhost: Handle error case properly in interrupt_connect_cb
Date: Tue, 19 Nov 2013 14:21:15 +0200
Message-Id: <1384863676-12358-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384863676-12358-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384863676-12358-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hidhost.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index a929a94..05a3fe4 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -522,7 +522,6 @@ static int uhid_create(struct hid_device *dev)
 	dev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
 	if (dev->uhid_fd < 0) {
 		error("Failed to open uHID device: %s", strerror(errno));
-		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_NO_HID);
 		return -errno;
 	}
 
@@ -541,7 +540,6 @@ static int uhid_create(struct hid_device *dev)
 		error("Failed to create uHID device: %s", strerror(errno));
 		close(dev->uhid_fd);
 		dev->uhid_fd = -1;
-		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_NO_HID);
 		return -errno;
 	}
 
@@ -559,16 +557,20 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
 	struct hid_device *dev = user_data;
+	uint8_t state;
 
 	DBG("");
 
 	if (conn_err) {
 		error("%s", conn_err->message);
+		state = HAL_HIDHOST_STATE_FAILED;
 		goto failed;
 	}
 
-	if (uhid_create(dev) < 0)
+	if (uhid_create(dev) < 0) {
+		state = HAL_HIDHOST_STATE_NO_HID;
 		goto failed;
+	}
 
 	dev->intr_watch = g_io_add_watch(dev->intr_io,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
@@ -579,6 +581,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 	return;
 
 failed:
+	bt_hid_notify_state(dev, state);
 	hid_device_free(dev);
 }
 
-- 
1.8.3.2

