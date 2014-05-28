Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/6] Bluetooth: 6LoWPAN: Count module usage
Date: Wed, 28 May 2014 14:43:07 +0300
Message-Id: <1401277388-4611-6-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1401277388-4611-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1401277388-4611-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Count how many 6LoWPAN connections there exists so that we
do not unload the module if there are still connections alive.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 79e753b..5028b2e 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -103,6 +103,8 @@ static inline bool peer_del(struct lowpan_dev *dev, struct lowpan_peer *peer)
 
 	if (atomic_dec_and_test(&dev->peer_count)) {
 		BT_DBG("last peer");
+
+		module_put(THIS_MODULE);
 		return true;
 	}
 
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

