Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 6/7] Bluetooth: Use abstract chan->data in comparison
Date: Tue, 15 Oct 2013 19:24:50 -0300
Message-Id: <1381875891-27953-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
References: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

If the L2CAP user is l2cap_sock.c chan->data is a pointer to the l2cap
socket so chan->sk and chan->data are the same thing. Then we can just
compare with chan->data instead.

Non-socket users will have skb->sk = NULL, thus this change does not
interfere in other users.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h | 2 +-
 net/bluetooth/l2cap_core.c    | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 377db2a..36129de 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -537,7 +537,7 @@ struct l2cap_chan {
 	struct list_head	list;
 	struct list_head	global_l;
 
-	void			*data;
+	void			*data; /* L2CAP user data. eg: sk for sockets */
 	struct l2cap_ops	*ops;
 	struct mutex		lock;
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 39f02c08..36ddb25 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2834,12 +2834,11 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
 		if (chan->chan_type != L2CAP_CHAN_RAW)
 			continue;
 
 		/* Don't send frame to the socket it came from */
-		if (skb->sk == sk)
+		if (skb->sk && skb->sk == chan->data)
 			continue;
 		nskb = skb_clone(skb, GFP_KERNEL);
 		if (!nskb)
-- 
1.8.3.1

