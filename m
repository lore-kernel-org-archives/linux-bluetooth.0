Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/9] Add functions to manage attio callbacks
Date: Thu, 29 Sep 2011 15:46:23 +0200
Message-Id: <1317303988-26310-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1317303988-26310-4-git-send-email-sancane@gmail.com>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
 <1317303988-26310-3-git-send-email-sancane@gmail.com>
 <1317303988-26310-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index cdfe455..e06c6da 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -28,6 +28,7 @@
 #include "error.h"
 #include "log.h"
 #include "gattrib.h"
+#include "attio.h"
 #include "att.h"
 #include "thermometer.h"
 
@@ -36,7 +37,9 @@
 struct thermometer {
 	DBusConnection          *conn;		/* The connection to the bus */
 	struct btd_device       *dev;		/* Device reference */
+	GAttrib			*attrib;	/* GATT connection */
 	struct att_range	*svc_range;	/* Thermometer range */
+	gint                    attioid;	/* Att watcher id */
 };
 
 static GSList *thermometers = NULL;
@@ -45,6 +48,12 @@ static void destroy_thermometer(gpointer user_data)
 {
 	struct thermometer *t = user_data;
 
+	if (t->attioid)
+		btd_device_remove_attio_callback(t->dev, t->attioid);
+
+	if (t->attrib)
+		g_attrib_unref(t->attrib);
+
 	dbus_connection_unref(t->conn);
 	btd_device_unref(t->dev);
 	g_free(t->svc_range);
@@ -126,6 +135,23 @@ static GDBusSignalTable thermometer_signals[] = {
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
@@ -149,6 +175,9 @@ int thermometer_register(DBusConnection *connection, struct btd_device *device,
 	}
 
 	thermometers = g_slist_prepend(thermometers, t);
+
+	t->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
+						attio_disconnected_cb, t);
 	return 0;
 }
 
-- 
1.7.6.1

