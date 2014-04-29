Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 28/40] android/gatt: Move struct req_data up in the file
Date: Tue, 29 Apr 2014 18:47:17 +0200
Message-Id: <1398790049-30303-29-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is needed by following patch
---
 android/gatt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7c1c959..cd9ce86 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3733,6 +3733,11 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+struct req_data {
+	struct gatt_device *dev;
+	uint8_t opcode;
+};
+
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -3871,11 +3876,6 @@ static struct gap_srvc_handles gap_srvc_data;
 #define APPEARANCE_GENERIC_PHONE 0x0040
 #define PERIPHERAL_PRIVACY_DISABLE 0x00
 
-struct req_data {
-	struct gatt_device *dev;
-	uint8_t opcode;
-};
-
 static void gap_read_cb(uint16_t handle, uint16_t offset, void *req_data,
 						gatt_db_complete_func_t cb,
 						void *user_data)
-- 
1.8.4

