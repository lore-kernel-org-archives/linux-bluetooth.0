Return-Path: <cyrus@holtmann.org>
From: "Weng, Wending" <WWeng@rheinmetall.ca>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Date: Wed, 19 Aug 2009 09:19:23 -0400
Subject: patch for hci_bcsp.c(2.6.31.-rc1)
Message-ID: <54B31811B83D744D90BF0289EB447D460C1A5044@MAIL-MB1.oerlikon.ca>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 69596948eb2172080bb950d99dc90678ead08305 Mon Sep 17 00:00:00 2001
From: root <root@SBC_PC_3.localdomain>
Date: Wed, 19 Aug 2009 08:59:56 -0400
Subject: [PATCH] The routine bcsp_pkt_cull doesn't ack the packets properly
if multiple packets are queued. The counter i must increase before
doing comparison.

Signed-off-by: Wending Weng <wweng@rheinmetall.ca>

---
 drivers/bluetooth/hci_bcsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 894b2cb..cd30f39 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -373,7 +373,7 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)

        i = 0;
        skb_queue_walk_safe(&bcsp->unack, skb, tmp) {
-               if (i++ >= pkts_to_be_removed)
+               if (++i >= pkts_to_be_removed)
                        break;

                __skb_unlink(skb, &bcsp->unack);
--
1.5.2.1

