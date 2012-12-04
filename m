Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 02/20] cyclingspeed: Add attio callbacks
Date: Tue, 4 Dec 2012 13:43:28 +0100
Message-ID: <1354625026-29358-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 025b09a..e0f458d 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -33,6 +33,11 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "attrib/gattrib.h"
+#include "attrib/att.h"
+#include "attrib/gatt.h"
+#include "attio.h"
+#include "log.h"
 
 struct csc_adapter {
 	struct btd_adapter	*adapter;
@@ -42,6 +47,9 @@ struct csc_adapter {
 struct csc {
 	struct btd_device	*dev;
 	struct csc_adapter	*cadapter;
+
+	GAttrib			*attrib;
+	guint			attioid;
 };
 
 static GSList *csc_adapters = NULL;
@@ -89,10 +97,35 @@ static void destroy_csc(gpointer user_data)
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
 static int csc_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	struct csc_adapter *cadapter;
@@ -138,6 +171,9 @@ static int csc_device_probe(struct btd_profile *p,
 
 	cadapter->devices = g_slist_prepend(cadapter->devices, csc);
 
+	csc->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
+						attio_disconnected_cb, csc);
+
 	return 0;
 }
 
-- 
1.8.0

