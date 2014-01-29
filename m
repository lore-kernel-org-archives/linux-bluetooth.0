Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hog: Use HoG device name as uHID input device name
Message-Id: <20140129053008.829BC100AC4@puck.mtv.corp.google.com>
Date: Tue, 28 Jan 2014 21:30:08 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If HoG BLE device name is known, use it when creating uHID input device.
---
 profiles/input/hog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index ded6303..3af0406 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -392,7 +392,12 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
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
 	ev.u.create.vendor = vendor;
 	ev.u.create.product = product;
 	ev.u.create.version = version;
-- 
1.8.5.3

