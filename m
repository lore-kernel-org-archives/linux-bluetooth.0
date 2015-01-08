Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 07/14] core: gatt: Issue long write for reliable-write
Date: Wed,  7 Jan 2015 21:48:21 -0800
Message-Id: <1420696108-29699-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the characteristic has the "reliable-write" extended property,
GattCharacteristic1.WriteValue will now start a reliable long-write
procedure.
---
 src/gatt-client.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 46af263..77e3539 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -870,6 +870,15 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	 *     - If value is larger than MTU - 3: long-write
 	 *   * "write-without-response" property set -> write command.
 	 */
+	if ((chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE)) {
+		supported = true;
+		chrc->write_id = start_long_write(msg, chrc->value_handle, gatt,
+						true, value, value_len,
+						chrc, chrc_write_complete);
+		if (chrc->write_id)
+			return NULL;
+	}
+
 	if (chrc->props & BT_GATT_CHRC_PROP_WRITE) {
 		uint16_t mtu;
 
-- 
2.2.0.rc0.207.ga3a616c

