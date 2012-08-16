Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 06/10] gatt: Emit PropertyChanged for Appearance
Date: Thu, 16 Aug 2012 17:13:07 -0300
Message-Id: <1345147991-31320-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
References: <CAKT1EBfp+iJfRSodDfoqtDB4X90BNR1wEJh_zXvw0t6JvnaWuA@mail.gmail.com>
 <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Emit PropertyChanged changed signal in the Device hierarchy when the
Appearance characteristic value is read from the remote GAP service.
---
 profiles/gatt/gas.c |    2 ++
 src/device.c        |    8 ++++++++
 src/device.h        |    1 +
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index bf603e8..8817e6d 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -95,6 +95,8 @@ static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("GAP Appearance: 0x%04x", app);
 
+	device_set_appearance(gas->device, app);
+
 	adapter_get_address(device_get_adapter(gas->device), &src);
 	device_get_address(gas->device, &dst, &type);
 
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

