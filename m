Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0] gatt: Fix not replying for write requests
Date: Thu, 17 Apr 2014 11:19:45 -0300
Message-Id: <1397744385-29209-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Attributes should not be unregistered dynamically unless the service
implementation calls UnregisterService() or leave the system bus.
Implementations may accidentally (or maliciously) unregister a GATT
object (characteristic or descriptor) belonging to a service hierarchy.
gdbus automatically tracks InterfacesRemoved() signal, and destroys the
GDBusProxy associated with the removed interfaces. Subsequent calls of
g_dbus_proxy_set_property_array() returns FALSE, and it needs to be
handled properly since the GDBusProxy result callback will not be called.
---
 src/gatt-dbus.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 26437e7..c22e8af 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -332,9 +332,13 @@ static void proxy_write_cb(struct btd_attribute *attr,
 		wdata->result_cb = result;
 		wdata->user_data = user_data;
 
-		g_dbus_proxy_set_property_array(proxy, "Value", DBUS_TYPE_BYTE,
-						value, len, proxy_write_reply,
-						wdata, g_free);
+		if (!g_dbus_proxy_set_property_array(proxy, "Value",
+						DBUS_TYPE_BYTE, value, len,
+						proxy_write_reply,
+						wdata, g_free)) {
+			g_free(wdata);
+			result(-ENOENT, user_data);
+		}
 	} else {
 		/*
 		 * Caller is not interested in the Set method call result.
-- 
1.8.3.1

