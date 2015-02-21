Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 14/18] core: gatt: Fix PropertiesChanged for "Flags"
Date: Fri, 20 Feb 2015 17:56:59 -0800
Message-Id: <1424483824-27374-15-git-send-email-armansito@chromium.org>
In-Reply-To: <1424483824-27374-1-git-send-email-armansito@chromium.org>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a bug in the GATT client API code that sent the "Flags"
property update on the wrong D-Bus object path and interface after
reading characteristic extended properties.
---
 src/gatt-client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 0364e23..7aab747 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1573,8 +1573,9 @@ static void read_ext_props_cb(bool success, uint8_t att_ecode,
 	chrc->ext_props = get_le16(value);
 	if (chrc->ext_props)
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
-						service->path,
-						GATT_SERVICE_IFACE, "Flags");
+						chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"Flags");
 
 	queue_remove(service->pending_ext_props, chrc);
 
-- 
2.2.0.rc0.207.ga3a616c

