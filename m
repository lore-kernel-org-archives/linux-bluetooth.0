Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add BUILD_BUG_ON check for SKB control buffer size
Date: Sun, 14 Sep 2014 22:50:46 +0200
Message-Id: <1410727846-61438-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The struct bt_skb_cb size needs to stay within the limits of skb->cb
at all times and to ensure that add a BUILD_BUG_ON to check for it at
compile time.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 4dca0299ed96..339c74ad4553 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -709,8 +709,11 @@ EXPORT_SYMBOL_GPL(bt_debugfs);
 
 static int __init bt_init(void)
 {
+	struct sk_buff *skb;
 	int err;
 
+	BUILD_BUG_ON(sizeof(struct bt_skb_cb) > sizeof(skb->cb));
+
 	BT_INFO("Core ver %s", VERSION);
 
 	bt_debugfs = debugfs_create_dir("bluetooth", NULL);
-- 
1.9.3

