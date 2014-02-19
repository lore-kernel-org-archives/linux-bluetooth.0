Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hog: Fill ev.u.create.{phys,uniq} for UHID_CREATE
Message-Id: <20140219201545.4D13D1007E0@puck.mtv.corp.google.com>
Date: Wed, 19 Feb 2014 12:15:45 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fill ev.u.create.{phys,uniq} fields when uHID device is created.
These values are copied to kernel hid_device structure.

linux/include/linux/hid.h:
struct hid_device {
  ...
  char name[128];  /* Device name */
  char phys[64];   /* Device physical location */
  char uniq[64];   /* Device unique identifier (serial #) */
---
 profiles/input/hog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index b9a14b9..35b973b 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -92,6 +92,8 @@ struct hog_device {
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
 	char			*name;
+	bdaddr_t		src;
+	bdaddr_t		dst;
 };
 
 struct report {
@@ -396,6 +398,8 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	strncpy((char *) ev.u.create.name, hogdev->name ?
 					hogdev->name : "bluez-hog-device",
 					sizeof(ev.u.create.name) - 1);
+	ba2str(&hogdev->src, (char *) ev.u.create.phys);
+	ba2str(&hogdev->dst, (char *) ev.u.create.uniq);
 	ev.u.create.vendor = vendor;
 	ev.u.create.product = product;
 	ev.u.create.version = version;
@@ -724,6 +728,7 @@ static void attio_disconnected_cb(gpointer user_data)
 static struct hog_device *hog_new_device(struct btd_device *device,
 								uint16_t id)
 {
+	struct btd_adapter *adapter = device_get_adapter(device);
 	struct hog_device *hogdev;
 	char name[HCI_MAX_NAME_LENGTH + 1];
 
@@ -736,6 +741,8 @@ static struct hog_device *hog_new_device(struct btd_device *device,
 	device_get_name(device, name, sizeof(name));
 	if (strlen(name) > 0)
 		hogdev->name = g_strdup(name);
+	bacpy(&hogdev->src, btd_adapter_get_address(adapter));
+	bacpy(&hogdev->dst, device_get_address(device));
 
 	return hogdev;
 }
-- 
1.9.0.rc1.175.g0b1dcb5

