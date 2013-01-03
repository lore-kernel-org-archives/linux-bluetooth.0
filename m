Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 6/6] input: Fix closing sockets when ioctl_connadd() fails
Date: Thu,  3 Jan 2013 10:15:03 -0400
Message-Id: <1357222503-31554-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of calling close() directly, properly shutdown the channel and
set GIOChannel pointers to NULL.

Fixes this error detected when HIDP support is disabled on kernel and we
attempt to connect to a BT keyboard:

bluetoothd[5168]: profiles/input/device.c:encrypt_notify()
bluetoothd[5168]: ioctl_connadd(): Protocol not supported(93)
bluetoothd[5168]: profiles/input/device.c:ctrl_watch_cb() Device
CA:FE:CA:FE:CA:FE disconnected

(bluetoothd:5168): GLib-WARNING **: Invalid file descriptor.

bluetoothd[5168]: profiles/input/device.c:intr_watch_cb() Device
CA:FE:CA:FE:CA:FE disconnected

(bluetoothd:5168): GLib-WARNING **: Invalid file descriptor.
---
 profiles/input/device.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 3d5ee20..9ab7509 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -136,8 +136,10 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 
 	idev->intr_watch = 0;
 
-	g_io_channel_unref(idev->intr_io);
-	idev->intr_io = NULL;
+	if (idev->intr_io) {
+		g_io_channel_unref(idev->intr_io);
+		idev->intr_io = NULL;
+	}
 
 	/* Close control channel */
 	if (idev->ctrl_io && !(cond & G_IO_NVAL))
@@ -163,8 +165,10 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 
 	idev->ctrl_watch = 0;
 
-	g_io_channel_unref(idev->ctrl_io);
-	idev->ctrl_io = NULL;
+	if (idev->ctrl_io) {
+		g_io_channel_unref(idev->ctrl_io);
+		idev->ctrl_io = NULL;
+	}
 
 	/* Close interrupt channel */
 	if (idev->intr_io && !(cond & G_IO_NVAL))
@@ -282,8 +286,18 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 	err = ioctl_connadd(idev->req);
 	if (err < 0) {
 		error("ioctl_connadd(): %s (%d)", strerror(-err), -err);
-		close(idev->req->intr_sock);
-		close(idev->req->ctrl_sock);
+
+		if (idev->ctrl_io) {
+			g_io_channel_shutdown(idev->ctrl_io, FALSE, NULL);
+			g_io_channel_unref(idev->ctrl_io);
+			idev->ctrl_io = NULL;
+		}
+
+		if (idev->intr_io) {
+			g_io_channel_shutdown(idev->intr_io, FALSE, NULL);
+			g_io_channel_unref(idev->intr_io);
+			idev->intr_io = NULL;
+		}
 	}
 
 	idev->sec_watch = 0;
-- 
1.7.9.5

