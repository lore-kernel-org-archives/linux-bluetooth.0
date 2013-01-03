Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] input: Fix closing sockets when ioctl_connadd() fails
Date: Wed,  2 Jan 2013 22:08:24 -0400
Message-Id: <1357178905-22533-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of calling close() directly, properly shutdown the channel and
set GIOChannel pointers to NULL.

Also remove dead code and do a small refactoring around the code.

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

Let me know if you want me to split the refactoring part in a separate patch.

 profiles/input/device.c |   62 ++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 9cea028..2cb44cf 100644
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
@@ -271,43 +275,35 @@ static int ioctl_connadd(struct hidp_connadd_req *req)
 	return err;
 }
 
-static void encrypt_completed(uint8_t status, gpointer user_data)
-{
-	struct hidp_connadd_req *req = user_data;
-	int err;
-
-	if (status) {
-		error("Encryption failed: %s(0x%x)",
-				strerror(bt_error(status)), status);
-		goto failed;
-	}
-
-	err = ioctl_connadd(req);
-	if (err == 0)
-		goto cleanup;
-
-	error("ioctl_connadd(): %s(%d)", strerror(-err), -err);
-failed:
-	close(req->intr_sock);
-	close(req->ctrl_sock);
-
-cleanup:
-	free(req->rd_data);
-
-	g_free(req);
-}
-
 static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 								gpointer data)
 {
 	struct input_device *idev = data;
-	struct hidp_connadd_req *req = idev->req;
+	int err;
 
-	DBG(" ");
+	DBG("");
 
-	encrypt_completed(0, req);
+	err = ioctl_connadd(idev->req);
+	if (err < 0) {
+		error("ioctl_connadd(): %s (%d)", strerror(-err), -err);
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
+	}
 
 	idev->sec_watch = 0;
+
+	g_free(idev->req->rd_data);
+	g_free(idev->req);
 	idev->req = NULL;
 
 	return FALSE;
-- 
1.7.9.5

