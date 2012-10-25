Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 02/18] cyclingspeed: Add attio callbacks
Date: Thu, 25 Oct 2012 16:43:32 +0200
Message-ID: <1351176228-5789-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 9674a94..4d98810 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -31,6 +31,11 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "gattrib.h"
+#include "att.h"
+#include "gatt.h"
+#include "attio.h"
+#include "log.h"
 #include "cyclingspeed.h"
 
 struct csc_adapter {
@@ -41,6 +46,9 @@ struct csc_adapter {
 struct csc {
 	struct btd_device	*dev;
 	struct csc_adapter	*cadapter;
+
+	GAttrib			*attrib;
+	guint			attioid;
 };
 
 static GSList *csc_adapters = NULL;
@@ -88,10 +96,35 @@ static void destroy_csc(gpointer user_data)
 {
 	struct csc *csc = user_data;
 
+	if (csc->attioid > 0)
+		btd_device_remove_attio_callback(csc->dev, csc->attioid);
+
+	if (csc->attrib != NULL)
+		g_attrib_unref(csc->attrib);
+
 	btd_device_unref(csc->dev);
 	g_free(csc);
 }
 
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct csc *csc = user_data;
+
+	DBG("");
+
+	csc->attrib = g_attrib_ref(attrib);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct csc *csc = user_data;
+
+	DBG("");
+
+	g_attrib_unref(csc->attrib);
+	csc->attrib = NULL;
+}
+
 int csc_adapter_register(struct btd_adapter *adapter)
 {
 	struct csc_adapter *cadapter;
@@ -135,6 +168,9 @@ int csc_device_register(struct btd_device *device)
 
 	cadapter->devices = g_slist_prepend(cadapter->devices, csc);
 
+	csc->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
+						attio_disconnected_cb, csc);
+
 	return 0;
 }
 
-- 
1.8.0

