Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 07/10] core: PropertyChanged signal for Icon/class
Date: Fri, 17 Aug 2012 11:43:28 -0300
Message-Id: <1345214611-9071-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
 <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch emits the PropertyChanged signal in the Device hierarchy when
the remote device class is updated.
---
 src/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index f612bb0..7657a74 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2988,9 +2988,14 @@ void btd_device_unref(struct btd_device *device)
 void device_set_class(struct btd_device *device, uint32_t value)
 {
 	DBusConnection *conn = get_dbus_connection();
+	const char *icon = class_to_icon(value);
 
 	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Class",
 				DBUS_TYPE_UINT32, &value);
+
+	if (icon)
+		emit_property_changed(conn, device->path, DEVICE_INTERFACE,
+					"Icon", DBUS_TYPE_STRING, &icon);
 }
 
 int device_get_appearance(struct btd_device *device, uint16_t *value)
-- 
1.7.8.6

