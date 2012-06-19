Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] input: Fix not adding watches when io channel is connected
Date: Tue, 19 Jun 2012 13:02:36 +0300
Message-Id: <1340100156-19124-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This can leave dangling pointers in case one of the channel is never
connected which cause -EALREADY to be returned by
input_device_set_channel next time the device attempts to connect.
---
 input/device.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/input/device.c b/input/device.c
index 0e3f4a9..ba27c6a 100644
--- a/input/device.c
+++ b/input/device.c
@@ -387,6 +387,11 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	struct input_conn *iconn = data;
 	struct input_device *idev = iconn->idev;
 	gboolean connected = FALSE;
+	char address[18];
+
+	ba2str(&iconn->idev->dst, address);
+
+	DBG("Device %s disconnected", address);
 
 	/* Checking for ctrl_watch avoids a double g_io_channel_shutdown since
 	 * it's likely that ctrl_watch_cb has been queued for dispatching in
@@ -415,6 +420,11 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_conn *iconn = data;
+	char address[18];
+
+	ba2str(&iconn->idev->dst, address);
+
+	DBG("Device %s disconnected", address);
 
 	/* Checking for intr_watch avoids a double g_io_channel_shutdown since
 	 * it's likely that intr_watch_cb has been queued for dispatching in
@@ -811,13 +821,6 @@ static int input_device_connected(struct input_device *idev,
 	if (err < 0)
 		return err;
 
-	iconn->intr_watch = g_io_add_watch(iconn->intr_io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					intr_watch_cb, iconn);
-	iconn->ctrl_watch = g_io_add_watch(iconn->ctrl_io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					ctrl_watch_cb, iconn);
-
 	connected = TRUE;
 	emit_property_changed(idev->conn, idev->path, INPUT_DEVICE_INTERFACE,
 				"Connected", DBUS_TYPE_BOOLEAN, &connected);
@@ -1272,11 +1275,17 @@ int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 		if (iconn->ctrl_io)
 			return -EALREADY;
 		iconn->ctrl_io = g_io_channel_ref(io);
+		iconn->ctrl_watch = g_io_add_watch(iconn->ctrl_io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					ctrl_watch_cb, iconn);
 		break;
 	case L2CAP_PSM_HIDP_INTR:
 		if (iconn->intr_io)
 			return -EALREADY;
 		iconn->intr_io = g_io_channel_ref(io);
+		iconn->intr_watch = g_io_add_watch(iconn->intr_io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					intr_watch_cb, iconn);
 		break;
 	}
 
-- 
1.7.10.2

