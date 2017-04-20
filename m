Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V3 3/3] Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY
Date: Thu, 20 Apr 2017 18:06:41 +0100
Message-ID: <1492708001-30228-4-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1492708001-30228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1492708001-30228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Ensure that HCI_UART_PROTO_READY is cleared before close(hu) is
called which closes the Data Link protocol layer.

Therefore, add the missing bit clear of HCI_UART_PROTO_READY to
hci_uart_init_work() so that the flag is cleared when
hci_register_dev fails.

Without the fix, the functions of the Data Link protocol layer could
potentially be accessed after that layer has been closed. This
could lead to a crash as memory would have been freed in that layer.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index b1096d1..c53513c 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -188,6 +188,7 @@ static void hci_uart_init_work(struct work_struct *work)
 		hdev = hu->hdev;
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
+		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		hu->proto->close(hu);
 		return;
 	}
-- 
2.7.4
