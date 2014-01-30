Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3] hog: Use HoG device name as uHID input device name
Message-Id: <20140130035506.2A034100F4B@puck.mtv.corp.google.com>
Date: Wed, 29 Jan 2014 19:55:06 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If HoG BLE device name is known, use it when creating uHID input device.
Pass adapter and device addresses to uHID as well.
---
 profiles/input/hog.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index ded6303..030dc91 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -392,7 +392,15 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	/* create uHID device */
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE;
-	strcpy((char *) ev.u.create.name, "bluez-hog-device");
+	if (device_name_known(hogdev->device)) {
+		device_get_name(hogdev->device, (char *) ev.u.create.name,
+				sizeof(ev.u.create.name) - 1);
+	} else {
+		strcpy((char *) ev.u.create.name, "bluez-hog-device");
+	}
+	ba2str(btd_adapter_get_address(device_get_adapter(hogdev->device)),
+		(char *) ev.u.create.phys);
+	ba2str(device_get_address(hogdev->device), (char *) ev.u.create.uniq);
 	ev.u.create.vendor = vendor;
 	ev.u.create.product = product;
 	ev.u.create.version = version;
-- 
1.8.5.3

