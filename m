Return-Path: <t.jag587@gmail.com>
Date: Sat, 8 Sep 2018 04:18:07 -0700
From: jagadish tirumala <t.jag587@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	trivial@kernel.org
Subject: PATCH fixed error space required before the open parenthesis 
Message-ID: <20180908111807.GA1931@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
List-ID: <linux-bluetooth.vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi , I have fixed error space required before the open parenthesis in drivers/bluetooth/hci_serdev.c

--MGYHOYXEY6WxJCY8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-fixed-error-space-required-before-the-open-parenthes.patch"

>From 084feec211eb99e6658d9ad11152406348716ced Mon Sep 17 00:00:00 2001
From: Jagdish Tirumala <t.jag587@gmail.com>
Date: Sat, 8 Sep 2018 03:36:34 -0700
Subject: [PATCH] fixed error space required before the open parenthesis

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


--MGYHOYXEY6WxJCY8--
