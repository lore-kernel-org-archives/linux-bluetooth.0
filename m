Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] android/hidhost: Fix error handling issue incase of G_IO_HUP
Date: Tue, 12 Nov 2013 15:05:15 +0200
Message-Id: <1384261515-28725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Incase of G_IO_HUP on GIOCondtion when hid device disconnected,
GIOCondition is combination of G_IO_IN and G_IO_HUP. Current code
tries to read as soon as it finds G_IO_IN in condition.
Apparently there is no data to read and loop continues.
---
 android/hidhost.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 491eacd..cba80a6 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -282,26 +282,27 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
 {
 	struct hid_device *dev = data;
 
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+		goto error;
+
 	if (cond & G_IO_IN)
 		return intr_io_watch_cb(chan, data);
 
+error:
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
+
 	/* Checking for ctrl_watch avoids a double g_io_channel_shutdown since
 	 * it's likely that ctrl_watch_cb has been queued for dispatching in
 	 * this mainloop iteration */
 	if ((cond & (G_IO_HUP | G_IO_ERR)) && dev->ctrl_watch)
 		g_io_channel_shutdown(chan, TRUE, NULL);
 
-	dev->intr_watch = 0;
-
-	if (dev->intr_io) {
-		g_io_channel_unref(dev->intr_io);
-		dev->intr_io = NULL;
-	}
-
 	/* Close control channel */
 	if (dev->ctrl_io && !(cond & G_IO_NVAL))
 		g_io_channel_shutdown(dev->ctrl_io, TRUE, NULL);
 
+	hid_device_free(dev);
+
 	return FALSE;
 }
 
@@ -442,12 +443,14 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
 	struct hid_device *dev = data;
-	char address[18];
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+		goto error;
 
 	if (cond & G_IO_IN)
 		return ctrl_io_watch_cb(chan, data);
 
-	ba2str(&dev->dst, address);
+error:
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
 
 	/* Checking for intr_watch avoids a double g_io_channel_shutdown since
-- 
1.8.3.2

