Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 10/12] Bluetooth: Don't disable interrupt when locking the queue
Date: Thu, 22 Dec 2011 16:56:11 -0200
Message-Id: <1324580173-24957-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324580173-24957-9-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-9-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

We run everything in iterrupt context now.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4f0ff01..6d38d80 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1960,7 +1960,7 @@ static void hci_queue_acl(struct hci_conn *conn, struct sk_buff_head *queue,
 		skb_shinfo(skb)->frag_list = NULL;
 
 		/* Queue all fragments atomically */
-		spin_lock_bh(&queue->lock);
+		spin_lock(&queue->lock);
 
 		__skb_queue_tail(queue, skb);
 
@@ -1978,7 +1978,7 @@ static void hci_queue_acl(struct hci_conn *conn, struct sk_buff_head *queue,
 			__skb_queue_tail(queue, skb);
 		} while (list);
 
-		spin_unlock_bh(&queue->lock);
+		spin_unlock(&queue->lock);
 	}
 }
 
-- 
1.7.6.4

