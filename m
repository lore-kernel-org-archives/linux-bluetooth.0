Return-Path: <cyrus@holtmann.org>
From: Smriti Gupta <smriti.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>, <smritigupta2008@gmail.com>,
	Smriti Gupta <smriti.gupta@stericsson.com>
Subject: [PATCH BlueZ v2 1/1] Add provision for terminating an ATT connection
Date: Fri, 20 Jan 2012 17:24:26 +0530
Message-ID: <1327060466-17978-2-git-send-email-smriti.gupta@stericsson.com>
In-Reply-To: <1327060466-17978-1-git-send-email-smriti.gupta@stericsson.com>
References: <1327060466-17978-1-git-send-email-smriti.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to terminate any existing ATT connection from the client side
existing function device_request_disconnect has been updated.
---
 src/device.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 16855b1..7b5107b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -781,6 +781,7 @@ static void bonding_request_cancel(struct bonding_req *bonding)
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 {
 	DBusConnection *conn = get_dbus_connection();
+	GIOChannel *io;
 
 	if (device->bonding)
 		bonding_request_cancel(device->bonding);
@@ -790,6 +791,14 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 		browse_request_cancel(device->browse);
 	}
 
+	if (device->attrib) {
+		io = g_attrib_get_channel(device->attrib);
+		if (io) {
+			g_io_channel_shutdown(io, FALSE, NULL);
+			g_io_channel_unref(io);
+		}
+	}
+
 	if (msg)
 		device->disconnects = g_slist_append(device->disconnects,
 						dbus_message_ref(msg));
-- 
1.7.0.4

