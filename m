Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Correct att err variable
Date: Tue, 13 Jun 2017 13:57:12 +0200
Message-Id: <20170613115712.31349-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Core specification version 5.0 (Vol 3, Part F, 3.4.1.1)
error code size is one byte.
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 58ab0b8..fbf90ff 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1239,7 +1239,7 @@ static void enable_ccc_callback(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
 	struct notify_data *notify_data = user_data;
-	uint16_t att_ecode;
+	uint8_t att_ecode;
 
 	assert(notify_data->chrc->ccc_write_id);
 
-- 
2.9.4

