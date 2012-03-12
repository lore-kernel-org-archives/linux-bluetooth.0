Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] HoG: Register HID over GATT device driver
Date: Mon, 12 Mar 2012 17:20:56 -0300
Message-Id: <1331583657-1485-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/device.h  |    1 +
 input/manager.c |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/input/device.h b/input/device.h
index 356d9ed..cb59363 100644
--- a/input/device.h
+++ b/input/device.h
@@ -23,6 +23,7 @@
 
 #define HSP_HS_UUID		"00001108-0000-1000-8000-00805F9B34FB"
 #define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
+#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
 #define L2CAP_PSM_HIDP_CTRL	0x11
 #define L2CAP_PSM_HIDP_INTR	0x13
diff --git a/input/manager.c b/input/manager.c
index 9bcab10..69b544c 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -75,6 +75,21 @@ static void hid_device_remove(struct btd_device *device)
 	input_remove(device, HID_UUID);
 }
 
+static int hog_device_probe(struct btd_device *device, GSList *uuids)
+{
+	const gchar *path = device_get_path(device);
+
+	DBG("path %s", path);
+
+	return input_device_register(connection, device, path, HOG_UUID, 0,
+							idle_timeout * 60);
+}
+
+static void hog_device_remove(struct btd_device *device)
+{
+	input_remove(device, HOG_UUID);
+}
+
 static int headset_probe(struct btd_device *device, GSList *uuids)
 {
 	const gchar *path = device_get_path(device);
@@ -147,6 +162,13 @@ static struct btd_device_driver input_hid_driver = {
 	.remove	= hid_device_remove,
 };
 
+static struct btd_device_driver input_hog_driver = {
+	.name	= "input-hog",
+	.uuids	= BTD_UUIDS(HOG_UUID),
+	.probe	= hog_device_probe,
+	.remove	= hog_device_remove,
+};
+
 static struct btd_device_driver input_headset_driver = {
 	.name	= "input-headset",
 	.uuids	= BTD_UUIDS(HSP_HS_UUID),
@@ -178,6 +200,7 @@ int input_manager_init(DBusConnection *conn, GKeyFile *config)
 	btd_register_adapter_driver(&input_server_driver);
 
 	btd_register_device_driver(&input_hid_driver);
+	btd_register_device_driver(&input_hog_driver);
 	btd_register_device_driver(&input_headset_driver);
 
 	return 0;
@@ -186,6 +209,7 @@ int input_manager_init(DBusConnection *conn, GKeyFile *config)
 void input_manager_exit(void)
 {
 	btd_unregister_device_driver(&input_hid_driver);
+	btd_unregister_device_driver(&input_hog_driver);
 	btd_unregister_device_driver(&input_headset_driver);
 
 	btd_unregister_adapter_driver(&input_server_driver);
-- 
1.7.8.5

