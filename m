Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 04/19] hog: Load primary service handle
Date: Fri, 22 Jun 2012 12:07:52 -0300
Message-Id: <1340377687-4711-5-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
References: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/hog_device.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/input/hog_device.c b/input/hog_device.c
index 687dc95..6ce05a9 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -31,6 +31,7 @@
 #include <unistd.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
@@ -41,14 +42,17 @@
 
 #include "hog_device.h"
 
+#include "att.h"
 #include "gattrib.h"
 #include "attio.h"
+#include "gatt.h"
 
 struct hog_device {
 	char			*path;
 	struct btd_device	*device;
 	GAttrib			*attrib;
 	guint			attioid;
+	struct gatt_primary	*hog_primary;
 };
 
 static GSList *devices = NULL;
@@ -95,18 +99,44 @@ static struct hog_device *hog_device_new(struct btd_device *device,
 	return hogdev;
 }
 
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
+static struct gatt_primary *load_hog_primary(struct btd_device *device)
+{
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, HOG_UUID, primary_uuid_cmp);
+
+	return (l ? l->data : NULL);
+}
+
 int hog_device_register(struct btd_device *device, const char *path)
 {
 	struct hog_device *hogdev;
+	struct gatt_primary *prim;
 
 	hogdev = find_device_by_path(devices, path);
 	if (hogdev)
 		return -EALREADY;
 
+	prim = load_hog_primary(device);
+	if (!prim)
+		return -EINVAL;
+
 	hogdev = hog_device_new(device, path);
 	if (!hogdev)
 		return -ENOMEM;
 
+	hogdev->hog_primary = g_memdup(prim, sizeof(*prim));
+
 	hogdev->attioid = btd_device_add_attio_callback(device,
 							attio_connected_cb,
 							attio_disconnected_cb,
@@ -122,6 +152,7 @@ static void hog_device_free(struct hog_device *hogdev)
 {
 	btd_device_unref(hogdev->device);
 	g_free(hogdev->path);
+	g_free(hogdev->hog_primary);
 	g_free(hogdev);
 }
 
-- 
1.7.10.2

