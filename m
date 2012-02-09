Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/7] device: Fix trying to connect if already connected
Date: Thu,  9 Feb 2012 12:56:05 -0300
Message-Id: <1328802969-20244-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

---
 src/device.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9c851ea..2502906 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1966,9 +1966,15 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	req = g_new0(struct browse_req, 1);
 	req->device = btd_device_ref(device);
-
 	adapter_get_address(adapter, &src);
 
+	device->browse = req;
+
+	if (device->attrib) {
+		gatt_discover_primary(device->attrib, NULL, primary_cb, req);
+		goto done;
+	}
+
 	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
 
 	attcb = g_new0(struct att_callbacks, 1);
@@ -1990,11 +1996,10 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 		return -EIO;
 	}
 
+done:
 	if (conn)
 		req->conn = dbus_connection_ref(conn);
 
-	device->browse = req;
-
 	if (msg) {
 		const char *sender = dbus_message_get_sender(msg);
 
-- 
1.7.8.4

