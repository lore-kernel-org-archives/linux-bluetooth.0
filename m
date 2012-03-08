Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 2/2] Revert "core: Add provision for terminating an ATT connection"
Date: Thu,  8 Mar 2012 15:44:39 +0200
Message-Id: <1331214279-27521-2-git-send-email-arik@wizery.com>
In-Reply-To: <1331214279-27521-1-git-send-email-arik@wizery.com>
References: <1331214279-27521-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit f89a77478af78d41c80ab7605662382b9e4e1c36.

This is not needed and actually introduces a bug. When the "Disconnect"
API of device is called device->attrib is unref-ed via a watch set on
G_IO_HUP. The channel is shutdown when the last reference is removed.

The code introduced here shuts down the channel and prevents the watch
from getting called. This means we leak a reference to device->attrib.
This can cause a number of bad things. For example, if the device is
temporary, it will never be freed, and we won't be able to pair to it
again.
---
 src/device.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index b339ac1..0a1de7c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -821,14 +821,6 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 		browse_request_cancel(device->browse);
 	}
 
-	if (device->attrib) {
-		GIOChannel *io = g_attrib_get_channel(device->attrib);
-		if (io) {
-			g_io_channel_shutdown(io, FALSE, NULL);
-			g_io_channel_unref(io);
-		}
-	}
-
 	if (msg)
 		device->disconnects = g_slist_append(device->disconnects,
 						dbus_message_ref(msg));
-- 
1.7.5.4

