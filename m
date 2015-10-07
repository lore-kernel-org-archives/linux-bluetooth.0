Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Enable parsing of LM_DIAG messages
Date: Wed,  7 Oct 2015 19:05:40 +0200
Message-Id: <1444237540-30396-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Broadcom UART based controllers can send LM_DIAG messages with the
identifier 0x07 inside the HCI stream. These messages are 63 octets in
size and have no variable payload or length indicator.

This patch adds correct parsing information for the h4_recv_buf handler
and in case these packets are received, they are forwarded to the
Bluetooth core via hci_recv_diag interface.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_bcm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 512873262055..d491a968e291 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -41,6 +41,9 @@
 #include "btbcm.h"
 #include "hci_uart.h"
 
+#define HCI_BCM_LM_DIAG_PKT 0x07
+#define HCI_BCM_LM_DIAG_SIZE 63
+
 #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
 
 struct bcm_device {
@@ -396,10 +399,18 @@ finalize:
 	return err;
 }
 
+#define BCM_RECV_LM_DIAG \
+	.type = HCI_BCM_LM_DIAG_PKT, \
+	.hlen = HCI_BCM_LM_DIAG_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = HCI_BCM_LM_DIAG_SIZE
+
 static const struct h4_recv_pkt bcm_recv_pkts[] = {
-	{ H4_RECV_ACL,   .recv = hci_recv_frame },
-	{ H4_RECV_SCO,   .recv = hci_recv_frame },
-	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+	{ H4_RECV_ACL,      .recv = hci_recv_frame },
+	{ H4_RECV_SCO,      .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
+	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
 };
 
 static int bcm_recv(struct hci_uart *hu, const void *data, int count)
-- 
2.4.3

