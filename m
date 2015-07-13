Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] Bluetooth: Fix Add Device response status
Date: Mon, 13 Jul 2015 14:36:45 +0200
Message-Id: <1436791005-2894-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure that MGMT_STATUS_INVALID_PARAMS is returned when non identity
address is passed to ADD_DEVICE. Right now MGMT_STATUS_FAILED is
returned, which might be misleading.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7998fb2..47462bf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6226,6 +6226,13 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	else
 		auto_conn = HCI_AUTO_CONN_REPORT;
 
+	/* Allow only identity addresses */
+	if (!hci_is_identity_address(&cp->addr.bdaddr, addr_type)) {
+		err = cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+		mgmt_pending_remove(cmd);
+		goto unlock;
+	}
+
 	/* If the connection parameters don't exist for this device,
 	 * they will be created and configured with defaults.
 	 */
-- 
2.1.4

