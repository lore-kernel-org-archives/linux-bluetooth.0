Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 4/8] scan: Add write scan interval window
Date: Wed, 22 Aug 2012 16:45:19 -0300
Message-Id: <1345664723-30814-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the handle discovery of the Scan Interval Window
Characteristic and writes the default value (hard-coded in the kernel)
of the scan interval, and scan window in the remote's characteristic.
---
 profiles/scanparam/scan.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 5af1e57..86bdcb7 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -29,6 +29,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
 
+#include "log.h"
 #include "adapter.h"
 #include "device.h"
 #include "att.h"
@@ -37,10 +38,18 @@
 #include "attio.h"
 #include "scan.h"
 
+#define SCAN_INTERVAL_WIN_UUID		0x2A4F
+
+#define SCAN_INTERVAL		0x0060
+#define SCAN_WINDOW		0x0030
+
 struct scan {
 	struct btd_device *device;
 	GAttrib *attrib;
+	struct att_range range;
 	guint attioid;
+	uint16_t interval;
+	uint16_t window;
 };
 
 GSList *servers = NULL;
@@ -53,11 +62,42 @@ static gint scan_device_cmp(gconstpointer a, gconstpointer b)
 	return (device == scan->device ? 0 : -1);
 }
 
+static void iwin_discovered_cb(GSList *chars, guint8 status,
+						gpointer user_data)
+{
+	struct scan *scan = user_data;
+	struct gatt_char *chr;
+	uint8_t value[4];
+
+	if (status) {
+		error("Discover Scan Interval Window: %s",
+						att_ecode2str(status));
+		return;
+	}
+
+	chr = chars->data;
+
+	DBG("Scan Interval Window handle: 0x%04x",
+						chr->value_handle);
+
+	att_put_u16(SCAN_INTERVAL, &value[0]);
+	att_put_u16(SCAN_WINDOW, &value[2]);
+
+	gatt_write_char(scan->attrib, chr->value_handle, value,
+						sizeof(value), NULL, NULL);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct scan *scan = user_data;
+	bt_uuid_t iwin_uuid;
+
+	bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
 
 	scan->attrib = g_attrib_ref(attrib);
+
+	gatt_discover_char(scan->attrib, scan->range.start, scan->range.end,
+					&iwin_uuid, iwin_discovered_cb, scan);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -74,6 +114,7 @@ int scan_register(struct btd_device *device, struct gatt_primary *prim)
 
 	scan = g_new0(struct scan, 1);
 	scan->device = btd_device_ref(device);
+	scan->range = prim->range;
 	scan->attioid = btd_device_add_attio_callback(device,
 							attio_connected_cb,
 							attio_disconnected_cb,
-- 
1.7.12

