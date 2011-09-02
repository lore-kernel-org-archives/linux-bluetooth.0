Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 11/11] Enable re-connections when disconnected
Date: Fri,  2 Sep 2011 18:38:41 -0300
Message-Id: <1314999521-11261-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the device is still on auto connect mode, re-connections should
be enabled. The current implementation has a limitation: it ignores
the disconnection reason. Re-connection should be enabled if the host
initiated the disconnection.
---
 src/device.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 4f58afc..b7b7bb8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1616,6 +1616,9 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 		attio->dcfunc(attio->user_data);
 }
 
+static gboolean att_connect(gpointer user_data);
+static void att_connect_dispatched(gpointer user_data);
+
 static void attrib_disconnected(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1625,6 +1628,14 @@ static void attrib_disconnected(gpointer user_data)
 	attrib_channel_detach(device->attachid);
 	g_attrib_unref(device->attrib);
 	device->attrib = NULL;
+
+	if (device->auto_connect == FALSE)
+		return;
+
+	device->auto_id = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT_IDLE,
+						AUTO_CONNECTION_INTERVAL,
+						att_connect, device,
+						att_connect_dispatched);
 }
 
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
@@ -1680,8 +1691,6 @@ done:
 	browse_request_free(req, shutdown);
 }
 
-static gboolean att_connect(gpointer user_data);
-
 static void att_connect_dispatched(gpointer user_data)
 {
 	struct btd_device *device = user_data;
-- 
1.7.6

