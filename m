Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/5] Bluetooth: 6LoWPAN: Count module usage
Date: Mon,  2 Jun 2014 13:08:23 +0300
Message-Id: <1401703704-22451-5-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1401703704-22451-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1401703704-22451-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Count how many 6LoWPAN connections there exists so that we
do not unload the module if there are still connections alive.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 79e753b..ae0413f 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -101,6 +101,8 @@ static inline bool peer_del(struct lowpan_dev *dev, struct lowpan_peer *peer)
 {
 	list_del(&peer->list);
 
+	module_put(THIS_MODULE);
+
 	if (atomic_dec_and_test(&dev->peer_count)) {
 		BT_DBG("last peer");
 		return true;
@@ -728,6 +730,9 @@ static inline void bt_6lowpan_chan_ready_cb(struct l2cap_chan *chan)
 		}
 	}
 
+	if (!try_module_get(THIS_MODULE))
+		return;
+
 	add_peer_chan(chan, dev);
 	ifup(dev->netdev);
 }
-- 
1.8.3.1

