Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 26/33] lib: Maximum value to advertising and scan response
Date: Mon, 27 Aug 2012 13:03:18 -0400
Message-Id: <1346087005-24693-27-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Create a constant to define the maximum lenght to advertising and scan
response data format.
---
 lib/hci.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index f90ac26..c93b1c6 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1496,17 +1496,19 @@ typedef struct {
 } __attribute__ ((packed)) le_read_advertising_channel_tx_power_rp;
 #define LE_READ_ADVERTISING_CHANNEL_TX_POWER_RP_SIZE 2
 
+#define HCI_LE_MAX_ADV_DATA_LENGTH		31
+
 #define OCF_LE_SET_ADVERTISING_DATA		0x0008
 typedef struct {
 	uint8_t		length;
-	uint8_t		data[31];
+	uint8_t		data[HCI_LE_MAX_ADV_DATA_LENGTH];
 } __attribute__ ((packed)) le_set_advertising_data_cp;
 #define LE_SET_ADVERTISING_DATA_CP_SIZE 32
 
 #define OCF_LE_SET_SCAN_RESPONSE_DATA		0x0009
 typedef struct {
 	uint8_t		length;
-	uint8_t		data[31];
+	uint8_t		data[HCI_LE_MAX_ADV_DATA_LENGTH];
 } __attribute__ ((packed)) le_set_scan_response_data_cp;
 #define LE_SET_SCAN_RESPONSE_DATA_CP_SIZE 32
 
-- 
1.7.9.5

