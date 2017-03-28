Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [RFC V1 03/16] Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY
Date: Tue, 28 Mar 2017 18:50:16 +0100
Message-ID: <1490723429-28870-4-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
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
index a351cc7..1887ad4 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -187,6 +187,7 @@ static void hci_uart_init_work(struct work_struct *work)
 		hdev = hu->hdev;
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
+		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		hu->proto->close(hu);
 		return;
 	}
-- 
2.7.4
