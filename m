Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_core: return cmd status in __hci_cmd_sync()
Date: Mon, 11 May 2015 17:50:17 +0200
Message-Id: <1431359418-23502-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle command complete event, extract command status from reply and
return it if it is an error.
This will allow to simplify error test in calling functions.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 net/bluetooth/hci_core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 476709b..3510284 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -94,7 +94,6 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	char buf[32];
 	size_t buf_size = min(count, (sizeof(buf)-1));
 	bool enable;
-	int err;
 
 	if (!test_bit(HCI_UP, &hdev->flags))
 		return -ENETDOWN;
@@ -121,12 +120,6 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	err = -bt_to_errno(skb->data[0]);
-	kfree_skb(skb);
-
-	if (err < 0)
-		return err;
-
 	hci_dev_change_flag(hdev, HCI_DUT_MODE);
 
 	return count;
@@ -234,7 +227,18 @@ EXPORT_SYMBOL(__hci_cmd_sync_ev);
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout)
 {
-	return __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
+	struct sk_buff *skb;
+	int err;
+
+	skb = __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
+	if (!IS_ERR(skb) && skb->data[0]) {
+		err = -bt_to_errno(skb->data[0]);
+		kfree_skb(skb);
+
+		return ERR_PTR(err);
+	}
+
+	return skb;
 }
 EXPORT_SYMBOL(__hci_cmd_sync);
 
-- 
1.9.1

