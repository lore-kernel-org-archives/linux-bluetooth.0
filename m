Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: convert force_reliable variable to flag in l2cap chan
Date: Fri,  7 Oct 2011 16:54:04 +0300
Message-Id: <1317995646-11174-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1317995646-11174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1317995646-11174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

force_reliable variable inside l2cap_chan is a logical one and can
be easily converted to flag

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |    2 +-
 net/bluetooth/l2cap_sock.c    |   13 +++++++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0fe5d59..6c0d247 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -325,7 +325,6 @@ struct l2cap_chan {
 
 	__u8		sec_level;
 	__u8		role_switch;
-	__u8		force_reliable;
 	__u8		force_active;
 
 	__u8		ident;
@@ -465,6 +464,7 @@ enum {
 
 /* Definitions for flags in l2cap_chan */
 enum {
+	FLAG_FORCE_RELIABLE,
 	FLAG_FLUSHABLE,
 };
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b21ecff..57e4b2c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -948,7 +948,7 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
-		if (chan->force_reliable)
+		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
 			sk->sk_err = err;
 	}
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 81fc8f0..ec0458c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -359,7 +359,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 		if (chan->role_switch)
 			opt |= L2CAP_LM_MASTER;
 
-		if (chan->force_reliable)
+		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
 			opt |= L2CAP_LM_RELIABLE;
 
 		if (put_user(opt, (u32 __user *) optval))
@@ -550,7 +550,11 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 			chan->sec_level = BT_SECURITY_HIGH;
 
 		chan->role_switch    = (opt & L2CAP_LM_MASTER);
-		chan->force_reliable = (opt & L2CAP_LM_RELIABLE);
+
+		if (opt & L2CAP_LM_RELIABLE)
+			set_bit(FLAG_FORCE_RELIABLE, &chan->flags);
+		else
+			clear_bit(FLAG_FORCE_RELIABLE, &chan->flags);
 		break;
 
 	default:
@@ -934,7 +938,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->tx_win = pchan->tx_win;
 		chan->sec_level = pchan->sec_level;
 		chan->role_switch = pchan->role_switch;
-		chan->force_reliable = pchan->force_reliable;
+		if (test_bit(FLAG_FORCE_RELIABLE, &pchan->flags))
+			set_bit(FLAG_FORCE_RELIABLE, &chan->flags);
 		if (test_bit(FLAG_FLUSHABLE, &pchan->flags))
 			set_bit(FLAG_FLUSHABLE, &chan->flags);
 		chan->force_active = pchan->force_active;
@@ -966,7 +971,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
 		chan->sec_level = BT_SECURITY_LOW;
 		chan->role_switch = 0;
-		chan->force_reliable = 0;
+		clear_bit(FLAG_FORCE_RELIABLE, &chan->flags);
 		clear_bit(FLAG_FLUSHABLE, &chan->flags);
 		chan->force_active = BT_POWER_FORCE_ACTIVE_ON;
 
-- 
1.7.4.1

