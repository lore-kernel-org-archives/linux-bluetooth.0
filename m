Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 08/10] core: PropertyChanged signal for Icon/Appearance
Date: Wed, 15 Aug 2012 11:20:05 -0300
Message-Id: <1345040407-17767-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch emits the PropertyChanged signal in the Device hierarchy when
the remote device Appearance characteristic is read. In general
Appearance is a static value, if the device doesn't expose the
Appearance value in the advertising data, the GAP plugin should read the
value using GATT read procedure.
---
 src/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index f14ea82..d052dd0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3001,9 +3001,14 @@ void device_set_class(struct btd_device *device, uint32_t value)
 void device_set_appearance(struct btd_device *device, uint16_t value)
 {
 	DBusConnection *conn = get_dbus_connection();
+	const char *icon = gap_appearance_to_icon(value);
 
 	emit_property_changed(conn, device->path, DEVICE_INTERFACE,
 				"Appearance", DBUS_TYPE_UINT16, &value);
+
+	if (icon)
+		emit_property_changed(conn, device->path, DEVICE_INTERFACE,
+					"Icon", DBUS_TYPE_STRING, &icon);
 }
 
 static gboolean notify_attios(gpointer user_data)
-- 
1.7.8.6

