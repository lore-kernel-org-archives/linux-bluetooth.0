Return-Path: <t.jag587@gmail.com>
From: jagadish tirumala <t.jag587@gmail.com>
Subject: PATCH fixed coding style error in drivers/bluetooth/hci_serdev.c
To: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org
Message-ID: <2a6059f5-e3f8-9a15-1319-f1189fdd4d83@gmail.com>
Date: Mon, 11 Jun 2018 08:11:37 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------20913770CDC48C1AF8066F58"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------20913770CDC48C1AF8066F58
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

HI , This is Jagdish , I have fixed a coding style ERROR: space required
before the open parenthesis in drivers/bluetooth/hci_serdev.c , please
have a look

Jagdish



--------------20913770CDC48C1AF8066F58
Content-Type: text/x-patch;
 name="0001-fixed-coding-style-error.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-fixed-coding-style-error.patch"

>From 3c3e844d0f0ba49a6d40a7265548f81316f756e4 Mon Sep 17 00:00:00 2001
From: Jagdish587 <t.jag587@gmail.com>
Date: Sun, 10 Jun 2018 04:15:53 -0700
Subject: [PATCH 1/1] fixed coding style error

Signed-off-by: Jagdish587 <t.jag587@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index aa2543b..d41c520 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -94,7 +94,7 @@ static void hci_uart_write_work(struct work_struct *work)
 			hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
 			kfree_skb(skb);
 		}
-	} while(test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
+	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
 
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 }
-- 
2.7.4



--------------20913770CDC48C1AF8066F58--
