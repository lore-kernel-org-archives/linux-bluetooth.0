Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Fix hci_conn reference counting with hci_chan
Date: Mon, 18 Aug 2014 00:41:42 +0300
Message-Id: <1408311704-31747-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com>
References: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_chan_del() function was doing a hci_conn_drop() but there was no
matching hci_conn_hold() in the hci_chan_create() function. Furthermore,
as the hci_chan struct holds a pointer to the hci_conn there should be
proper use of hci_conn_get/put. This patch fixes both issues so that
hci_chan does correct reference counting of the hci_conn object.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4ecc9d5fce7a..7815826a48e4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1295,7 +1295,8 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 	if (!chan)
 		return NULL;
 
-	chan->conn = conn;
+	chan->conn = hci_conn_get(conn);
+	hci_conn_hold(conn);
 	skb_queue_head_init(&chan->data_q);
 	chan->state = BT_CONNECTED;
 
@@ -1316,6 +1317,7 @@ void hci_chan_del(struct hci_chan *chan)
 	synchronize_rcu();
 
 	hci_conn_drop(conn);
+	hci_conn_put(conn);
 
 	skb_queue_purge(&chan->data_q);
 	kfree(chan);
-- 
1.9.3

