Return-Path: <cyrus@holtmann.org>
From: Lukasz Duda <lukasz.duda@nordicsemi.no>
To: <alex.aring@gmail.com>
CC: <linux-wpan@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
Subject: [RFC 2/2] Bluetooth: 6lowpan: Enable stateful compression for bluetooth_6lowpan module
Date: Fri, 3 Jul 2015 15:23:38 +0200
Message-ID: <1435929818-6044-3-git-send-email-lukasz.duda@nordicsemi.no>
In-Reply-To: <1435929818-6044-1-git-send-email-lukasz.duda@nordicsemi.no>
References: <1435929818-6044-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allocating context table for stateful compression when interface is set up.
Removing context table when interface is unregistered.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 net/bluetooth/6lowpan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2fb7b30..60c7e80 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -871,6 +871,9 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	       &chan->src, chan->src_type);
 	set_bit(__LINK_STATE_PRESENT, &netdev->state);
 
+	/* Allocate context table for stateful compression. */
+	lowpan_context_table_alloc(netdev);
+
 	*dev = netdev_priv(netdev);
 	(*dev)->netdev = netdev;
 	(*dev)->hdev = chan->conn->hcon->hdev;
@@ -1415,6 +1418,7 @@ static int device_event(struct notifier_block *unused,
 			if (entry->netdev == netdev) {
 				BT_DBG("Unregistered netdev %s %p",
 				       netdev->name, netdev);
+				lowpan_context_table_free(netdev);
 				list_del(&entry->list);
 				break;
 			}
-- 
2.1.4

