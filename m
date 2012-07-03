Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 11/21] hog: Use real values for vendor and product IDs
Date: Tue,  3 Jul 2012 15:43:03 -0300
Message-Id: <1341340993-7480-12-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch replaces the hard-code values for vendor and product IDs
by the values obtained from the device core functions. Vendor and
product IDs are read from the remote's Device Information Service.
---
 input/hog_device.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 5dd9cf1..547bd6c 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -176,6 +176,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	struct hog_device *hogdev = user_data;
 	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
 	struct uhid_event ev;
+	uint16_t vendor_src, vendor, product, version;
 	ssize_t vlen;
 	int i;
 
@@ -198,15 +199,21 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			DBG("\t %02x %02x", value[i], value[i + 1]);
 	}
 
+	vendor_src = btd_device_get_vendor_src(hogdev->device);
+	vendor = btd_device_get_vendor(hogdev->device);
+	product = btd_device_get_product(hogdev->device);
+	version = btd_device_get_version(hogdev->device);
+	DBG("DIS information: vendor_src=0x%X, vendor=0x%X, product=0x%X, "
+			"version=0x%X",	vendor_src, vendor, product, version);
+
 	/* create uHID device */
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE;
-	/* TODO: get info from DIS */
 	strcpy((char *)ev.u.create.name, "bluez-hog-device");
-	ev.u.create.vendor = 0xBEBA;
-	ev.u.create.product = 0xCAFE;
-	ev.u.create.version = 0;
-	ev.u.create.country = 0;
+	ev.u.create.vendor = vendor;
+	ev.u.create.product = product;
+	ev.u.create.version = version;
+	ev.u.create.country = 0; /* get this info from the right place */
 	ev.u.create.bus = BUS_BLUETOOTH;
 	ev.u.create.rd_data = value;
 	ev.u.create.rd_size = vlen;
-- 
1.7.10.4

