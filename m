Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 5/5] Send D-Bus signal to propagate disconnect reason
Date: Mon, 14 May 2012 17:33:04 +0200
Message-Id: <1337009584-17181-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Propagate the disconnection reason through D-Bus, allowing other
components to react accordingly.
---
 src/device.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index b2b9d54..8c124d1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -891,6 +891,7 @@ static GDBusMethodTable device_methods[] = {
 static GDBusSignalTable device_signals[] = {
 	{ "PropertyChanged",		"sv"	},
 	{ "DisconnectRequested",	""	},
+	{ "Disconnected",		"y"	},
 	{ }
 };
 
@@ -942,6 +943,11 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn,
 	if (device_is_paired(device) && !device_is_bonded(device))
 		device_set_paired(device, FALSE);
 
+	g_dbus_emit_signal(conn, device->path,
+			DEVICE_INTERFACE, "Disconnected",
+			DBUS_TYPE_BYTE, &reason,
+			DBUS_TYPE_INVALID);
+
 	emit_property_changed(conn, device->path,
 					DEVICE_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &device->connected);
-- 
1.7.7.6

