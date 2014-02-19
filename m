Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5] hog: Use HoG device name as uHID input device name
Message-Id: <20140219074018.B736F1005F0@puck.mtv.corp.google.com>
Date: Tue, 18 Feb 2014 23:40:18 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/hog.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index ded6303..b9a14b9 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -91,6 +91,7 @@ struct hog_device {
 	uint16_t		proto_mode_handle;
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
+	char			*name;
 };
 
 struct report {
@@ -392,7 +393,9 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	/* create uHID device */
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE;
-	strcpy((char *) ev.u.create.name, "bluez-hog-device");
+	strncpy((char *) ev.u.create.name, hogdev->name ?
+					hogdev->name : "bluez-hog-device",
+					sizeof(ev.u.create.name) - 1);
 	ev.u.create.vendor = vendor;
 	ev.u.create.product = product;
 	ev.u.create.version = version;
@@ -722,6 +725,7 @@ static struct hog_device *hog_new_device(struct btd_device *device,
 								uint16_t id)
 {
 	struct hog_device *hogdev;
+	char name[HCI_MAX_NAME_LENGTH + 1];
 
 	hogdev = g_try_new0(struct hog_device, 1);
 	if (!hogdev)
@@ -729,6 +733,9 @@ static struct hog_device *hog_new_device(struct btd_device *device,
 
 	hogdev->id = id;
 	hogdev->device = btd_device_ref(device);
+	device_get_name(device, name, sizeof(name));
+	if (strlen(name) > 0)
+		hogdev->name = g_strdup(name);
 
 	return hogdev;
 }
@@ -751,6 +758,7 @@ static void hog_free_device(struct hog_device *hogdev)
 	g_slist_free_full(hogdev->reports, report_free);
 	g_attrib_unref(hogdev->attrib);
 	g_free(hogdev->hog_primary);
+	g_free(hogdev->name);
 	g_free(hogdev);
 }
 
-- 
1.9.0.rc1.175.g0b1dcb5

