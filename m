Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 03/10] core: Add device method to access "Appearance"
Date: Fri, 17 Aug 2012 11:43:24 -0300
Message-Id: <1345214611-9071-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
 <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new device method to access the Appearance GAP
characteristic value stored previously as result of the discovery
procedure or GATT characteristic read procedure.
---
 src/device.c |   19 +++++++++++++++++++
 src/device.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index f781298..09a154d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3047,6 +3047,25 @@ void device_set_class(struct btd_device *device, uint32_t value)
 				DBUS_TYPE_UINT32, &value);
 }
 
+int device_get_appearance(struct btd_device *device, uint16_t *value)
+{
+	bdaddr_t src;
+	uint16_t app;
+	int err;
+
+	adapter_get_address(device_get_adapter(device), &src);
+
+	err = read_remote_appearance(&src, &device->bdaddr,
+						device->bdaddr_type, &app);
+	if (err < 0)
+		return err;
+
+	if (value)
+		*value = app;
+
+	return 0;
+}
+
 static gboolean notify_attios(gpointer user_data)
 {
 	struct btd_device *device = user_data;
diff --git a/src/device.h b/src/device.h
index 26e17f7..eb4b41e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -103,6 +103,7 @@ guint device_add_disconnect_watch(struct btd_device *device,
 				GDestroyNotify destroy);
 void device_remove_disconnect_watch(struct btd_device *device, guint id);
 void device_set_class(struct btd_device *device, uint32_t value);
+int device_get_appearance(struct btd_device *device, uint16_t *value);
 
 #define BTD_UUIDS(args...) ((const char *[]) { args, NULL } )
 
-- 
1.7.8.6

