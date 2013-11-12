Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] android/hidhost: Fix uhid create failure case
Date: Tue, 12 Nov 2013 11:47:19 +0200
Message-Id: <1384249639-10915-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If uhid open or create fails then notify state and free the device.
Otherwise it replies bogus success return value on connect request.
---
 android/hidhost.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 683938f..491eacd 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -514,6 +514,7 @@ static int uhid_create(struct hid_device *dev)
 		error("Failed to create uHID device: %s", strerror(errno));
 		close(dev->uhid_fd);
 		dev->uhid_fd = -1;
+		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_NO_HID);
 		return -errno;
 	}
 
@@ -534,8 +535,10 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 
 	DBG("");
 
-	if (conn_err)
+	if (conn_err) {
+		error("%s", conn_err->message);
 		goto failed;
+	}
 
 	if (uhid_create(dev) < 0)
 		goto failed;
@@ -549,19 +552,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 	return;
 
 failed:
-	/* So we guarantee the interrupt channel is closed before the
-	 * control channel (if we only do unref GLib will close it only
-	 * after returning control to the mainloop */
-	if (!conn_err)
-		g_io_channel_shutdown(dev->intr_io, FALSE, NULL);
-
-	g_io_channel_unref(dev->intr_io);
-	dev->intr_io = NULL;
-
-	if (dev->ctrl_io) {
-		g_io_channel_unref(dev->ctrl_io);
-		dev->ctrl_io = NULL;
-	}
+	hid_device_free(dev);
 }
 
 static void control_connect_cb(GIOChannel *chan, GError *conn_err,
-- 
1.8.3.2

