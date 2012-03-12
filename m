Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] HoG: Register ATTIO callback to keep the link UP
Date: Mon, 12 Mar 2012 17:20:57 -0300
Message-Id: <1331583657-1485-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1331583657-1485-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1331583657-1485-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/device.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/input/device.c b/input/device.c
index 743699f..4c94cd8 100644
--- a/input/device.c
+++ b/input/device.c
@@ -51,6 +51,8 @@
 #include "../src/manager.h"
 #include "../src/dbus-common.h"
 
+#include "gattrib.h"
+#include "attio.h"
 #include "device.h"
 #include "error.h"
 #include "fakehid.h"
@@ -86,6 +88,8 @@ struct input_device {
 	char			*name;
 	struct btd_device	*device;
 	GSList			*connections;
+	GAttrib			*attrib;
+	guint			attioid;
 };
 
 static GSList *devices = NULL;
@@ -136,6 +140,21 @@ static void input_conn_free(struct input_conn *iconn)
 	g_free(iconn);
 }
 
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct input_device *idev = user_data;
+
+	idev->attrib = g_attrib_ref(attrib);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct input_device *idev = user_data;
+
+	g_attrib_unref(idev->attrib);
+	idev->attrib = NULL;
+}
+
 static void input_device_free(struct input_device *idev)
 {
 	if (idev->dc_id)
@@ -1094,6 +1113,12 @@ int input_device_register(DBusConnection *conn, struct btd_device *device,
 	if (!iconn)
 		return -EINVAL;
 
+	if (strcmp(uuid, HOG_UUID) == 0)
+		idev->attioid = btd_device_add_attio_callback(device,
+							attio_connected_cb,
+							attio_disconnected_cb,
+							idev);
+
 	idev->connections = g_slist_append(idev->connections, iconn);
 
 	return 0;
@@ -1160,6 +1185,9 @@ int input_device_unregister(const char *path, const char *uuid)
 		return -EBUSY;
 	}
 
+	if (idev->attioid)
+		btd_device_remove_attio_callback(idev->device, idev->attioid);
+
 	idev->connections = g_slist_remove(idev->connections, iconn);
 	input_conn_free(iconn);
 	if (idev->connections)
-- 
1.7.8.5

