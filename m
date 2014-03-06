Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
Subject: [PATCH 3/3] hog: Fill ev.u.create.{phys,uniq} for UHID_CREATE
To: linux-bluetooth@vger.kernel.org
Message-Id: <20140306230055.4A850100A0D@puck.mtv.corp.google.com>
Date: Thu,  6 Mar 2014 15:00:55 -0800 (PST)
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
 profiles/input/hog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index a9830aa..fd72e36 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -348,6 +348,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
+	struct btd_adapter *adapter = device_get_adapter(hogdev->device);
 	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
 	struct uhid_event ev;
 	uint16_t vendor_src, vendor, product, version;
@@ -397,6 +398,8 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 						sizeof(ev.u.create.name));
 	else
 		strcpy((char *) ev.u.create.name, "bluez-hog-device");
+	ba2str(btd_adapter_get_address(adapter), (char *) ev.u.create.phys);
+	ba2str(device_get_address(hogdev->device), (char *) ev.u.create.uniq);
 	ev.u.create.vendor = vendor;
 	ev.u.create.product = product;
 	ev.u.create.version = version;
-- 
1.9.0.279.gdc9e3eb

