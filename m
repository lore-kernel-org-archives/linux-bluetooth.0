Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] Bluetooth: Convert Unpair Device to use cmd_complete callback
Date: Fri,  5 Dec 2014 13:36:05 +0200
Message-Id: <1417779369-6428-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the Unpair Device code to take advantage of the
cmd_complete callback of struct pending_cmd.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d3ee7285c303..1accbb9d1a36 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2821,6 +2821,8 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	cmd->cmd_complete = addr_cmd_complete;
+
 	dc.handle = cpu_to_le16(conn->handle);
 	dc.reason = 0x13; /* Remote User Terminated Connection */
 	err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(dc), &dc);
@@ -6430,16 +6432,10 @@ static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 {
 	struct hci_dev *hdev = data;
 	struct mgmt_cp_unpair_device *cp = cmd->param;
-	struct mgmt_rp_unpair_device rp;
-
-	memset(&rp, 0, sizeof(rp));
-	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
-	rp.addr.type = cp->addr.type;
 
 	device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, cmd->sk);
 
-	cmd_complete(cmd->sk, cmd->index, cmd->opcode, 0, &rp, sizeof(rp));
-
+	cmd->cmd_complete(cmd, 0);
 	mgmt_pending_remove(cmd);
 }
 
-- 
2.1.0

