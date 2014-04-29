Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 31/36] android/gatt: Move struct req_data upper in the file
Date: Tue, 29 Apr 2014 03:15:02 +0200
Message-Id: <1398734107-4793-33-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch is needed by following patches
---
 android/gatt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 581ccc0..2eb5b18 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3293,6 +3293,13 @@ failed:
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
@@ -3748,13 +3755,6 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
-struct req_data {
-	struct gatt_device *dev;
-	uint8_t opcode;
-
-	bool long_read;
-};
-
 static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 					struct gatt_device *dev)
 {
-- 
1.8.4

