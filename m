Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Default to internal use manufacturer identifier
Date: Wed,  2 Jul 2014 11:30:51 +0200
Message-Id: <1404293451-14505-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When allocating a new controller structure, then default to the internal
use value 0xffff first. Default to 0x0000 is a bad idea since that is
the manufacturer identifier of Ericsson Technology Licensing.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 63197d70d8eb..21a4c8dfb874 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3796,6 +3796,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->link_mode = (HCI_LM_ACCEPT);
 	hdev->num_iac = 0x01;		/* One IAC support is mandatory */
 	hdev->io_capability = 0x03;	/* No Input No Output */
+	hdev->manufacturer = 0xffff;	/* Default to internal use */
 	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
 	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
 
-- 
1.9.3

