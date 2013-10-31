Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] hidhost: Shutdown HID L2CAP sockets on unregister
Date: Thu, 31 Oct 2013 17:30:18 +0200
Message-Id: <1383233418-14757-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes address already in use issue if we reenable HID.
...
bluetoothd[2894]: Failed to listen on ctrl channel:
	l2cap_bind: Address already in use (98)
...
---
 android/hid.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index 4075ecb..2bc8c06 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -445,9 +445,15 @@ void bt_hid_unregister(void)
 	g_io_channel_unref(notification_io);
 	notification_io = NULL;
 
-	g_io_channel_unref(ctrl_io);
-	ctrl_io = NULL;
+	if (ctrl_io) {
+		g_io_channel_shutdown(ctrl_io, TRUE, NULL);
+		g_io_channel_unref(ctrl_io);
+		ctrl_io = NULL;
+	}
 
-	g_io_channel_unref(intr_io);
-	intr_io = NULL;
+	if (intr_io) {
+		g_io_channel_shutdown(intr_io, TRUE, NULL);
+		g_io_channel_unref(intr_io);
+		intr_io = NULL;
+	}
 }
-- 
1.7.10.4

