Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@googlemail.com, chen.ganir@ti.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC 4/8] HoG: load primary service handle
Date: Tue, 27 Mar 2012 19:31:23 -0300
Message-Id: <1332887487-13601-5-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/hog_device.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 80df978..5ec2d09 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -52,6 +52,7 @@ struct hog_device {
 	struct btd_device	*device;
 	GAttrib			*attrib;
 	guint			attioid;
+	struct gatt_primary	*hog_primary;
 };
 
 static GSList *devices = NULL;
@@ -114,17 +115,45 @@ static struct hog_device *hog_device_new(struct btd_device *device,
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
-	if (!hogdev)
+	if (!hogdev) {
+		g_free(prim);
 		return -ENOMEM;
+	}
+
+	hogdev->hog_primary = prim;
 
 	hogdev->attioid = btd_device_add_attio_callback(device,
 							attio_connected_cb,
@@ -140,6 +169,7 @@ static void hog_device_free(struct hog_device *hogdev)
 {
 	btd_device_unref(hogdev->device);
 	g_free(hogdev->path);
+	g_free(hogdev->hog_primary);
 	g_free(hogdev);
 }
 
-- 
1.7.7.6

