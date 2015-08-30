Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Fix a few tab vs spaces issues
Date: Sun, 30 Aug 2015 23:05:32 +0200
Message-Id: <1440968732-93664-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 6b9b91267959..a8aa077f4055 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -41,13 +41,13 @@
 #define HCI_IBS_SLEEP_IND	0xFE
 #define HCI_IBS_WAKE_IND	0xFD
 #define HCI_IBS_WAKE_ACK	0xFC
-#define HCI_MAX_IBS_SIZE 	10
+#define HCI_MAX_IBS_SIZE	10
 
 /* Controller states */
 #define STATE_IN_BAND_SLEEP_ENABLED	1
 
-#define IBS_WAKE_RETRANS_TIMEOUT_MS 	100
-#define IBS_TX_IDLE_TIMEOUT_MS 		2000
+#define IBS_WAKE_RETRANS_TIMEOUT_MS	100
+#define IBS_TX_IDLE_TIMEOUT_MS		2000
 #define BAUDRATE_SETTLE_TIMEOUT_MS	300
 
 /* HCI_IBS transmit side sleep protocol states */
-- 
2.4.3

