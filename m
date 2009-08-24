Return-Path: <cyrus@holtmann.org>
From: "Weng, Wending" <WWeng@rheinmetall.ca>
To: 'Marcel Holtmann' <marcel@holtmann.org>
CC: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Date: Mon, 24 Aug 2009 16:19:54 -0400
Subject: RE: patch for hci_bcsp.c(bluetooth-testing)
Message-ID: <54B31811B83D744D90BF0289EB447D460C1A5047@MAIL-MB1.oerlikon.ca>
In-Reply-To: <1251139067.2950.57.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>Hi Wending,

>looks good, but I need a patch that applies with bluetooth-testing.git
>tree. And please create it with git format-patch.
>
>Regards
>
>Marcel

Below is the patch created with bluetooth-testing.git tree, let me know if it's not done properly, I'm not very experienced with open source.

>From 5c6e77cb6ea3ba6fa5c777d151c480451602bfc8 Mon Sep 17 00:00:00 2001
From: root <root@SBC_PC_3.localdomain>
Date: Mon, 24 Aug 2009 16:05:17 -0400
Subject: [PATCH] The routine bcsp_pkt_cull displays the false error message
"Removed only %u out of %u pkts" when multiple to be acked packets are queued.
As if (i++ >= pkts_to_be_removed)
        break;
   will break the loop and increase the counter i when i==pkts_to_be_removed,
   the loop ends up with i=pkts_to_be_removed+1. The following line:
   if (i != pkts_to_be_removed) {
        BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
   }
   will display the false message.
The counter i must not increase on the same line.

signed-off-by: Wending Weng wweng@rheinmetall.ca
---
 drivers/bluetooth/hci_bcsp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 894b2cb..40aec0f 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -373,8 +373,9 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)

        i = 0;
        skb_queue_walk_safe(&bcsp->unack, skb, tmp) {
-               if (i++ >= pkts_to_be_removed)
+               if (i >= pkts_to_be_removed)
                        break;
+               i++;

                __skb_unlink(skb, &bcsp->unack);
                kfree_skb(skb);
--
1.5.2.1

regards

Wending
