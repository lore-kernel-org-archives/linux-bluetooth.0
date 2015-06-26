Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] core: Fix accepting connections while disconnecting
Date: Fri, 26 Jun 2015 14:59:00 +0300
Message-Id: <1435319940-13943-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1435319940-13943-1-git-send-email-luiz.dentz@gmail.com>
References: <1435319940-13943-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is being disconnected locally any profile connection shall
be rejected since the ACL link will be dropped.
---
 src/adapter.c | 5 +++++
 src/device.c  | 5 +++++
 src/device.h  | 1 +
 3 files changed, 11 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 531f276..59c90d2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5825,6 +5825,11 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	if (!device)
 		return 0;
 
+	if (device_is_disconnecting(device)) {
+		DBG("Authorization request while disconnecting");
+		return 0;
+	}
+
 	/* Device connected? */
 	if (!g_slist_find(adapter->connections, device))
 		error("Authorization request for non-connected device!?");
diff --git a/src/device.c b/src/device.c
index a784cae..debe201 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1397,6 +1397,11 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 							device);
 }
 
+bool device_is_disconnecting(struct btd_device *device)
+{
+	return device->disconn_timer > 0;
+}
+
 static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
 	char addr[18];
diff --git a/src/device.h b/src/device.h
index 1955f54..db10827 100644
--- a/src/device.h
+++ b/src/device.h
@@ -121,6 +121,7 @@ gboolean device_is_authenticating(struct btd_device *device);
 void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type);
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
+bool device_is_disconnecting(struct btd_device *device);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
 					void *user_data);
-- 
2.1.0

