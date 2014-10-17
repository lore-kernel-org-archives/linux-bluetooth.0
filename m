Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Wrong style spin lock used
Date: Fri, 17 Oct 2014 16:56:26 +0300
Message-Id: <1413554186-27096-4-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1413554186-27096-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1413554186-27096-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use spin_lock_bh() as the code is called from softirq in networking subsystem.
This is needed to prevent deadlocks when 6lowpan link is in use.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cb05d7f..0242e01 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4662,7 +4662,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 		skb_shinfo(skb)->frag_list = NULL;
 
 		/* Queue all fragments atomically */
-		spin_lock(&queue->lock);
+		spin_lock_bh(&queue->lock);
 
 		__skb_queue_tail(queue, skb);
 
@@ -4679,7 +4679,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 			__skb_queue_tail(queue, skb);
 		} while (list);
 
-		spin_unlock(&queue->lock);
+		spin_unlock_bh(&queue->lock);
 	}
 }
 
-- 
1.8.3.1

