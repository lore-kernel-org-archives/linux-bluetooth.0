Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH Bluez 05/11] Fix repeated connection attempt to the same remote
Date: Tue,  4 Oct 2011 15:31:21 -0300
Message-Id: <1317753081-13975-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-6-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-6-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Avoids queue dupplicated requests connects for the same device. Sources
can be triggered by auto connect or on demand connection request when a
given profile registers ATTIO connection callbacks.
---
 src/device.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 78a925c..cde2db3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -142,6 +142,7 @@ struct btd_device {
 	GSList		*attios;
 	GSList		*attios_offline;
 	guint		attachid;		/* Attrib server attach */
+	guint		auto_id;		/* Auto connect source id */
 
 	gboolean	connected;
 
@@ -239,6 +240,9 @@ static void device_free(gpointer user_data)
 	if (device->discov_timer)
 		g_source_remove(device->discov_timer);
 
+	if (device->auto_id)
+		g_source_remove(device->auto_id);
+
 	DBG("%p", device);
 
 	g_free(device->authr);
@@ -1696,6 +1700,13 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 		attio->dcfunc(attio->user_data);
 }
 
+static void att_connect_dispatched(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+
+	device->auto_id = 0;
+}
+
 static void attrib_disconnected(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1780,7 +1791,10 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 			device->browse = NULL;
 			browse_request_free(req, TRUE);
 		} else if (device->auto_connect)
-			g_idle_add(att_connect, device);
+			device->auto_id = g_idle_add_full(
+						G_PRIORITY_DEFAULT_IDLE,
+						att_connect, device,
+						att_connect_dispatched);
 
 		return;
 	}
@@ -2022,6 +2036,9 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 
 	device->auto_connect = enable;
 
+	if (device->auto_id != 0)
+		return;
+
 	if (device->attrib) {
 		DBG("Already connected");
 		return;
@@ -2030,7 +2047,9 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 	if (device->attios == NULL && device->attios_offline == NULL)
 		return;
 
-	g_idle_add(att_connect, device);
+	device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
+						att_connect, device,
+						att_connect_dispatched);
 }
 
 void device_set_type(struct btd_device *device, device_type_t type)
@@ -2775,7 +2794,10 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 									attio);
 		g_idle_add(notify_attios, device);
 	} else {
-		g_idle_add(att_connect, device);
+		device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
+						att_connect, device,
+						att_connect_dispatched);
+
 		device->attios = g_slist_append(device->attios, attio);
 	}
 
-- 
1.7.7

