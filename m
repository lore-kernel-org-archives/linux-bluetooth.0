Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/4] Bluetooth: convert force_active variable to flag in l2cap chan
Date: Fri, 16 Sep 2011 16:53:41 +0300
Message-Id: <1316181222-32634-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1316181222-32634-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1316181222-32634-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

force_active variable inside l2cap_chan is a logical one and can
be easily converted to flag
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |    4 ++--
 net/bluetooth/l2cap_sock.c    |   14 +++++++++-----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index af81a7e..3a27893 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -370,7 +370,6 @@ struct l2cap_chan {
 
 	__u8		sec_level;
 	__u8		role_switch;
-	__u8		force_active;
 
 	__u8		ident;
 
@@ -533,6 +532,7 @@ enum {
 
 /* Definitions for flags in l2cap_chan */
 enum {
+	FLAG_FORCE_ACTIVE,
 	FLAG_FORCE_RELIABLE,
 	FLAG_FLUSHABLE,
 	FLAG_EFS_ENABLE,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2307819..c112e77 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -618,7 +618,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 	else
 		flags = ACL_START;
 
-	bt_cb(skb)->force_active = chan->force_active;
+	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 
 	hci_send_acl(chan->conn->hcon, skb, flags);
 }
@@ -1272,7 +1272,7 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	else
 		flags = ACL_START;
 
-	bt_cb(skb)->force_active = chan->force_active;
+	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 	hci_send_acl(hcon, skb, flags);
 }
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1ba2187..9d4d9d4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -459,7 +459,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 			break;
 		}
 
-		pwr.force_active = chan->force_active;
+		pwr.force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 
 		len = min_t(unsigned int, len, sizeof(pwr));
 		if (copy_to_user(optval, (char *) &pwr, len))
@@ -680,7 +680,11 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 			err = -EFAULT;
 			break;
 		}
-		chan->force_active = pwr.force_active;
+
+		if (pwr.force_active)
+			set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
+		else
+			clear_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 		break;
 
 	default:
@@ -942,7 +946,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 			set_bit(FLAG_FORCE_RELIABLE, &chan->flags);
 		if (test_bit(FLAG_FLUSHABLE, &pchan->flags))
 			set_bit(FLAG_FLUSHABLE, &chan->flags);
-		chan->force_active = pchan->force_active;
+		if (test_bit(FLAG_FORCE_ACTIVE, &pchan->flags))
+			set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 	} else {
 
 		switch (sk->sk_type) {
@@ -973,8 +978,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->role_switch = 0;
 		clear_bit(FLAG_FORCE_RELIABLE, &chan->flags);
 		clear_bit(FLAG_FLUSHABLE, &chan->flags);
-		chan->force_active = BT_POWER_FORCE_ACTIVE_ON;
-
+		set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 	}
 
 	/* Default config options */
-- 
1.7.4.1

