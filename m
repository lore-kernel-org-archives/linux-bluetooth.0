Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v4 03/17] heartrate: Add attio callbacks
Date: Thu, 13 Sep 2012 14:13:07 +0200
Message-ID: <1347538401-6417-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change-Id: I9f5d69c1c0d50160e4a7c2c27c92fb159c197fa1
---
 profiles/heartrate/heartrate.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 06cb12a..6b470e5 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -31,7 +31,12 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "gattrib.h"
+#include "attio.h"
+#include "att.h"
+#include "gatt.h"
 #include "heartrate.h"
+#include "log.h"
 
 struct heartrate_adapter {
 	struct btd_adapter	*adapter;
@@ -41,6 +46,8 @@ struct heartrate_adapter {
 struct heartrate_device {
 	struct btd_device		*dev;
 	struct heartrate_adapter	*hr;
+	GAttrib				*attrib;
+	guint				attioid;
 };
 
 static GSList *heartrate_adapters = NULL;
@@ -82,6 +89,12 @@ static void destroy_heartrate_device(gpointer user_data)
 {
 	struct heartrate_device *hrdev = user_data;
 
+	if (hrdev->attioid > 0)
+		btd_device_remove_attio_callback(hrdev->dev, hrdev->attioid);
+
+	if (hrdev->attrib != NULL)
+		g_attrib_unref(hrdev->attrib);
+
 	btd_device_unref(hrdev->dev);
 	g_free(hrdev);
 }
@@ -90,9 +103,31 @@ static void destroy_heartrate_adapter(gpointer user_data)
 {
 	struct heartrate_adapter *hr = user_data;
 
+	if (hr->devices != NULL)
+		g_slist_free_full(hr->devices, destroy_heartrate_device);
+
 	g_free(hr);
 }
 
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct heartrate_device *hrdev = user_data;
+
+	DBG("GATT Connected");
+
+	hrdev->attrib = g_attrib_ref(attrib);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct heartrate_device *hrdev = user_data;
+
+	DBG("GATT Disconnected");
+
+	g_attrib_unref(hrdev->attrib);
+	hrdev->attrib = NULL;
+}
+
 int heartrate_adapter_register(struct btd_adapter *adapter)
 {
 	struct heartrate_adapter *hr;
@@ -136,6 +171,11 @@ int heartrate_device_register(struct btd_device *device)
 
 	hr->devices = g_slist_prepend(hr->devices, hrdev);
 
+	hrdev->attioid = btd_device_add_attio_callback(device,
+						attio_connected_cb,
+						attio_disconnected_cb,
+						hrdev);
+
 	return 0;
 }
 void heartrate_device_unregister(struct btd_device *device)
-- 
1.7.11.3

