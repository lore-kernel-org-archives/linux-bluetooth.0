Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v8 03/13] heartrate: Add attio callbacks
Date: Tue, 25 Sep 2012 16:27:36 +0200
Message-ID: <1348583267-16816-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/heartrate/heartrate.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 87bc309..e057180 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -31,6 +31,11 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "gattrib.h"
+#include "att.h"
+#include "gatt.h"
+#include "attio.h"
+#include "log.h"
 #include "heartrate.h"
 
 struct heartrate_adapter {
@@ -41,6 +46,8 @@ struct heartrate_adapter {
 struct heartrate {
 	struct btd_device		*dev;
 	struct heartrate_adapter	*hradapter;
+	GAttrib				*attrib;
+	guint				attioid;
 };
 
 static GSList *heartrate_adapters = NULL;
@@ -82,6 +89,12 @@ static void destroy_heartrate(gpointer user_data)
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
@@ -93,6 +106,25 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hradapter);
 }
 
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	DBG("");
+
+	hr->attrib = g_attrib_ref(attrib);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	DBG("");
+
+	g_attrib_unref(hr->attrib);
+	hr->attrib = NULL;
+}
+
 int heartrate_adapter_register(struct btd_adapter *adapter)
 {
 	struct heartrate_adapter *hradapter;
@@ -137,6 +169,9 @@ int heartrate_device_register(struct btd_device *device)
 
 	hradapter->devices = g_slist_prepend(hradapter->devices, hr);
 
+	hr->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
+						attio_disconnected_cb, hr);
+
 	return 0;
 }
 
-- 
1.7.11.3

