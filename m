Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Call l2cap_le_conn_ready after notifying channels
Date: Fri,  8 Aug 2014 09:28:04 +0300
Message-Id: <1407479285-4261-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479285-4261-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479285-4261-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For most cases it makes no difference whether l2cap_le_conn_ready() is
called before or after calling the channel ready() callbacks, however
for upcoming SMP code we need this as the ready() callback initializes
certain structures that a call to smp_conn_security() from
l2cap_le_conn_ready() depends on. Therefore, move the call to
l2cap_le_conn_ready() after iterating through and notifying channels.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c6419f40cfba..8acfe6f57b5e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1464,9 +1464,6 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
-	if (hcon->type == LE_LINK)
-		l2cap_le_conn_ready(conn);
-
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
@@ -1492,6 +1489,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	mutex_unlock(&conn->chan_lock);
 
+	if (hcon->type == LE_LINK)
+		l2cap_le_conn_ready(conn);
+
 	queue_work(hcon->hdev->workqueue, &conn->pending_rx_work);
 }
 
-- 
1.9.3

