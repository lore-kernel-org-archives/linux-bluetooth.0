Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/14] Bluetooth: hci_uart: Verify the Intel device address when supported
Date: Sun,  5 Apr 2015 03:04:51 -0700
Message-Id: <1428228299-28415-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI UART driver detects an Intel device, then verify that
the Bluetooth device address is valid. The generic Intel Bluetooth
support provides a function for this that just needs to be called
and it will set the quirk if needed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index dc30473563c6..dc6391a98182 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -296,6 +296,7 @@ static int hci_uart_setup(struct hci_dev *hdev)
 #ifdef CONFIG_BT_HCIUART_INTEL
 	case 2:
 		hdev->set_bdaddr = btintel_set_bdaddr;
+		btintel_check_bdaddr(hdev);
 		break;
 #endif
 #ifdef CONFIG_BT_HCIUART_BCM
-- 
2.1.0

