Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 10/13] plugins/sixaxis: Add initial code for udev handling
Date: Mon, 25 Nov 2013 22:15:49 +0000
Message-Id: <1385417752-25664-11-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When new device is added plugin will be notified about it.
---
 plugins/sixaxis.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index bf66bef..7a5c6c2 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -27,19 +27,82 @@
 #include <config.h>
 #endif
 
+#include <stddef.h>
+#include <errno.h>
+#include <glib.h>
+#include <libudev.h>
+
 #include "plugin.h"
 #include "log.h"
 
+static struct udev *ctx = NULL;
+static struct udev_monitor *monitor = NULL;
+static guint watch_id = 0;
+
+static void device_added(struct udev_device *udevice)
+{
+	DBG("");
+}
+
+static gboolean monitor_watch(GIOChannel *source, GIOCondition condition,
+							gpointer data)
+{
+	struct udev_device *udevice;
+
+	udevice = udev_monitor_receive_device(monitor);
+	if (!udevice)
+		return TRUE;
+
+	if (!g_strcmp0(udev_device_get_action(udevice), "add"))
+		device_added(udevice);
+
+	udev_device_unref(udevice);
+
+	return TRUE;
+}
+
 static int sixaxis_init(void)
 {
+	GIOChannel *channel;
+
 	DBG("");
 
+	ctx = udev_new();
+	if (!ctx)
+		return -EIO;
+
+	monitor = udev_monitor_new_from_netlink(ctx, "udev");
+	if (!monitor) {
+		udev_unref(ctx);
+		ctx = NULL;
+
+		return -EIO;
+	}
+
+	/* Listen for newly connected hidraw interfaces */
+	udev_monitor_filter_add_match_subsystem_devtype(monitor, "hidraw",
+									NULL);
+	udev_monitor_enable_receiving(monitor);
+
+	channel = g_io_channel_unix_new(udev_monitor_get_fd(monitor));
+	watch_id = g_io_add_watch(channel, G_IO_IN, monitor_watch, NULL);
+	g_io_channel_unref(channel);
+
 	return 0;
 }
 
 static void sixaxis_exit(void)
 {
 	DBG("");
+
+	g_source_remove(watch_id);
+	watch_id = 0;
+
+	udev_monitor_unref(monitor);
+	monitor = NULL;
+
+	udev_unref(ctx);
+	ctx = NULL;
 }
 
 BLUETOOTH_PLUGIN_DEFINE(sixaxis, VERSION, BLUETOOTH_PLUGIN_PRIORITY_LOW,
-- 
1.8.4.4

