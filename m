Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 12/12] Address remote initiated disconnection
Date: Wed, 20 Jul 2011 17:25:13 -0300
Message-Id: <1311193513-19720-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309987464-10255-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309987464-10255-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Local initiated disconnection will be triggered when the last GAttrib
reference is dropped. For remote initiated disconnection it is necessary
to track the socket HUP registering disconnection GAttrib callback.
---
 src/device.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1287f52..6cc6310 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1610,7 +1610,7 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 
 static gboolean att_auto_connect(gpointer user_data);
 
-static void attrib_destroyed(gpointer user_data)
+static void attrib_disconnected(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
@@ -1621,6 +1621,7 @@ static void attrib_destroyed(gpointer user_data)
 							att_auto_connect,
 							device);
 
+	g_attrib_unref(device->attrib);
 	device->attrib = NULL;
 }
 
@@ -1705,8 +1706,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		gatt_discover_primary(req->attrib, NULL, primary_cb, req);
 	} else if (device->attios) {
 		device->attrib = g_attrib_new(io);
-		g_attrib_set_destroy_function(device->attrib, attrib_destroyed,
-								device);
+		g_attrib_set_disconnect_function(device->attrib,
+						attrib_disconnected, device);
 		g_slist_foreach(device->attios, attio_connected,
 							device->attrib);
 	}
-- 
1.7.6

