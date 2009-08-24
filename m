Return-Path: <cyrus@holtmann.org>
From: "Weng, Wending" <WWeng@rheinmetall.ca>
To: 'Marcel Holtmann' <marcel@holtmann.org>
CC: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Date: Mon, 24 Aug 2009 14:33:33 -0400
Subject: RE: patch for hci_bcsp.c(2.6.31.-rc1)
Message-ID: <54B31811B83D744D90BF0289EB447D460C1A5046@MAIL-MB1.oerlikon.ca>
In-Reply-To: <1251134366.2950.54.camel@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>Not following? I am saying replace >=3D with >. Would that work too?
>Otherwise please send a patch with a more detailed commit message.
>
>Regards
>
>Marcel

        replace >=3D with > will not work. Below is the new patch.

From: root <root@SBC_PC_3.localdomain>
Date: Mon, 24 Aug 2009 14:06:18 -0400
Subject: [PATCH] The routine bcsp_pkt_cull displays the false error message
"Removed only %u out of %u pkts" when multiple to be acked packets are queu=
ed.
As if (i++ >=3D pkts_to_be_removed)
        break;
   will breaks the loop and increase the counter i when i=3D=3Dpkts_to_be_r=
emoved,
   the loop ends up with i=3Dpkts_to_be_removed+1. The following line:
   if (i !=3D pkts_to_be_removed) {
        BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
   }
   will display the false message.
The counter i must not increase on the same line.
---
 drivers/bluetooth/hci_bcsp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 894b2cb..40aec0f 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -373,8 +373,9 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)

        i =3D 0;
        skb_queue_walk_safe(&bcsp->unack, skb, tmp) {
-               if (i++ >=3D pkts_to_be_removed)
+               if (i >=3D pkts_to_be_removed)
                        break;
+               i++;

                __skb_unlink(skb, &bcsp->unack);
                kfree_skb(skb);
--
1.5.2.1

Regards

Wending
