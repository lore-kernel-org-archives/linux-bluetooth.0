Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 12/12] android/gatt: Add handling signed write from remote device
Date: Thu, 22 May 2014 10:07:42 +0200
Message-Id: <1400746062-24766-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index e36042a..2a0e7bc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4705,6 +4705,44 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0], &dev->bdaddr);
 }
 
+static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
+						struct gatt_device *dev)
+{
+	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t s[ATT_SIGNATURE_LEN];
+	uint16_t handle;
+	uint16_t len;
+	size_t vlen;
+	uint8_t csrk[16];
+	uint32_t sign_cnt;
+
+	if (!bt_get_csrk(&dev->bdaddr, REMOTE_CSRK, csrk, &sign_cnt)) {
+		error("gatt: No valid csrk from remote device");
+		return;
+	}
+
+	len = dec_signed_write_cmd(cmd, cmd_len, &handle, value, &vlen, s);
+	if (len) {
+		uint8_t t[ATT_SIGNATURE_LEN];
+
+		/* Generate signature and verify it */
+		if (!bt_crypto_sign_att(crypto, csrk, value, vlen, sign_cnt,
+									t)) {
+			error("gatt: Error when generating att signature");
+			return;
+		}
+
+		if (memcmp(t, s, ATT_SIGNATURE_LEN)) {
+			error("gatt: signature does not match");
+			return;
+		}
+		/* Signature OK, proceed with write */
+		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK);
+		gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
+								&dev->bdaddr);
+	}
+}
+
 static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
@@ -4791,6 +4829,10 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		write_cmd_request(ipdu, len, dev);
 		/* No response on write cmd */
 		return;
+	case ATT_OP_SIGNED_WRITE_CMD:
+		write_signed_cmd_request(ipdu, len, dev);
+		/* No response on write signed cmd */
+		return;
 	case ATT_OP_PREP_WRITE_REQ:
 		status = write_prep_request(ipdu, len, dev);
 		if (!status)
-- 
1.8.4

