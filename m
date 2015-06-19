Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: dtl1_cs: Fix coding style -- clean up
Date: Fri, 19 Jun 2015 08:46:15 +0000
Message-ID: <20150619084607.GA20912@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Braces {} are not necessary for single statement blocks reported by
checkpatch

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/dtl1_cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 78e10f0..01a967f 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -182,9 +182,9 @@ static void dtl1_control(struct dtl1_info *info, struct=
 sk_buff *skb)
 	int i;
=20
 	printk(KERN_INFO "Bluetooth: Nokia control data =3D");
-	for (i =3D 0; i < skb->len; i++) {
+	for (i =3D 0; i < skb->len; i++)
 		printk(" %02x", skb->data[i]);
-	}
+
 	printk("\n");
=20
 	/* transition to active state */
--=20
1.7.0.4
