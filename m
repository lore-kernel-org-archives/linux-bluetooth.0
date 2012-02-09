Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/7] device: Fix notifying ATTIO drivers when browsing
Date: Thu,  9 Feb 2012 12:56:04 -0300
Message-Id: <1328802969-20244-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If disconnection happens during the primary service discovery ATTIO
drivers should not be notified.
---
 src/device.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/src/device.c b/src/device.c
index f57f090..9c851ea 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1749,6 +1749,9 @@ static void attrib_disconnected(gpointer user_data)
 	int sock, err = 0;
 	socklen_t len;
 
+	if (device->browse)
+		goto done;
+
 	io = g_attrib_get_channel(device->attrib);
 	sock = g_io_channel_unix_get_fd(io);
 	len = sizeof(err);
@@ -1756,21 +1759,19 @@ static void attrib_disconnected(gpointer user_data)
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
 
-	attrib_channel_detach(device->attrib, device->attachid);
-	g_attrib_unref(device->attrib);
-	device->attrib = NULL;
-	device->attachid = 0;
-
-	if (device->auto_connect == FALSE)
-		return;
-
-	if (err != ETIMEDOUT)
-		return;
+	if (device->auto_connect == FALSE || err != ETIMEDOUT)
+		goto done;
 
 	device->auto_id = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT_IDLE,
 						AUTO_CONNECTION_INTERVAL,
 						att_connect, device,
 						att_connect_dispatched);
+
+done:
+	attrib_channel_detach(device->attrib, device->attachid);
+	device->attachid = 0;
+	g_attrib_unref(device->attrib);
+	device->attrib = NULL;
 }
 
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
@@ -1801,9 +1802,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 		device->attachid = 0;
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
-	} else
-		g_attrib_set_disconnect_function(device->attrib,
-						attrib_disconnected, device);
+	}
 
 	g_slist_free(uuids);
 
-- 
1.7.8.4

