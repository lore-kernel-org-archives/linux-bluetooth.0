Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_uart: Add Nokia Protocol identifier
Date: Mon, 19 Sep 2016 11:32:35 +0200
Message-Id: <1474277555-18094-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Will be used by hci_nokia extra protocol.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_uart.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 839bad1..22b7c58 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	10
+#define HCI_UART_MAX_PROTO	11
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -47,6 +47,7 @@
 #define HCI_UART_BCM	7
 #define HCI_UART_QCA	8
 #define HCI_UART_AG6XX	9
+#define HCI_UART_NOKIA	10
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
1.9.1

