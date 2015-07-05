Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:dtl1_cs: Fixed coding style
Date: Sun, 5 Jul 2015 09:56:36 +0000
Message-ID: <20150705095631.GA16694@developmental>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Removed semicolon at end of switch statement,error reported by Coccinelle

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/dtl1_cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 09c130d..84135c5 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -406,7 +406,7 @@ static int dtl1_hci_send_frame(struct hci_dev *hdev, st=
ruct sk_buff *skb)
 		break;
 	default:
 		return -EILSEQ;
-	};
+	}
=20
 	nsh.zero =3D 0;
 	nsh.len =3D skb->len;
--=20
1.7.9.5
