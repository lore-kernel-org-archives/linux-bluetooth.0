Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Allow signed write only on non encrypted link
Date: Thu, 12 Jun 2014 13:12:30 +0200
Message-Id: <1402571550-8896-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 3ec4118..3e9f092 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2719,6 +2719,22 @@ static bool signed_write_cmd(struct gatt_device *dev, uint16_t handle,
 	return true;
 }
 
+static int get_sec_level(struct gatt_device *dev)
+{
+	GIOChannel *io;
+	int sec_level;
+
+	io = g_attrib_get_channel(dev->attrib);
+
+	if (!bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
+							BT_IO_OPT_INVALID)) {
+		error("gatt: Failed to get sec_level");
+		return -1;
+	}
+
+	return sec_level;
+}
+
 static void handle_client_write_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_write_characteristic *cmd = buf;
@@ -2784,8 +2800,14 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 							write_char_cb, cb_data);
 		break;
 	case GATT_WRITE_TYPE_SIGNED:
-		res = signed_write_cmd(conn->device, ch->ch.value_handle,
-					cmd->value, cmd->len);
+		if (get_sec_level(conn->device) != BT_SECURITY_LOW) {
+			error("gatt: Cannot write signed on encrypted link");
+			res = HAL_STATUS_FAILED;
+		} else {
+			res = signed_write_cmd(conn->device,
+							ch->ch.value_handle,
+							cmd->value, cmd->len);
+		}
 		break;
 	default:
 		error("gatt: Write type %d unsupported", cmd->write_type);
@@ -5184,6 +5206,12 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	uint8_t csrk[16];
 	uint32_t sign_cnt;
 
+	if (get_sec_level(dev) != BT_SECURITY_LOW) {
+		error("gatt: Remote tries write signed on encrypted link");
+		connection_cleanup(dev);
+		return;
+	}
+
 	if (!bt_get_csrk(&dev->bdaddr, REMOTE_CSRK, csrk, &sign_cnt)) {
 		error("gatt: No valid csrk from remote device");
 		return;
-- 
1.8.4

