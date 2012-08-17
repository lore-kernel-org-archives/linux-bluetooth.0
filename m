Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 5/5] hog: Add writting Control Point
Date: Fri, 17 Aug 2012 18:08:23 -0300
Message-Id: <1345237703-15342-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds GATT write without response operation when suspending
or resuming.
---
 profiles/input/hog_device.c  |   27 ++++++++++++++++++++++++++-
 profiles/input/hog_device.h  |    1 +
 profiles/input/hog_manager.c |   14 ++++++++++++++
 3 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index a561876..2e9293d 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -55,6 +55,7 @@
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
 #define HOG_PROTO_MODE_UUID	0x2A4E
+#define HOG_CONTROL_POINT_UUID	0x2A4C
 
 #define HOG_REPORT_TYPE_INPUT	1
 #define HOG_REPORT_TYPE_OUTPUT	2
@@ -82,6 +83,7 @@ struct hog_device {
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
 	uint16_t		proto_mode_handle;
+	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
 };
 
@@ -437,7 +439,8 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
-	bt_uuid_t report_uuid, report_map_uuid, info_uuid, proto_mode_uuid;
+	bt_uuid_t report_uuid, report_map_uuid, info_uuid, proto_mode_uuid,
+		  ctrlpt_uuid;
 	struct report *report;
 	GSList *l;
 	uint16_t info_handle = 0, proto_mode_handle = 0;
@@ -452,6 +455,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
 	bt_uuid16_create(&info_uuid, HOG_INFO_UUID);
 	bt_uuid16_create(&proto_mode_uuid, HOG_PROTO_MODE_UUID);
+	bt_uuid16_create(&ctrlpt_uuid, HOG_CONTROL_POINT_UUID);
 
 	for (l = chars; l; l = g_slist_next(l)) {
 		struct gatt_char *chr, *next;
@@ -480,6 +484,8 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 			info_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
 			proto_mode_handle = chr->value_handle;
+		else if (bt_uuid_cmp(&uuid, &ctrlpt_uuid) == 0)
+			hogdev->ctrlpt_handle = chr->value_handle;
 	}
 
 	if (proto_mode_handle) {
@@ -763,3 +769,22 @@ int hog_device_unregister(struct hog_device *hogdev)
 
 	return 0;
 }
+
+int hog_device_set_control_point(struct hog_device *hogdev, gboolean suspend)
+{
+	uint8_t value = suspend ? 0x00 : 0x01;
+
+	if (hogdev->attrib == NULL)
+		return -ENOTCONN;
+
+	DBG("%s HID Control Point: %s", hogdev->path, suspend ?
+						"Suspend" : "Exit Suspend");
+
+	if (hogdev->ctrlpt_handle == 0)
+		return -ENOTSUP;
+
+	gatt_write_char(hogdev->attrib, hogdev->ctrlpt_handle, &value,
+					sizeof(value), NULL, NULL);
+
+	return 0;
+}
diff --git a/profiles/input/hog_device.h b/profiles/input/hog_device.h
index 5679527..54b2cde 100644
--- a/profiles/input/hog_device.h
+++ b/profiles/input/hog_device.h
@@ -30,3 +30,4 @@ struct hog_device *hog_device_register(struct btd_device *device,
 						const char *path, int *perr);
 int hog_device_unregister(struct hog_device *hogdev);
 struct hog_device *hog_device_find(GSList *list, const char *path);
+int hog_device_set_control_point(struct hog_device *hogdev, gboolean suspend);
diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index ce8e2ff..7f1cdba 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -42,12 +42,26 @@ static gboolean upower_supported = FALSE;
 static DBusConnection *connection = NULL;
 static GSList *devices = NULL;
 
+static void set_suspend(gpointer data, gpointer user_data)
+{
+	struct hog_device *hogdev = data;
+	gboolean suspend = GPOINTER_TO_INT(user_data);
+
+	hog_device_set_control_point(hogdev, suspend);
+}
+
 static void suspend_event_cb(void)
 {
+	gboolean suspend = TRUE;
+
+	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
 }
 
 static void resume_event_cb(void)
 {
+	gboolean suspend = FALSE;
+
+	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
 }
 
 static int hog_device_probe(struct btd_device *device, GSList *uuids)
-- 
1.7.8.6

