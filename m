Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/4] Bluetooth: Fix calls to __hci_cmd_sync()
Date: Fri, 15 May 2015 11:58:39 +0200
Message-Id: <1431683922-20418-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove test of command reply status as it is already performed by
__hci_cmd_sync().

__hci_cmd_sync_ev() function already returns an error if it got a
non-zero status either through a Command Complete or a Command
Status event.

For both of these events the status is collected up in the event
handlers called by hci_event_packet() and then passed as the second
parameter to req_complete_skb(). The req_complete_skb() callback in
turn is hci_req_sync_complete() for __hci_cmd_sync_ev() which stores
the status in hdev->req_result. The hdev->req_result is then further
converted through bt_to_errno() back in __hci_cmd_sync_ev().

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 net/bluetooth/hci_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4663c3d..db11b9d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -94,7 +94,6 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	char buf[32];
 	size_t buf_size = min(count, (sizeof(buf)-1));
 	bool enable;
-	int err;
 
 	if (!test_bit(HCI_UP, &hdev->flags))
 		return -ENETDOWN;
@@ -121,12 +120,8 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	err = -bt_to_errno(skb->data[0]);
 	kfree_skb(skb);
 
-	if (err < 0)
-		return err;
-
 	hci_dev_change_flag(hdev, HCI_DUT_MODE);
 
 	return count;
-- 
1.9.1

