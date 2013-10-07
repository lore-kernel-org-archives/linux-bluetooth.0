Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] Bluetooth: Make mgmt_disconnect_failed() return void
Date: Sun,  6 Oct 2013 23:55:47 -0700
Message-Id: <1381128953-32080-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_disconnect_failed() function is not used
so change it to just return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/mgmt.c             | 13 +++++--------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 62e2fc1..429969f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1106,8 +1106,8 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			  u8 *dev_class);
 int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			     u8 link_type, u8 addr_type, u8 reason);
-int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			   u8 link_type, u8 addr_type, u8 status);
+void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			    u8 link_type, u8 addr_type, u8 status);
 int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			u8 addr_type, u8 status);
 int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5da7464..a35f28e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4143,29 +4143,26 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return err;
 }
 
-int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			   u8 link_type, u8 addr_type, u8 status)
+void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			    u8 link_type, u8 addr_type, u8 status)
 {
 	struct mgmt_rp_disconnect rp;
 	struct pending_cmd *cmd;
-	int err;
 
 	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
 			     hdev);
 
 	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev);
 	if (!cmd)
-		return -ENOENT;
+		return;
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
 	rp.addr.type = link_to_bdaddr(link_type, addr_type);
 
-	err = cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT,
-			   mgmt_status(status), &rp, sizeof(rp));
+	cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT,
+		     mgmt_status(status), &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
-
-	return err;
 }
 
 int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-- 
1.8.3.1

