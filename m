Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 07/10] core: PropertyChanged signal for Icon/class
Date: Thu, 16 Aug 2012 17:13:08 -0300
Message-Id: <1345147991-31320-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
References: <CAKT1EBfp+iJfRSodDfoqtDB4X90BNR1wEJh_zXvw0t6JvnaWuA@mail.gmail.com>
 <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch emits the PropertyChanged signal in the Device hierarchy when
the remote device class is updated.
---
 src/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index ef9f1b2..f14ea82 100644
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
 
 void device_set_appearance(struct btd_device *device, uint16_t value)
-- 
1.7.8.6

