Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: bt3c_cs.c: Fix coding style
Date: Mon, 6 Jul 2015 05:40:16 +0000
Message-ID: <20150706053935.GA2416@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Remove semicolon in switch statement, reported by coccinelle

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/bt3c_cs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 7aab654..a00bb82 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -427,7 +427,7 @@ static int bt3c_hci_send_frame(struct hci_dev *hdev, st=
ruct sk_buff *skb)
 	case HCI_SCODATA_PKT:
 		hdev->stat.sco_tx++;
 		break;
-	};
+	}
=20
 	/* Prepend skb with frame type */
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
--=20
1.7.0.4
