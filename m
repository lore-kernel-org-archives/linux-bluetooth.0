Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] input: Refactor HIDP kernel module interaction
Message-Id: <20140404230216.066B21009F7@puck.mtv.corp.google.com>
Date: Fri,  4 Apr 2014 16:02:15 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactor HIDP kernel module interaction to ioctl_xxx routines.
---
 profiles/input/device.c | 117 ++++++++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 53 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index a2329c6..bded1ea 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -333,6 +333,68 @@ static int ioctl_connadd(struct hidp_connadd_req *req)
 	return err;
 }
 
+static int ioctl_is_connected(struct input_device *idev)
+{
+	struct hidp_conninfo ci;
+	int ctl;
+
+	/* Standard HID */
+	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
+	if (ctl < 0) {
+		error("Can't open HIDP control socket");
+		return 0;
+	}
+
+	memset(&ci, 0, sizeof(ci));
+	bacpy(&ci.bdaddr, &idev->dst);
+	if (ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) {
+		error("Can't get HIDP connection info");
+		close(ctl);
+		return 0;
+	}
+
+	close(ctl);
+
+	if (ci.state != BT_CONNECTED)
+		return 0;
+	else
+		return 1;
+}
+
+static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
+{
+	struct hidp_conndel_req req;
+	struct hidp_conninfo ci;
+	int ctl, err = 0;
+
+	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
+	if (ctl < 0) {
+		error("Can't open HIDP control socket");
+		return -errno;
+	}
+
+	memset(&ci, 0, sizeof(ci));
+	bacpy(&ci.bdaddr, &idev->dst);
+	if ((ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) ||
+						(ci.state != BT_CONNECTED)) {
+		close(ctl);
+		return -ENOTCONN;
+	}
+
+	memset(&req, 0, sizeof(req));
+	bacpy(&req.bdaddr, &idev->dst);
+	req.flags = flags;
+	if (ioctl(ctl, HIDPCONNDEL, &req) < 0) {
+		err = -errno;
+		error("Can't delete the HID device: %s (%d)",
+							strerror(-err), -err);
+	}
+
+	close(ctl);
+
+	return err;
+}
+
 static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 								gpointer data)
 {
@@ -450,35 +512,11 @@ cleanup:
 
 static int is_connected(struct input_device *idev)
 {
-	struct hidp_conninfo ci;
-	int ctl;
-
-	/* Standard HID */
-	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
-	if (ctl < 0)
-		return 0;
-
-	memset(&ci, 0, sizeof(ci));
-	bacpy(&ci.bdaddr, &idev->dst);
-	if (ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) {
-		close(ctl);
-		return 0;
-	}
-
-	close(ctl);
-
-	if (ci.state != BT_CONNECTED)
-		return 0;
-	else
-		return 1;
+	return ioctl_is_connected(idev);
 }
 
 static int connection_disconnect(struct input_device *idev, uint32_t flags)
 {
-	struct hidp_conndel_req req;
-	struct hidp_conninfo ci;
-	int ctl, err = 0;
-
 	if (!is_connected(idev))
 		return -ENOTCONN;
 
@@ -488,34 +526,7 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 	if (idev->ctrl_io)
 		g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
 
-	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
-	if (ctl < 0) {
-		error("Can't open HIDP control socket");
-		return -errno;
-	}
-
-	memset(&ci, 0, sizeof(ci));
-	bacpy(&ci.bdaddr, &idev->dst);
-	if ((ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) ||
-				(ci.state != BT_CONNECTED)) {
-		err = -ENOTCONN;
-		goto fail;
-	}
-
-	memset(&req, 0, sizeof(req));
-	bacpy(&req.bdaddr, &idev->dst);
-	req.flags = flags;
-	if (ioctl(ctl, HIDPCONNDEL, &req) < 0) {
-		err = -errno;
-		error("Can't delete the HID device: %s(%d)",
-				strerror(-err), -err);
-		goto fail;
-	}
-
-fail:
-	close(ctl);
-
-	return err;
+	return ioctl_disconnect(idev, flags);
 }
 
 static void disconnect_cb(struct btd_device *device, gboolean removal,
-- 
1.9.1.423.g4596e3a

