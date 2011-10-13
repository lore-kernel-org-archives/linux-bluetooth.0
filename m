Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/9] Add functions to manage attio callbacks
Date: Thu, 13 Oct 2011 17:29:17 +0200
Message-Id: <1318519762-17475-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1318519762-17475-4-git-send-email-sancane@gmail.com>
References: <1318519762-17475-1-git-send-email-sancane@gmail.com>
 <1318519762-17475-2-git-send-email-sancane@gmail.com>
 <1318519762-17475-3-git-send-email-sancane@gmail.com>
 <1318519762-17475-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index d43eb59..33a2b7b 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -29,6 +29,7 @@
 #include "error.h"
 #include "log.h"
 #include "gattrib.h"
+#include "attio.h"
 #include "att.h"
 #include "thermometer.h"
 
@@ -37,7 +38,9 @@
 struct thermometer {
 	DBusConnection		*conn;		/* The connection to the bus */
 	struct btd_device	*dev;		/* Device reference */
+	GAttrib			*attrib;	/* GATT connection */
 	struct att_range	*svc_range;	/* Thermometer range */
+	guint			attioid;	/* Att watcher id */
 };
 
 static GSList *thermometers = NULL;
@@ -46,6 +49,12 @@ static void destroy_thermometer(gpointer user_data)
 {
 	struct thermometer *t = user_data;
 
+	if (t->attioid > 0)
+		btd_device_remove_attio_callback(t->dev, t->attioid);
+
+	if (t->attrib != NULL)
+		g_attrib_unref(t->attrib);
+
 	dbus_connection_unref(t->conn);
 	btd_device_unref(t->dev);
 	g_free(t->svc_range);
@@ -127,6 +136,23 @@ static GDBusSignalTable thermometer_signals[] = {
 	{ }
 };
 
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct thermometer *t = user_data;
+
+	t->attrib = g_attrib_ref(attrib);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct thermometer *t = user_data;
+
+	DBG("GATT Disconnected");
+
+	g_attrib_unref(t->attrib);
+	t->attrib = NULL;
+}
+
 int thermometer_register(DBusConnection *connection, struct btd_device *device,
 						struct att_primary *tattr)
 {
@@ -151,6 +177,8 @@ int thermometer_register(DBusConnection *connection, struct btd_device *device,
 
 	thermometers = g_slist_prepend(thermometers, t);
 
+	t->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
+						attio_disconnected_cb, t);
 	return 0;
 }
 
-- 
1.7.6.1

