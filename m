Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: chanyeol.park@samsung.com
Subject: [PATCH] Fix input pending connect handling
Date: Mon, 17 Oct 2011 21:07:37 +0900
Message-id: <1318853257-10667-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

iconn->pending_connect needs to be freed after sending the error reply
---
 input/device.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/input/device.c b/input/device.c
index 9ff7f20..16eb155 100644
--- a/input/device.c
+++ b/input/device.c
@@ -825,6 +825,9 @@ failed:
 	reply = btd_error_failed(iconn->pending_connect, err_msg);
 	g_dbus_send_message(idev->conn, reply);
 
+	dbus_message_unref(iconn->pending_connect);
+	iconn->pending_connect = NULL;
+
 	/* So we guarantee the interrupt channel is closed before the
 	 * control channel (if we only do unref GLib will close it only
 	 * after returning control to the mainloop */
-- 
1.7.4.1

