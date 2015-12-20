Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] bluetooth:Fix concurrent access issue in the function chan_close_cb
Date: Sun, 20 Dec 2015 02:30:59 -0500
Message-Id: <1450596659-18054-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes a concurrent access issue in the function chan_close_cb
by not locking and unlocking around the function peer_lockup_chan
by use of the function locking pair rcu_read_lock/unlock in order
to have actual protection from concurrent threads of execution when
calling this particular function in the function chan_close_cb.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/6lowpan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2fb7b30..7fc20cb 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -955,7 +955,9 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
 		dev = lowpan_dev(entry->netdev);
+		rcu_read_lock();
 		peer = __peer_lookup_chan(dev, chan);
+		rcu_read_unlock();
 		if (peer) {
 			last = peer_del(dev, peer);
 			err = 0;
-- 
2.1.4
