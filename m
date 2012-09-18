Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH] Bluetooth: Force the process of unpair command if disconnect failed
Date: Tue, 18 Sep 2012 13:36:54 -0400
Message-Id: <1347989814-4958-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The unpair process tries to disconnect any connection pending with
remote. If there are some connection in connecting state, disconnect
command will fail and unpair mgmt command will stay pending.

That pending mgmt command can cause strange behavior like automatic
unpair after a lost connection.
---
 net/bluetooth/mgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 05d4b83..78caef2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3108,6 +3108,9 @@ int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct pending_cmd *cmd;
 	int err;
 
+	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
+			     hdev);
+
 	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev);
 	if (!cmd)
 		return -ENOENT;
@@ -3120,8 +3123,6 @@ int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	mgmt_pending_remove(cmd);
 
-	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
-			     hdev);
 	return err;
 }
 
-- 
1.7.12

