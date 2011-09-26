Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 01/11] Remove timer to trigger connection attempts
Date: Mon, 26 Sep 2011 14:48:18 -0300
Message-Id: <1317059308-20038-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removes continuous timer for ATTIO connection attempts. A new approach
is being implemented managing scanning and connection attempts driven
by platform/user actions. eg: screen unlocked.
---
 src/device.c |   35 +++++------------------------------
 1 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/src/device.c b/src/device.c
index 800deb8..07409af 100644
--- a/src/device.c
+++ b/src/device.c
@@ -65,7 +65,6 @@
 
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
-#define AUTOCONNECT_INTERVAL	45
 
 /* When all services should trust a remote device */
 #define GLOBAL_TRUST "[all]"
@@ -140,7 +139,6 @@ struct btd_device {
 	GSList		*attios;
 	GSList		*attios_offline;
 	guint		attachid;		/* Attrib server attach */
-	guint		attioid;
 
 	gboolean	connected;
 
@@ -237,9 +235,6 @@ static void device_free(gpointer user_data)
 	if (device->discov_timer)
 		g_source_remove(device->discov_timer);
 
-	if (device->attioid)
-		g_source_remove(device->attioid);
-
 	DBG("%p", device);
 
 	g_free(device->authr);
@@ -1614,19 +1609,12 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 		attio->dcfunc(attio->user_data);
 }
 
-static gboolean att_auto_connect(gpointer user_data);
-
 static void attrib_disconnected(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
 
-	if ((device->attios || device->attios_offline) && device->attioid == 0)
-		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
-							att_auto_connect,
-							device);
-
 	attrib_channel_detach(device->attachid);
 	g_attrib_unref(device->attrib);
 	device->attrib = NULL;
@@ -1707,11 +1695,6 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		return;
 	}
 
-	if (device->attioid) {
-		g_source_remove(device->attioid);
-		device->attioid = 0;
-	}
-
 	attrib = g_attrib_new(io);
 	device->attachid = attrib_channel_attach(attrib, TRUE);
 	if (device->attachid == 0)
@@ -1729,7 +1712,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	}
 }
 
-static gboolean att_auto_connect(gpointer user_data)
+static gboolean att_connect(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 	struct btd_adapter *adapter = device->adapter;
@@ -1764,12 +1747,12 @@ static gboolean att_auto_connect(gpointer user_data)
 	if (io == NULL) {
 		error("ATT bt_io_connect(%s): %s", addr, gerr->message);
 		g_error_free(gerr);
-		return TRUE;
+		return FALSE;
 	}
 
 	g_io_channel_unref(io);
 
-	return TRUE;
+	return FALSE;
 }
 
 int device_browse_primary(struct btd_device *device, DBusConnection *conn,
@@ -2677,11 +2660,8 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 		device->attios_offline = g_slist_append(device->attios_offline,
 									attio);
 		g_idle_add(notify_attios, device);
-	} else if (device->attioid == 0) {
-		att_auto_connect(device);
-		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
-							att_auto_connect,
-							device);
+	} else {
+		g_idle_add(att_connect, device);
 		device->attios = g_slist_append(device->attios, attio);
 	}
 
@@ -2722,11 +2702,6 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 	if (device->attios != NULL || device->attios_offline != NULL)
 		return TRUE;
 
-	if (device->attioid) {
-		g_source_remove(device->attioid);
-		device->attioid = 0;
-	}
-
 	if (device->attachid) {
 		attrib_channel_detach(device->attachid);
 		device->attachid = 0;
-- 
1.7.6.1

