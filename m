Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 2/2] core/gatt-client: fix losing notifications
Date: Fri, 18 Sep 2015 00:44:59 -0700
Message-Id: <1442562299-4954-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1442562299-4954-1-git-send-email-jpawlowski@google.com>
References: <1442562299-4954-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When notifications are quickly send to BlueZ, it tries to signal that
through dbus using g_dbus_emit_property_changed, which would merge all
changes and schedule sending property changed in g_iddle_add.

If the stream of notifications from device is fast enough, there might be
no iddle moment to send properties changed before next notification
arives, which would result in notifications being lost.

This patch fixes that by using method that sends properties changed
immediately, without waiting for iddle moment.
---
 src/gatt-client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 399133a..0d234e3 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -778,8 +778,9 @@ static void write_characteristic_cb(struct gatt_db_attribute *attr, int err,
 	if (err)
 		return;
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->path,
-					GATT_CHARACTERISTIC_IFACE, "Value");
+	g_dbus_emit_property_changed_flush(btd_get_dbus_connection(),
+			chrc->path, GATT_CHARACTERISTIC_IFACE, "Value", true);
+
 }
 
 static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
-- 
2.5.0

