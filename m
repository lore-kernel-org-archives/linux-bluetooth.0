Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Convert L2CAP ident spinlock into a mutex
Date: Sun, 13 Jul 2014 20:50:15 +0200
Message-Id: <1405277415-30653-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The spinlock protecting the L2CAP ident number can be converted into
a mutex since the whole processing is run in a workqueue. So instead
of using a spinlock, just use a mutex here.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h | 3 +--
 net/bluetooth/l2cap_core.c    | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d8e7b9330ab8..1fffd92808b0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -625,11 +625,10 @@ struct l2cap_conn {
 
 	struct delayed_work	info_timer;
 
-	spinlock_t		lock;
-
 	struct sk_buff		*rx_skb;
 	__u32			rx_len;
 	__u8			tx_ident;
+	struct mutex		ident_lock;
 
 	struct sk_buff_head	pending_rx;
 	struct work_struct	pending_rx_work;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0c3c4935f635..8538cb07b0c0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -798,14 +798,14 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn)
 	 *  200 - 254 are used by utilities like l2ping, etc.
 	 */
 
-	spin_lock(&conn->lock);
+	mutex_lock(&conn->ident_lock);
 
 	if (++conn->tx_ident > 128)
 		conn->tx_ident = 1;
 
 	id = conn->tx_ident;
 
-	spin_unlock(&conn->lock);
+	mutex_unlock(&conn->ident_lock);
 
 	return id;
 }
@@ -7016,7 +7016,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 		conn->hs_enabled = test_bit(HCI_HS_ENABLED,
 					    &hcon->hdev->dev_flags);
 
-	spin_lock_init(&conn->lock);
+	mutex_init(&conn->ident_lock);
 	mutex_init(&conn->chan_lock);
 
 	INIT_LIST_HEAD(&conn->chan_l);
-- 
1.9.3

