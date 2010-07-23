Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Jul 2010 12:11:04 +0200
From: Dan Carpenter <error27@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Suraj Sumangala <suraj@atheros.com>, linux-bluetooth@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [patch -next] bluetooth/hci_ath: kfree() => kfree_skb()
Message-ID: <20100723101104.GD26313@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

sk_buffs have to be freed with kfree_skb() instead of kfree().

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 5ab258b..74a8f61 100755
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -163,7 +163,7 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	struct ath_struct *ath = hu->priv;
 
 	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
-		kfree(skb);
+		kfree_skb(skb);
 		return 0;
 	}
 
