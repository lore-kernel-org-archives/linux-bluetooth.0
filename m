Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/2] Bluetooth: Add locking scheme to timeout callbacks.
Date: Mon, 24 Aug 2009 00:45:19 -0300
Message-Id: <1251085520-9094-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Avoid race conditions when acessing the sock.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c04526f..efac637 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1192,6 +1192,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	struct sock *sk = (void *) arg;
 	u16 control;
 
+	bh_lock_sock(sk);
 	if (l2cap_pi(sk)->retry_count >= l2cap_pi(sk)->remote_max_tx) {
 		l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk);
 		return;
@@ -1203,6 +1204,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	control = L2CAP_CTRL_POLL;
 	control |= L2CAP_SUPER_RCV_READY;
 	l2cap_send_sframe(l2cap_pi(sk), control);
+	bh_unlock_sock(sk);
 }
 
 static void l2cap_retrans_timeout(unsigned long arg)
@@ -1210,6 +1212,7 @@ static void l2cap_retrans_timeout(unsigned long arg)
 	struct sock *sk = (void *) arg;
 	u16 control;
 
+	bh_lock_sock(sk);
 	l2cap_pi(sk)->retry_count = 1;
 	__mod_monitor_timer();
 
@@ -1218,6 +1221,7 @@ static void l2cap_retrans_timeout(unsigned long arg)
 	control = L2CAP_CTRL_POLL;
 	control |= L2CAP_SUPER_RCV_READY;
 	l2cap_send_sframe(l2cap_pi(sk), control);
+	bh_unlock_sock(sk);
 }
 
 static void l2cap_drop_acked_frames(struct sock *sk)
-- 
1.6.3.3
