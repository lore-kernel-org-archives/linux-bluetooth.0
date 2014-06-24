Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove ssp_debug_mode debugfs option
Date: Tue, 24 Jun 2014 13:13:04 +0200
Message-Id: <1403608384-59675-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The ssp_debug_mode debugfs option for developers is no longer
needed. Support for using Secure Simple Pairing (SSP) debug
mode is exposed by the management interface now.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 51 ------------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 159783e746c0..9852449ac104 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -352,55 +352,6 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			auto_accept_delay_set, "%llu\n");
 
-static int ssp_debug_mode_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-	struct sk_buff *skb;
-	__u8 mode;
-	int err;
-
-	if (val != 0 && val != 1)
-		return -EINVAL;
-
-	if (!test_bit(HCI_UP, &hdev->flags))
-		return -ENETDOWN;
-
-	hci_req_lock(hdev);
-	mode = val;
-	skb = __hci_cmd_sync(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE, sizeof(mode),
-			     &mode, HCI_CMD_TIMEOUT);
-	hci_req_unlock(hdev);
-
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	err = -bt_to_errno(skb->data[0]);
-	kfree_skb(skb);
-
-	if (err < 0)
-		return err;
-
-	hci_dev_lock(hdev);
-	hdev->ssp_debug_mode = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int ssp_debug_mode_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->ssp_debug_mode;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(ssp_debug_mode_fops, ssp_debug_mode_get,
-			ssp_debug_mode_set, "%llu\n");
-
 static ssize_t force_sc_support_read(struct file *file, char __user *user_buf,
 				     size_t count, loff_t *ppos)
 {
@@ -1787,8 +1738,6 @@ static int __hci_init(struct hci_dev *hdev)
 	if (lmp_ssp_capable(hdev)) {
 		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
 				    hdev, &auto_accept_delay_fops);
-		debugfs_create_file("ssp_debug_mode", 0644, hdev->debugfs,
-				    hdev, &ssp_debug_mode_fops);
 		debugfs_create_file("force_sc_support", 0644, hdev->debugfs,
 				    hdev, &force_sc_support_fops);
 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
-- 
1.9.3

