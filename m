Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 01/16] Bluetooth: hci_ldisc: Add missing return in hci_uart_init_work()
Date: Fri, 7 Apr 2017 18:04:23 +0100
Message-ID: <1491584678-27228-2-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

If hci_register_dev() returns an error in hci_uart_init_work()
then the HCI_UART_REGISTERED bit gets erroneously set due to
a missing return statement. Therefore, add the missing return
statement.

The consequence of the missing return is that the HCI UART is not
registered but HCI_UART_REGISTERED is set which allows the code
to think that hu->hdev is safe to access but hu->hdev has been
freed so could lead to a crash.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 9497c46..3a65414 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -186,6 +186,7 @@ static void hci_uart_init_work(struct work_struct *work)
 		hci_free_dev(hu->hdev);
 		hu->hdev = NULL;
 		hu->proto->close(hu);
+		return;
 	}
 
 	set_bit(HCI_UART_REGISTERED, &hu->flags);
-- 
2.7.4
