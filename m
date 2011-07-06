Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 12/12] Address remote initiated disconnection
Date: Wed,  6 Jul 2011 18:24:24 -0300
Message-Id: <1309987464-10255-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-13-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-13-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Local initiated disconnection will be triggered when the last GAttrib
reference is dropped. For remote initiated disconnection it is necessary
to track the socket HUP registering disconnection GAttrib callback.
---
 src/device.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 52462be..90761d4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1615,7 +1615,7 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 
 static gboolean att_auto_connect(gpointer user_data);
 
-static void attrib_destroyed(gpointer user_data)
+static void attrib_disconnected(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
@@ -1627,6 +1627,13 @@ static void attrib_destroyed(gpointer user_data)
 							att_auto_connect,
 							device);
 
+	g_attrib_unref(device->attrib);
+}
+
+static void attrib_destroyed(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+
 	device->attrib = NULL;
 }
 
@@ -1697,6 +1704,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	}
 
 	device->attrib = g_attrib_new(io);
+	g_attrib_set_disconnect_function(device->attrib, attrib_disconnected,
+								device);
 	g_attrib_set_destroy_function(device->attrib, attrib_destroyed, device);
 
 	if (req)
-- 
1.7.6

