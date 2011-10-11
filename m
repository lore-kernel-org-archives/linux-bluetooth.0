Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/4] Bluetooth: convert flushable variable to flag in l2cap chan
Date: Tue, 11 Oct 2011 14:04:31 +0300
Message-Id: <1318331074-32054-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318331074-32054-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318331074-32054-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

flushable variable inside l2cap_chan is a logical one and can
be easily converted to flag. Added flags in l2cap_chan structure.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    7 ++++++-
 net/bluetooth/l2cap_core.c    |    3 ++-
 net/bluetooth/l2cap_sock.c    |   12 ++++++++----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2933767..0fe5d59 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -326,7 +326,6 @@ struct l2cap_chan {
 	__u8		sec_level;
 	__u8		role_switch;
 	__u8		force_reliable;
-	__u8		flushable;
 	__u8		force_active;
 
 	__u8		ident;
@@ -346,6 +345,7 @@ struct l2cap_chan {
 
 	unsigned long	conf_state;
 	unsigned long	conn_state;
+	unsigned long	flags;
 
 	__u8		next_tx_seq;
 	__u8		expected_ack_seq;
@@ -463,6 +463,11 @@ enum {
 	CONN_RNR_SENT,
 };
 
+/* Definitions for flags in l2cap_chan */
+enum {
+	FLAG_FLUSHABLE,
+};
+
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
 #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
 #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3158cec..b21ecff 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1253,7 +1253,8 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	BT_DBG("chan %p, skb %p len %d", chan, skb, skb->len);
 
-	if (!chan->flushable && lmp_no_flush_capable(hcon->hdev))
+	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
+					lmp_no_flush_capable(hcon->hdev))
 		flags = ACL_START_NO_FLUSH;
 	else
 		flags = ACL_START;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 61f1f62..99782cb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -446,7 +446,8 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 		break;
 
 	case BT_FLUSHABLE:
-		if (put_user(chan->flushable, (u32 __user *) optval))
+		if (put_user(test_bit(FLAG_FLUSHABLE, &chan->flags),
+						(u32 __user *) optval))
 			err = -EFAULT;
 
 		break;
@@ -655,7 +656,10 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 			}
 		}
 
-		chan->flushable = opt;
+		if (opt)
+			set_bit(FLAG_FLUSHABLE, &chan->flags);
+		else
+			clear_bit(FLAG_FLUSHABLE, &chan->flags);
 		break;
 
 	case BT_POWER:
@@ -931,7 +935,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->sec_level = pchan->sec_level;
 		chan->role_switch = pchan->role_switch;
 		chan->force_reliable = pchan->force_reliable;
-		chan->flushable = pchan->flushable;
+		chan->flags = pchan->flags;
 		chan->force_active = pchan->force_active;
 	} else {
 
@@ -962,7 +966,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->sec_level = BT_SECURITY_LOW;
 		chan->role_switch = 0;
 		chan->force_reliable = 0;
-		chan->flushable = BT_FLUSHABLE_OFF;
+		chan->flags = 0;
 		chan->force_active = BT_POWER_FORCE_ACTIVE_ON;
 
 	}
-- 
1.7.4.1

