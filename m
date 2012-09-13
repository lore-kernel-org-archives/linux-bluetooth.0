Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v5 03/17] heartrate: Add attio callbacks
Date: Thu, 13 Sep 2012 16:31:37 +0200
Message-ID: <1347546711-19961-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347546711-19961-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347546711-19961-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/heartrate/heartrate.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 17514c0..918546e 100644
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
 struct heartrate {
 	struct btd_device		*dev;
 	struct heartrate_adapter	*hra;
+	GAttrib				*attrib;
+	guint				attioid;
 };
 
 static GSList *heartrate_adapters = NULL;
@@ -82,6 +89,12 @@ static void destroy_heartrate_device(gpointer user_data)
 {
 	struct heartrate *hr = user_data;
 
+	if (hr->attioid > 0)
+		btd_device_remove_attio_callback(hr->dev, hr->attioid);
+
+	if (hr->attrib != NULL)
+		g_attrib_unref(hr->attrib);
+
 	btd_device_unref(hr->dev);
 	g_free(hr);
 }
@@ -90,9 +103,31 @@ static void destroy_heartrate_adapter(gpointer user_data)
 {
 	struct heartrate_adapter *hra = user_data;
 
+	if (hra->devices != NULL)
+		g_slist_free_full(hra->devices, destroy_heartrate_device);
+
 	g_free(hra);
 }
 
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	DBG("GATT Connected");
+
+	hr->attrib = g_attrib_ref(attrib);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	DBG("GATT Disconnected");
+
+	g_attrib_unref(hr->attrib);
+	hr->attrib = NULL;
+}
+
 int heartrate_adapter_register(struct btd_adapter *adapter)
 {
 	struct heartrate_adapter *hra;
@@ -137,6 +172,11 @@ int heartrate_device_register(struct btd_device *device)
 
 	hra->devices = g_slist_prepend(hra->devices, hr);
 
+	hr->attioid = btd_device_add_attio_callback(device,
+						attio_connected_cb,
+						attio_disconnected_cb,
+						hr);
+
 	return 0;
 }
 
-- 
1.7.11.3

