Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 3/3] hog: Fix registering HoG devices without vendor information
Date: Fri, 23 Nov 2012 17:30:32 -0300
Message-Id: <1353702632-7960-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1353702632-7960-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1353702632-7960-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We use the newly added support for notifying when the PNP ID
information is ready before registering the HoG device.
---
 profiles/input/hog_device.c | 75 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 0a5fb58..28e3b50 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -78,6 +78,8 @@ struct hog_device {
 	guint			attioid;
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
+	uint8_t			*reportmap;
+	ssize_t			reportmap_size;
 	int			uhid_fd;
 	gboolean		prepend_id;
 	guint			uhid_watch_id;
@@ -335,13 +337,54 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					external_service_char_cb, hogdev);
 }
 
+static void create_uhid_device(struct hog_device *hogdev, uint8_t *reportmap,
+							uint16_t rsize)
+{
+	struct uhid_event ev;
+	uint16_t vendor_src, vendor, product, version;
+
+	vendor_src = btd_device_get_vendor_src(hogdev->device);
+	vendor = btd_device_get_vendor(hogdev->device);
+	product = btd_device_get_product(hogdev->device);
+	version = btd_device_get_version(hogdev->device);
+	DBG("DIS information: vendor_src=0x%X, vendor=0x%X, product=0x%X, "
+			"version=0x%X",	vendor_src, vendor, product, version);
+
+	/* create uHID device */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	strcpy((char *) ev.u.create.name, "bluez-hog-device");
+	ev.u.create.vendor = vendor;
+	ev.u.create.product = product;
+	ev.u.create.version = version;
+	ev.u.create.country = hogdev->bcountrycode;
+	ev.u.create.bus = BUS_BLUETOOTH;
+	ev.u.create.rd_data = reportmap;
+	ev.u.create.rd_size = rsize;
+
+	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("Failed to create uHID device: %s", strerror(errno));
+}
+
+static void pnpid_ready(gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+
+	if (hogdev->reportmap == NULL)
+		return;
+
+	create_uhid_device(hogdev, hogdev->reportmap, hogdev->reportmap_size);
+
+	g_free(hogdev->reportmap);
+	hogdev->reportmap = NULL;
+	hogdev->reportmap_size = 0;
+}
+
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
 	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
-	struct uhid_event ev;
-	uint16_t vendor_src, vendor, product, version;
 	ssize_t vlen;
 	int i;
 
@@ -373,27 +416,14 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		}
 	}
 
-	vendor_src = btd_device_get_vendor_src(hogdev->device);
-	vendor = btd_device_get_vendor(hogdev->device);
-	product = btd_device_get_product(hogdev->device);
-	version = btd_device_get_version(hogdev->device);
-	DBG("DIS information: vendor_src=0x%X, vendor=0x%X, product=0x%X, "
-			"version=0x%X",	vendor_src, vendor, product, version);
-
-	/* create uHID device */
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_CREATE;
-	strcpy((char *) ev.u.create.name, "bluez-hog-device");
-	ev.u.create.vendor = vendor;
-	ev.u.create.product = product;
-	ev.u.create.version = version;
-	ev.u.create.country = hogdev->bcountrycode;
-	ev.u.create.bus = BUS_BLUETOOTH;
-	ev.u.create.rd_data = value;
-	ev.u.create.rd_size = vlen;
+	if (btd_device_register_pnpid_notifier(hogdev->device,
+						pnpid_ready, hogdev)) {
+		hogdev->reportmap = g_memdup(value, vlen);
+		hogdev->reportmap_size = vlen;
+		return;
+	}
 
-	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
-		error("Failed to create uHID device: %s", strerror(errno));
+	create_uhid_device(hogdev, value, vlen);
 }
 
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -706,6 +736,7 @@ static void hog_device_free(struct hog_device *hogdev)
 	btd_device_unref(hogdev->device);
 	g_slist_free_full(hogdev->reports, report_free);
 	g_free(hogdev->hog_primary);
+	g_free(hogdev->reportmap);
 	g_free(hogdev);
 }
 
-- 
1.8.0

