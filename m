Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [RFC 1/6] input: Fix not sending PropertiesChanged signal
Date: Thu, 18 Oct 2012 19:03:46 -0300
Message-Id: <1350597831-28380-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 profiles/input/device.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 997235b..9dd8002 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -148,7 +148,6 @@ static void input_device_free(struct input_device *idev)
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_device *idev = data;
-	gboolean connected = FALSE;
 	char address[18];
 
 	ba2str(&idev->dst, address);
@@ -161,9 +160,8 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	if ((cond & (G_IO_HUP | G_IO_ERR)) && idev->ctrl_watch)
 		g_io_channel_shutdown(chan, TRUE, NULL);
 
-	emit_property_changed(idev->path,
-				INPUT_DEVICE_INTERFACE, "Connected",
-				DBUS_TYPE_BOOLEAN, &connected);
+	g_dbus_emit_property_changed(idev->conn, idev->path,
+					INPUT_DEVICE_INTERFACE, "Connected");
 
 	device_remove_disconnect_watch(idev->device, idev->dc_id);
 	idev->dc_id = 0;
@@ -496,7 +494,6 @@ static void disconnect_cb(struct btd_device *device, gboolean removal,
 
 static int input_device_connected(struct input_device *idev)
 {
-	dbus_bool_t connected;
 	int err;
 
 	if (idev->intr_io == NULL || idev->ctrl_io == NULL)
@@ -506,10 +503,8 @@ static int input_device_connected(struct input_device *idev)
 	if (err < 0)
 		return err;
 
-	connected = TRUE;
-	emit_property_changed(idev->path,
-				INPUT_DEVICE_INTERFACE, "Connected",
-				DBUS_TYPE_BOOLEAN, &connected);
+	g_dbus_emit_property_changed(idev->conn, idev->path,
+					INPUT_DEVICE_INTERFACE, "Connected");
 
 	idev->dc_id = device_add_disconnect_watch(idev->device, disconnect_cb,
 							idev, NULL);
-- 
1.7.12.3

