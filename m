Return-Path: <cyrus@holtmann.org>
From: Haijun Liu <haijun.liu@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <padovan@profusion.mobi>, Haijun Liu <haijun.liu@atheros.com>
Subject: [PATCH 1/2 v2] Bluetooth: Fix system crash caused by del_timer()
Date: Fri, 22 Oct 2010 10:26:58 +0800
Message-ID: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During test session with another vendor's bt stack, found that in
l2cap_chan_del() using del_timer() caused l2cap_monitor_timeout()
be called after the sock was freed, so it raised a system crash.
So I just replaced del_timer() with del_timer_sync() to solve it.

Signed-off-by: Haijun Liu <haijun.liu@atheros.com>
---
 net/bluetooth/l2cap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 6f931cc..879f386 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -283,9 +283,9 @@ static void l2cap_chan_del(struct sock *sk, int err)
 	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
 		struct srej_list *l, *tmp;
 
-		del_timer(&l2cap_pi(sk)->retrans_timer);
-		del_timer(&l2cap_pi(sk)->monitor_timer);
-		del_timer(&l2cap_pi(sk)->ack_timer);
+		del_timer_sync(&l2cap_pi(sk)->retrans_timer);
+		del_timer_sync(&l2cap_pi(sk)->monitor_timer);
+		del_timer_sync(&l2cap_pi(sk)->ack_timer);
 
 		skb_queue_purge(SREJ_QUEUE(sk));
 		skb_queue_purge(BUSY_QUEUE(sk));
-- 
1.6.3.3

