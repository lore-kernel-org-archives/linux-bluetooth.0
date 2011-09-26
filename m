Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH BlueZ 10/11] Enable re-connection if reason is Timeout
Date: Mon, 26 Sep 2011 14:48:27 -0300
Message-Id: <1317059308-20038-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

The re-connection timer must be added just when the disconnection reason
was "Connection timeout" for GATT based profiles.
---
 src/device.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3407dc3..29db509 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1623,15 +1623,36 @@ static void att_connect_dispatched(gpointer user_data)
 	device->auto_id = 0;
 }
 
+static gboolean att_connect(gpointer user_data);
+
 static void attrib_disconnected(gpointer user_data)
 {
 	struct btd_device *device = user_data;
+	GIOChannel *io;
+	int sock, err = 0;
+	socklen_t len;
+
+	io = g_attrib_get_channel(device->attrib);
+	sock = g_io_channel_unix_get_fd(io);
+	len = sizeof(err);
+	getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len);
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
 
 	attrib_channel_detach(device->attachid);
 	g_attrib_unref(device->attrib);
 	device->attrib = NULL;
+
+	if (device->auto_connect == FALSE)
+		return;
+
+	if (err != ETIMEDOUT)
+		return;
+
+	device->auto_id = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT_IDLE,
+						AUTO_CONNECTION_INTERVAL,
+						att_connect, device,
+						att_connect_dispatched);
 }
 
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
@@ -1687,8 +1708,6 @@ done:
 	browse_request_free(req, shutdown);
 }
 
-static gboolean att_connect(gpointer user_data);
-
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct btd_device *device = user_data;
-- 
1.7.6.1

