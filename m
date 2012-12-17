Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hog: Fix removing HoG device bug
Date: Mon, 17 Dec 2012 16:03:23 -0300
Message-Id: <1355771003-2518-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should remove only hog_devices from the given btd_device.
Otherwise, all hog_devices will be removed.
---
 profiles/input/hog_device.c  | 5 +++++
 profiles/input/hog_device.h  | 1 +
 profiles/input/hog_manager.c | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 06dab6d..cc68080 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -789,3 +789,8 @@ int hog_device_set_control_point(struct hog_device *hogdev, gboolean suspend)
 
 	return 0;
 }
+
+struct btd_device *hog_device_get_device(struct hog_device *hogdev)
+{
+	return hogdev->device;
+}
diff --git a/profiles/input/hog_device.h b/profiles/input/hog_device.h
index d1bfc08..60c4f12 100644
--- a/profiles/input/hog_device.h
+++ b/profiles/input/hog_device.h
@@ -31,3 +31,4 @@ struct hog_device *hog_device_register(struct btd_device *device,
 						struct gatt_primary *prim);
 int hog_device_unregister(struct hog_device *hogdev);
 int hog_device_set_control_point(struct hog_device *hogdev, gboolean suspend);
+struct btd_device *hog_device_get_device(struct hog_device *hogdev);
diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 595b160..c7b98c5 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -106,6 +106,9 @@ static int hog_device_probe(struct btd_profile *p, struct btd_device *device,
 
 static void remove_device(gpointer hogdev, gpointer b)
 {
+	if (hog_device_get_device(hogdev) != b)
+		return;
+
 	devices = g_slist_remove(devices, hogdev);
 	hog_device_unregister(hogdev);
 }
@@ -116,7 +119,7 @@ static void hog_device_remove(struct btd_profile *p, struct btd_device *device)
 
 	DBG("path %s", path);
 
-	g_slist_foreach(devices, remove_device, NULL);
+	g_slist_foreach(devices, remove_device, device);
 }
 
 static struct btd_profile hog_profile = {
-- 
1.8.0.1

