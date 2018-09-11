Return-Path: <t.jag587@gmail.com>
From: Jagdish Tirumala <t.jag587@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH] Bluetooth: hci_serdev: Fixed error space required before open paranethesis
Date: Tue, 11 Sep 2018 08:40:38 -0700
Message-Id: <20180911154038.2142-1-t.jag587@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed error in space required before paranthesis
in drivers/bluetooth/hci_serdev.c

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index aa2543b3c286..d41c520e8970 100644
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
2.17.1
