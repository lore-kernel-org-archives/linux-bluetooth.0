Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: Wrong style spin lock used
Date: Wed, 29 Oct 2014 10:16:00 +0200
Message-Id: <1414570560-29904-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use spin_lock_bh() as the code is called from softirq in networking subsystem.
This is needed to prevent deadlocks when 6lowpan link is in use.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
Hi,

this v4 adds a comment why spin_lock_bh() is needed here.

Cheers,
Jukka

 net/bluetooth/hci_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cb05d7f..2397623 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4661,8 +4661,12 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 
 		skb_shinfo(skb)->frag_list = NULL;
 
-		/* Queue all fragments atomically */
-		spin_lock(&queue->lock);
+		/* Queue all fragments atomically. We need to use spin_lock_bh
+		 * here because of 6LoWPAN links, as there this function is
+		 * called from softirq and using normal spin lock could cause
+		 * deadlocks.
+		 */
+		spin_lock_bh(&queue->lock);
 
 		__skb_queue_tail(queue, skb);
 
@@ -4679,7 +4683,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 			__skb_queue_tail(queue, skb);
 		} while (list);
 
-		spin_unlock(&queue->lock);
+		spin_unlock_bh(&queue->lock);
 	}
 }
 
-- 
1.8.3.1

