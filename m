Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <ulrik.lauren@stericsson.com>, <kanak.gupta@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Bluetooth: Add ability to force local busy condition on L2CAP ERTM
Date: Thu, 3 Nov 2011 16:05:45 +0100
Message-ID: <1320332745-21750-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1320332745-21750-1-git-send-email-szymon.janc@tieto.com>
References: <1320332745-21750-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is required to pass PTS TP/ERM/BV-07-C (Send S-Frame [RNR]).

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9dcbf3d..6202009 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -59,6 +59,8 @@
 int disable_ertm;
 int enable_hs;
 
+static int force_local_busy;
+
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
 
@@ -3522,7 +3524,7 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
 	if (chan->mode == L2CAP_MODE_ERTM) {
 		if (busy)
 			l2cap_ertm_enter_local_busy(chan);
-		else
+		else if (!force_local_busy)
 			l2cap_ertm_exit_local_busy(chan);
 	}
 }
@@ -4498,7 +4500,38 @@ static const struct file_operations l2cap_debugfs_fops = {
 	.release	= single_release,
 };
 
+static int force_local_busy_set(void *data, u64 val)
+{
+	struct l2cap_chan *chan;
+
+	force_local_busy = val;
+
+	read_lock_bh(&chan_list_lock);
+
+	list_for_each_entry(chan, &chan_list, global_l) {
+		bh_lock_sock(chan->sk);
+		if (chan->state == BT_CONNECTED)
+			l2cap_chan_busy(chan, force_local_busy);
+		bh_unlock_sock(chan->sk);
+	}
+
+	read_unlock_bh(&chan_list_lock);
+
+	return 0;
+}
+
+static int force_local_busy_get(void *data, u64 *val)
+{
+	*val = force_local_busy;
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(force_local_busy_fops, force_local_busy_get,
+					force_local_busy_set, "%llu\n");
+
 static struct dentry *l2cap_debugfs;
+static struct dentry *force_local_busy_debugfs;
 
 static struct hci_proto l2cap_hci_proto = {
 	.name		= "L2CAP",
@@ -4531,6 +4564,13 @@ int __init l2cap_init(void)
 					bt_debugfs, NULL, &l2cap_debugfs_fops);
 		if (!l2cap_debugfs)
 			BT_ERR("Failed to create L2CAP debug file");
+
+		force_local_busy_debugfs =
+				debugfs_create_file("force_local_busy", 0444,
+							bt_debugfs, NULL,
+							&force_local_busy_fops);
+		if (!force_local_busy_debugfs)
+			BT_ERR("Failed to create ERTM debug file");
 	}
 
 	return 0;
@@ -4543,6 +4583,7 @@ error:
 void l2cap_exit(void)
 {
 	debugfs_remove(l2cap_debugfs);
+	debugfs_remove(force_local_busy_debugfs);
 
 	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
 		BT_ERR("L2CAP protocol unregistration failed");
-- 
on behalf of ST-Ericsson

