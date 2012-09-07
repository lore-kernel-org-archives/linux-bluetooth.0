Return-Path: <cyrus@holtmann.org>
From: Peter Senna Tschudin <peter.senna@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: kernel-janitors@vger.kernel.org,
	Julia.Lawall@lip6.fr,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] drivers/bluetooth/btuart_cs.c: removes unnecessary semicolon
Date: Fri,  7 Sep 2012 17:24:48 +0200
Message-Id: <1347031488-26598-10-git-send-email-peter.senna@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Peter Senna Tschudin <peter.senna@gmail.com>

removes unnecessary semicolon

Found by Coccinelle: http://coccinelle.lip6.fr/

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

---
 drivers/bluetooth/btuart_cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -446,7 +446,7 @@ static int btuart_hci_send_frame(struct
 	case HCI_SCODATA_PKT:
 		hdev->stat.sco_tx++;
 		break;
-	};
+	}
 
 	/* Prepend skb with frame type */
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
