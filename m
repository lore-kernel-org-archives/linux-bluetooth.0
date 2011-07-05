Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 10/12] Manage GAttrib refs based on registered callbacks
Date: Tue,  5 Jul 2011 10:56:06 -0300
Message-Id: <1309874168-32716-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connection should not be dropped if there is at least one ATT connection
callback registered.
---
 src/device.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index 184252d..fa0efc0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1664,6 +1664,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 done:
 	device->browse = NULL;
 	browse_request_free(req, shutdown);
+	g_attrib_unref(device->attrib);
 }
 
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
@@ -1700,8 +1701,6 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	else if (device->attios)
 		g_slist_foreach(device->attios, attio_connected,
 							device->attrib);
-
-	g_io_channel_unref(io);
 }
 
 static gboolean att_auto_connect(gpointer user_data)
@@ -1742,6 +1741,8 @@ static gboolean att_auto_connect(gpointer user_data)
 		return TRUE;
 	}
 
+	g_io_channel_unref(io);
+
 	return TRUE;
 }
 
@@ -2568,18 +2569,22 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 	attio->dcfunc = dcfunc;
 	attio->user_data = user_data;
 
-	device->attios = g_slist_append(device->attios, attio);
-
-	if (device->attrib && cfunc)
-		cfunc(device->attrib, user_data);
+	if (device->attrib) {
+		/* First element */
+		if (device->attios == NULL)
+			device->attrib = g_attrib_ref(device->attrib);
 
-	if (device->attioid == 0 && device->attrib == NULL) {
+		if (cfunc)
+			cfunc(device->attrib, user_data);
+	} else if (device->attioid == 0) {
 		att_auto_connect(device);
 		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
 							att_auto_connect,
 							device);
 	}
 
+	device->attios = g_slist_append(device->attios, attio);
+
 	return attio->id;
 }
 
-- 
1.7.6

