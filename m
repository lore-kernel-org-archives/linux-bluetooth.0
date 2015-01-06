Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 5/8] core: gatt: Issue long write for reliable-write
Date: Mon,  5 Jan 2015 18:03:33 -0800
Message-Id: <1420509816-1376-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1420509816-1376-1-git-send-email-armansito@chromium.org>
References: <1420509816-1376-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the characteristic has the "reliable-write" extended property,
GattCharacteristic1.WriteValue will now start a reliable long-write
procedure.
---
 src/gatt-client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 79e1d26..6897f30 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -859,6 +859,14 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	 *     - If value is larger than MTU - 3: long-write
 	 *   * "write-without-response" property set -> write command.
 	 */
+	if ((chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) &&
+			start_long_write(msg, chrc->value_handle, gatt, true,
+						value, value_len,
+						characteristic_ref(chrc),
+						chrc_write_complete,
+						characteristic_unref))
+		goto done_async;
+
 	if (chrc->props & BT_GATT_CHRC_PROP_WRITE) {
 		uint16_t mtu;
 		bool result;
-- 
2.2.0.rc0.207.ga3a616c

