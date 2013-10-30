Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] android/hid: Fix not cleanup properly after disconnect
Date: Wed, 30 Oct 2013 16:24:54 +0200
Message-Id: <1383143094-21262-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is disconnected it should be removed from the list of
connected devices and free its data.
---
v2: Keep call to g_io_channel_shutdown

 android/hid.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index d6ca4b9..49e9c52 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -149,16 +149,11 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 	if ((cond & (G_IO_HUP | G_IO_ERR)) && hdev->intr_watch)
 		g_io_channel_shutdown(chan, TRUE, NULL);
 
-	hdev->ctrl_watch = 0;
-
-	if (hdev->ctrl_io) {
-		g_io_channel_unref(hdev->ctrl_io);
-		hdev->ctrl_io = NULL;
-	}
-
 	if (hdev->intr_io && !(cond & G_IO_NVAL))
 		g_io_channel_shutdown(hdev->intr_io, TRUE, NULL);
 
+	hid_device_free(hdev);
+
 	return FALSE;
 }
 
@@ -230,8 +225,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 	return;
 
 failed:
-	g_io_channel_unref(hdev->ctrl_io);
-	hdev->ctrl_io = NULL;
+	hid_device_free(hdev);
 }
 
 static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
-- 
1.8.3.1

