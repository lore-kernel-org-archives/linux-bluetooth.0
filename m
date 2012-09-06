Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Fix freeing uninitialized delayed works
Date: Thu,  6 Sep 2012 15:05:42 +0300
Message-Id: <1346933147-11789-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When releasing L2CAP socket which is in BT_CONFIG state l2cap_chan_close
invokes l2cap_send_disconn_req which cancel delayed works which are only
set in BT_CONNECTED state with l2cap_ertm_init. Add state check before
cancelling those works.

...
[ 9668.574372] [21085] l2cap_sock_release: sock cd065200, sk f073e800
[ 9668.574399] [21085] l2cap_sock_shutdown: sock cd065200, sk f073e800
[ 9668.574411] [21085] l2cap_chan_close: chan f073ec00 state BT_CONFIG sk f073e800
[ 9668.574421] [21085] l2cap_send_disconn_req: chan f073ec00 conn ecc16600
[ 9668.574441] INFO: trying to register non-static key.
[ 9668.574443] the code is fine but needs lockdep annotation.
[ 9668.574446] turning off the locking correctness validator.
[ 9668.574450] Pid: 21085, comm: obex-client Tainted: G           O 3.5.0+ #57
[ 9668.574452] Call Trace:
[ 9668.574463]  [<c10a64b3>] __lock_acquire+0x12e3/0x1700
[ 9668.574468]  [<c10a44fb>] ? trace_hardirqs_on+0xb/0x10
[ 9668.574476]  [<c15e4f60>] ? printk+0x4d/0x4f
[ 9668.574479]  [<c10a6e38>] lock_acquire+0x88/0x130
[ 9668.574487]  [<c1059740>] ? try_to_del_timer_sync+0x60/0x60
[ 9668.574491]  [<c1059790>] del_timer_sync+0x50/0xc0
[ 9668.574495]  [<c1059740>] ? try_to_del_timer_sync+0x60/0x60
[ 9668.574515]  [<f8aa1c23>] l2cap_send_disconn_req+0xe3/0x160 [bluetooth]
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8e4b57b..b47c325 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1089,7 +1089,7 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	if (!conn)
 		return;
 
-	if (chan->mode == L2CAP_MODE_ERTM) {
+	if (chan->mode == L2CAP_MODE_ERTM && chan->state == BT_CONNECTED) {
 		__clear_retrans_timer(chan);
 		__clear_monitor_timer(chan);
 		__clear_ack_timer(chan);
-- 
1.7.9.5

