Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 07/12] Enable ATT re-connection
Date: Wed,  6 Jul 2011 18:23:42 -0300
Message-Id: <1309987422-10075-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-8-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-8-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the link is lost and there is at least one connection callback
registered the timer for ATT automatic connection shall be enabled.
---
 src/device.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7543a80..2185b77 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1611,6 +1611,8 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 		attio->dcfunc(attio->user_data);
 }
 
+static gboolean att_auto_connect(gpointer user_data);
+
 static void attrib_destroyed(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1618,6 +1620,11 @@ static void attrib_destroyed(gpointer user_data)
 	device->attrib = NULL;
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
+
+	if (device->attioid == 0 && device->attios != NULL)
+		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
+							att_auto_connect,
+							device);
 }
 
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
@@ -1680,6 +1687,11 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		return;
 	}
 
+	if (device->attioid) {
+		g_source_remove(device->attioid);
+		device->attioid = 0;
+	}
+
 	device->attrib = g_attrib_new(io);
 	g_attrib_set_destroy_function(device->attrib, attrib_destroyed, device);
 
@@ -2561,7 +2573,7 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 	if (device->attrib && cfunc)
 		cfunc(device->attrib, user_data);
 
-	if (device->attioid == 0)
+	if (device->attioid == 0 && device->attrib == NULL)
 		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
 							att_auto_connect,
 							device);
-- 
1.7.6

