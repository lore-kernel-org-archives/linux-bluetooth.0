Return-Path: <cyrus@holtmann.org>
From: smriti <smriti.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>, smriti <smriti.gupta@stericsson.com>
Subject: [RFC BlueZ 1/1] Add provision for terminating an ATT connection
Date: Mon, 26 Dec 2011 15:46:10 +0530
Message-ID: <1324894570-15226-2-git-send-email-smriti.gupta@stericsson.com>
In-Reply-To: <1324894570-15226-1-git-send-email-smriti.gupta@stericsson.com>
References: <1324894570-15226-1-git-send-email-smriti.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function for disconnecting an ATT connection
from the client side.
---
 src/device.c |   14 ++++++++++++++
 src/device.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index e49e9bc..552df6e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2880,3 +2880,17 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	return TRUE;
 }
+
+void att_disconnect(struct btd_device *device)
+{
+	GIOChannel *io;
+
+	if (!device)
+		return;
+
+	io = g_attrib_get_channel(device->attrib);
+	if (io) {
+		g_io_channel_shutdown(io, FALSE, NULL);
+		g_io_channel_unref(io);
+	}
+}
diff --git a/src/device.h b/src/device.h
index 13005ae..bd14315 100644
--- a/src/device.h
+++ b/src/device.h
@@ -119,3 +119,4 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 						gboolean update_only);
 int device_unblock(DBusConnection *conn, struct btd_device *device,
 					gboolean silent, gboolean update_only);
+void att_disconnect(struct btd_device *device);
\ No newline at end of file
-- 
1.7.0.4

