Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 11/12] android/gatt: Add support for signed write command
Date: Wed, 21 May 2014 14:45:01 +0200
Message-Id: <1400676302-13626-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index fa017e8..933f830 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2528,6 +2528,38 @@ static void write_char_cb(guint8 status, const guint8 *pdu, guint16 len,
 	free(data);
 }
 
+static bool signed_write_cmd(struct gatt_device *dev, uint16_t handle,
+					const uint8_t *value, uint16_t vlen)
+{
+	uint8_t s[ATT_SIGNATURE_LEN];
+	uint8_t csrk[16];
+	uint32_t sign_cnt;
+
+	memset(csrk, 0, 16);
+
+	if (!bt_get_csrk(&dev->bdaddr, true, csrk, &sign_cnt)) {
+		error("gatt: Could not get csrk key");
+		return false;
+	}
+
+	memset(s, 0, ATT_SIGNATURE_LEN);
+
+	if (!bt_crypto_sign_att(crypto, csrk, value, vlen, sign_cnt, s)) {
+		error("gatt: Could not sign att data");
+		return false;
+	}
+
+	if (!gatt_signed_write_cmd(dev->attrib, handle, value, vlen, s, NULL,
+									NULL)) {
+		error("gatt: Could write signed cmd");
+		return false;
+	}
+
+	bt_update_sign_counter(&dev->bdaddr, true);
+
+	return true;
+}
+
 static void handle_client_write_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_write_characteristic *cmd = buf;
@@ -2592,6 +2624,10 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 							cmd->value, cmd->len,
 							write_char_cb, cb_data);
 		break;
+	case GATT_WRITE_TYPE_SIGNED:
+		res = signed_write_cmd(conn->device, ch->ch.value_handle,
+					cmd->value, cmd->len);
+		break;
 	default:
 		error("gatt: Write type %d unsupported", cmd->write_type);
 		status = HAL_STATUS_UNSUPPORTED;
-- 
1.8.4

