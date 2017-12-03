Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: hci_ll: remove \n from kernel messages
Date: Sat,  2 Dec 2017 21:01:58 -0600
Message-Id: <1512270118-31737-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The bt_* printk macros include a \n already, so we don't need extra ones
here.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/bluetooth/hci_ll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 42142be..0f0a3a2 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -628,11 +628,11 @@ static int download_firmware(struct ll_device *lldev)
 				break;
 			}
 			if (cmd->prefix != 1)
-				bt_dev_dbg(lldev->hu.hdev, "command type %d\n", cmd->prefix);
+				bt_dev_dbg(lldev->hu.hdev, "command type %d", cmd->prefix);
 
 			skb = __hci_cmd_sync(lldev->hu.hdev, cmd->opcode, cmd->plen, &cmd->speed, HCI_INIT_TIMEOUT);
 			if (IS_ERR(skb)) {
-				bt_dev_err(lldev->hu.hdev, "send command failed\n");
+				bt_dev_err(lldev->hu.hdev, "send command failed");
 				err = PTR_ERR(skb);
 				goto out_rel_fw;
 			}
-- 
2.7.4
