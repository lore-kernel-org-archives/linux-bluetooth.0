Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 35/40] android/gatt: Move struct req_data upper in the file
Date: Tue, 29 Apr 2014 18:47:24 +0200
Message-Id: <1398790049-30303-36-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch is needed by following patches
---
 android/gatt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index cda8697..616649f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3280,6 +3280,13 @@ failed:
 				HAL_OP_GATT_SERVER_ADD_INC_SERVICE, status);
 }
 
+struct req_data {
+	struct gatt_device *dev;
+	uint8_t opcode;
+
+	bool long_read;
+};
+
 static void handle_server_add_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_characteristic *cmd = buf;
@@ -3735,13 +3742,6 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
-struct req_data {
-	struct gatt_device *dev;
-	uint8_t opcode;
-
-	bool long_read;
-};
-
 static void gatt_request_complete(void *data, const uint8_t *pdu, uint16_t len)
 {
 	struct req_data *d = data;
-- 
1.8.4

