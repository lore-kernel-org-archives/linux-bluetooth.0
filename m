Return-Path: <boris.brezillon@free-electrons.com>
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jason.abele@gmail.com,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 3/4] Bluetooth: hci_ldisc: don't release resources in hci_uart_init_work()
Date: Fri, 19 Aug 2016 09:38:46 +0200
Message-Id: <1471592327-14133-4-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This is done in hci_uart_tty_close() and can lead to double cleanup if
proto->close() is not tracking the closed/open state.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/bluetooth/hci_ldisc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index de7f7f1f995c..27f73294edcb 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -190,9 +190,7 @@ static void hci_uart_init_work(struct work_struct *work)
 	err = hci_register_dev(hu->hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device");
-		hci_free_dev(hu->hdev);
-		hu->hdev = NULL;
-		hu->proto->close(hu);
+		return;
 	}
 
 	set_bit(HCI_UART_REGISTERED, &hu->flags);
-- 
2.7.4
