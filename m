Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 13/17] input: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:20:00 -0400
Message-Id: <1321449604-4188-14-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.

Also remove a few unnecessary errno assignments.
---
 input/device.c |   43 +++++++++++++++++++------------------------
 1 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/input/device.c b/input/device.c
index 16eb155..a1ecdd7 100644
--- a/input/device.c
+++ b/input/device.c
@@ -164,10 +164,10 @@ static int uinput_create(char *name)
 		if (fd < 0) {
 			fd = open("/dev/misc/uinput", O_RDWR);
 			if (fd < 0) {
-				err = errno;
+				err = -errno;
 				error("Can't open input device: %s (%d)",
-							strerror(err), err);
-				return -err;
+							strerror(-err), -err);
+				return err;
 			}
 		}
 	}
@@ -182,12 +182,11 @@ static int uinput_create(char *name)
 	dev.id.version = 0x0000;
 
 	if (write(fd, &dev, sizeof(dev)) < 0) {
-		err = errno;
+		err = -errno;
 		error("Can't write device information: %s (%d)",
-						strerror(err), err);
+						strerror(-err), -err);
 		close(fd);
-		errno = err;
-		return -err;
+		return err;
 	}
 
 	ioctl(fd, UI_SET_EVBIT, EV_KEY);
@@ -200,12 +199,11 @@ static int uinput_create(char *name)
 	ioctl(fd, UI_SET_KEYBIT, KEY_PAGEDOWN);
 
 	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
-		err = errno;
+		err = -errno;
 		error("Can't create uinput device: %s (%d)",
-						strerror(err), err);
+						strerror(-err), -err);
 		close(fd);
-		errno = err;
-		return -err;
+		return err;
 	}
 
 	return fd;
@@ -333,9 +331,11 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	 */
 	fake->uinput = uinput_create(idev->name);
 	if (fake->uinput < 0) {
+		int err = fake->uinput;
+
 		g_io_channel_shutdown(chan, TRUE, NULL);
 		reply = btd_error_failed(iconn->pending_connect,
-							strerror(errno));
+							strerror(-err));
 		goto failed;
 	}
 
@@ -534,11 +534,11 @@ static int ioctl_connadd(struct hidp_connadd_req *req)
 		return -errno;
 
 	if (ioctl(ctl, HIDPCONNADD, req) < 0)
-		err = errno;
+		err = -errno;
 
 	close(ctl);
 
-	return -err;
+	return err;
 }
 
 static void encrypt_completed(uint8_t status, gpointer user_data)
@@ -680,7 +680,7 @@ static int connection_disconnect(struct input_conn *iconn, uint32_t flags)
 	struct fake_input *fake = iconn->fake;
 	struct hidp_conndel_req req;
 	struct hidp_conninfo ci;
-	int ctl, err;
+	int ctl, err = 0;
 
 	/* Fake input disconnect */
 	if (fake) {
@@ -706,7 +706,7 @@ static int connection_disconnect(struct input_conn *iconn, uint32_t flags)
 	bacpy(&ci.bdaddr, &idev->dst);
 	if ((ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) ||
 				(ci.state != BT_CONNECTED)) {
-		errno = ENOTCONN;
+		err = -ENOTCONN;
 		goto fail;
 	}
 
@@ -714,21 +714,16 @@ static int connection_disconnect(struct input_conn *iconn, uint32_t flags)
 	bacpy(&req.bdaddr, &idev->dst);
 	req.flags = flags;
 	if (ioctl(ctl, HIDPCONNDEL, &req) < 0) {
+		err = -errno;
 		error("Can't delete the HID device: %s(%d)",
-				strerror(errno), errno);
+				strerror(-err), -err);
 		goto fail;
 	}
 
-	close(ctl);
-
-	return 0;
-
 fail:
-	err = errno;
 	close(ctl);
-	errno = err;
 
-	return -err;
+	return err;
 }
 
 static int disconnect(struct input_device *idev, uint32_t flags)
-- 
1.7.0.4

