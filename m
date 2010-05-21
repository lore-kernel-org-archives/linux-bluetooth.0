Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] Bluetooth: Check sk is not owned before freeing l2cap_conn
Date: Fri, 21 May 2010 13:04:52 +0300
Message-Id: <1274436293-15063-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Check that socket sk is not locked in user process before removing
l2cap connection handler.

krfcommd kernel thread may be preempted with l2cap tasklet which remove
l2cap_conn structure. If krfcommd is in process of sending of RFCOMM reply
(like "RFCOMM UA" reply to "RFCOMM DISC") then kernel crash happens.

...
[  694.175933] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[  694.184936] pgd = c0004000
[  694.187683] [00000000] *pgd=00000000
[  694.191711] Internal error: Oops: 5 [#1] PREEMPT
[  694.196350] last sysfs file: /sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
[  694.260375] CPU: 0    Not tainted  (2.6.32.10 #1)
[  694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
[  694.270721] LR is at 0xd7017303
...
[  694.525085] Backtrace:
[  694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap]) from [<c02f2cc8>] (sock_sendmsg+0xb8/0xd8)
[  694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>] (kernel_sendmsg+0x48/0x80)
...

Modified version after comments of Gustavo F. Padovan <gustavo@padovan.org>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index bb00015..11060d6 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2927,6 +2927,13 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		break;
 
 	default:
+		/* don't delete l2cap channel if sk is owned by user */
+		if (sock_owned_by_user(sk)) {
+			sk->sk_state = BT_DISCONN;
+			l2cap_sock_clear_timer(sk);
+			l2cap_sock_set_timer(sk, HZ);
+			break;
+		}
 		l2cap_chan_del(sk, ECONNREFUSED);
 		break;
 	}
@@ -3135,6 +3142,15 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 		del_timer(&l2cap_pi(sk)->ack_timer);
 	}
 
+	/* don't delete l2cap channel if sk is owned by user */
+	if (sock_owned_by_user(sk)) {
+		sk->sk_state = BT_DISCONN;
+		l2cap_sock_clear_timer(sk);
+		l2cap_sock_set_timer(sk, HZ);
+		bh_unlock_sock(sk);
+		return 0;
+	}
+
 	l2cap_chan_del(sk, ECONNRESET);
 	bh_unlock_sock(sk);
 
@@ -3167,6 +3183,15 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 		del_timer(&l2cap_pi(sk)->ack_timer);
 	}
 
+	/* don't delete l2cap channel if sk is owned by user */
+	if (sock_owned_by_user(sk)) {
+		sk->sk_state = BT_DISCONN;
+		l2cap_sock_clear_timer(sk);
+		l2cap_sock_set_timer(sk, HZ);
+		bh_unlock_sock(sk);
+		return 0;
+	}
+
 	l2cap_chan_del(sk, 0);
 	bh_unlock_sock(sk);
 
-- 
1.7.0.4

