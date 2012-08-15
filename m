Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 06/10] gap: Emit PropertyChanged for Appearance
Date: Wed, 15 Aug 2012 11:20:03 -0300
Message-Id: <1345040407-17767-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Emit PropertyChanged changed signal in the Device hierarchy when the
Appearance characteristic value is read from the remote GAP service.
---
 profiles/gap/gap.c |    2 ++
 src/device.c       |    8 ++++++++
 src/device.h       |    1 +
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/profiles/gap/gap.c b/profiles/gap/gap.c
index 4d21fb6..ff5715b 100644
--- a/profiles/gap/gap.c
+++ b/profiles/gap/gap.c
@@ -96,6 +96,8 @@ static void appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("Appearance: 0x%04x", app);
 
+	device_set_appearance(gap->device, app);
+
 	adapter_get_address(device_get_adapter(gap->device), &src);
 	device_get_address(gap->device, &dst, &type);
 
diff --git a/src/device.c b/src/device.c
index aeb2a86..ef9f1b2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2993,6 +2993,14 @@ void device_set_class(struct btd_device *device, uint32_t value)
 				DBUS_TYPE_UINT32, &value);
 }
 
+void device_set_appearance(struct btd_device *device, uint16_t value)
+{
+	DBusConnection *conn = get_dbus_connection();
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE,
+				"Appearance", DBUS_TYPE_UINT16, &value);
+}
+
 static gboolean notify_attios(gpointer user_data)
 {
 	struct btd_device *device = user_data;
diff --git a/src/device.h b/src/device.h
index 26e17f7..c3a31e9 100644
--- a/src/device.h
+++ b/src/device.h
@@ -103,6 +103,7 @@ guint device_add_disconnect_watch(struct btd_device *device,
 				GDestroyNotify destroy);
 void device_remove_disconnect_watch(struct btd_device *device, guint id);
 void device_set_class(struct btd_device *device, uint32_t value);
+void device_set_appearance(struct btd_device *device, uint16_t value);
 
 #define BTD_UUIDS(args...) ((const char *[]) { args, NULL } )
 
-- 
1.7.8.6

