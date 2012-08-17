Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 09/10] core: Add storing Appearance
Date: Fri, 17 Aug 2012 11:43:30 -0300
Message-Id: <1345214611-9071-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
 <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch stores the Appearance characteristic value read from the
remote GAP service.
---
 src/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index d0d178c..f6161aa 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3021,6 +3021,7 @@ void device_set_appearance(struct btd_device *device, uint16_t value)
 {
 	DBusConnection *conn = get_dbus_connection();
 	const char *icon = gap_appearance_to_icon(value);
+	bdaddr_t src;
 
 	emit_property_changed(conn, device->path, DEVICE_INTERFACE,
 				"Appearance", DBUS_TYPE_UINT16, &value);
@@ -3028,6 +3029,10 @@ void device_set_appearance(struct btd_device *device, uint16_t value)
 	if (icon)
 		emit_property_changed(conn, device->path, DEVICE_INTERFACE,
 					"Icon", DBUS_TYPE_STRING, &icon);
+
+	adapter_get_address(device_get_adapter(device), &src);
+	write_remote_appearance(&src, &device->bdaddr, device->bdaddr_type,
+									value);
 }
 
 static gboolean notify_attios(gpointer user_data)
-- 
1.7.8.6

