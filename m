Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
Subject: [PATCH 2/3] hog: Remove hog_device.name
To: linux-bluetooth@vger.kernel.org
Message-Id: <20140306230042.B6DB4100A0D@puck.mtv.corp.google.com>
Date: Thu,  6 Mar 2014 15:00:42 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove hog_device.name and use hog_device.device to get the device name.
---
 profiles/input/hog.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index b9a14b9..a9830aa 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -91,7 +91,6 @@ struct hog_device {
 	uint16_t		proto_mode_handle;
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
-	char			*name;
 };
 
 struct report {
@@ -393,9 +392,11 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	/* create uHID device */
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE;
-	strncpy((char *) ev.u.create.name, hogdev->name ?
-					hogdev->name : "bluez-hog-device",
-					sizeof(ev.u.create.name) - 1);
+	if (device_name_known(hogdev->device))
+		device_get_name(hogdev->device, (char *) ev.u.create.name,
+						sizeof(ev.u.create.name));
+	else
+		strcpy((char *) ev.u.create.name, "bluez-hog-device");
 	ev.u.create.vendor = vendor;
 	ev.u.create.product = product;
 	ev.u.create.version = version;
@@ -725,7 +726,6 @@ static struct hog_device *hog_new_device(struct btd_device *device,
 								uint16_t id)
 {
 	struct hog_device *hogdev;
-	char name[HCI_MAX_NAME_LENGTH + 1];
 
 	hogdev = g_try_new0(struct hog_device, 1);
 	if (!hogdev)
@@ -733,9 +733,6 @@ static struct hog_device *hog_new_device(struct btd_device *device,
 
 	hogdev->id = id;
 	hogdev->device = btd_device_ref(device);
-	device_get_name(device, name, sizeof(name));
-	if (strlen(name) > 0)
-		hogdev->name = g_strdup(name);
 
 	return hogdev;
 }
@@ -758,7 +755,6 @@ static void hog_free_device(struct hog_device *hogdev)
 	g_slist_free_full(hogdev->reports, report_free);
 	g_attrib_unref(hogdev->attrib);
 	g_free(hogdev->hog_primary);
-	g_free(hogdev->name);
 	g_free(hogdev);
 }
 
-- 
1.9.0.279.gdc9e3eb

