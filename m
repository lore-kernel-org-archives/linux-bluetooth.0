Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] lib: Fix member type on le_read_advertising_channel_tx_power_rp
Date: Wed,  5 Dec 2012 21:22:50 -0400
Message-Id: <1354756970-13214-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Transmit power level range is -20 <= N <= 10, thus it should be stored
as int8_t.
---
 lib/hci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hci.h b/lib/hci.h
index 2f18ec8..196b1aa 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1492,7 +1492,7 @@ typedef struct {
 #define OCF_LE_READ_ADVERTISING_CHANNEL_TX_POWER	0x0007
 typedef struct {
 	uint8_t		status;
-	uint8_t		level;
+	int8_t		level;
 } __attribute__ ((packed)) le_read_advertising_channel_tx_power_rp;
 #define LE_READ_ADVERTISING_CHANNEL_TX_POWER_RP_SIZE 2
 
-- 
1.7.9.5

