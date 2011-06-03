Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 2/4] Bluetooth: Rename _busy_wq to _l2cap_wq
Date: Fri,  3 Jun 2011 16:21:08 -0700
Message-Id: <1307143270-2655-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This workqueue will be used for general L2CAP work, not just dealing
with "busy" frames.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index dc5c654..6f9daf8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -60,7 +60,7 @@ int disable_ertm;
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
 
-static struct workqueue_struct *_busy_wq;
+static struct workqueue_struct *_l2cap_wq;
 
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
@@ -3351,7 +3351,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 
 	del_timer(&chan->ack_timer);
 
-	queue_work(_busy_wq, &chan->busy_work);
+	queue_work(_l2cap_wq, &chan->busy_work);
 
 	return err;
 }
@@ -4398,8 +4398,8 @@ int __init l2cap_init(void)
 	if (err < 0)
 		return err;
 
-	_busy_wq = create_singlethread_workqueue("l2cap");
-	if (!_busy_wq) {
+	_l2cap_wq = create_singlethread_workqueue("l2cap");
+	if (!_l2cap_wq) {
 		err = -ENOMEM;
 		goto error;
 	}
@@ -4421,7 +4421,7 @@ int __init l2cap_init(void)
 	return 0;
 
 error:
-	destroy_workqueue(_busy_wq);
+	destroy_workqueue(_l2cap_wq);
 	l2cap_cleanup_sockets();
 	return err;
 }
@@ -4430,8 +4430,8 @@ void l2cap_exit(void)
 {
 	debugfs_remove(l2cap_debugfs);
 
-	flush_workqueue(_busy_wq);
-	destroy_workqueue(_busy_wq);
+	flush_workqueue(_l2cap_wq);
+	destroy_workqueue(_l2cap_wq);
 
 	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
 		BT_ERR("L2CAP protocol unregistration failed");
-- 
1.7.5.2


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

