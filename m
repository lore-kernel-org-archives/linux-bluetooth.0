Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Remove hci_conn_hold/drop from hci_chan
Date: Mon, 18 Aug 2014 20:33:27 +0300
Message-Id: <1408383214-16366-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
References: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We can't have hci_chan contribute to the "active" reference counting of
the hci_conn since otherwise the connection would never get dropped when
there are no more users (since hci_chan would be counted as a user).
This patch removes hold() when creating the hci_chan and drop() when
destroying it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index aaa7e388d026..5157a0990732 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1301,7 +1301,6 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 		return NULL;
 
 	chan->conn = hci_conn_get(conn);
-	hci_conn_hold(conn);
 	skb_queue_head_init(&chan->data_q);
 	chan->state = BT_CONNECTED;
 
@@ -1321,11 +1320,9 @@ void hci_chan_del(struct hci_chan *chan)
 
 	synchronize_rcu();
 
-	/* Force the connection to be immediately dropped */
-	conn->disc_timeout = 0;
+	/* Prevent new hci_chan's to be created for this hci_conn */
 	set_bit(HCI_CONN_DROP, &conn->flags);
 
-	hci_conn_drop(conn);
 	hci_conn_put(conn);
 
 	skb_queue_purge(&chan->data_q);
-- 
1.9.3

