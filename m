Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix mgmt_stop_discovery_failed()
Date: Mon,  2 Jan 2012 16:50:53 -0300
Message-Id: <1325533853-10101-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Stop Discovery Command Status Event should use mgmt status code.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2540944..fb0b15e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2756,7 +2756,7 @@ int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 	if (!cmd)
 		return -ENOENT;
 
-	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
+	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status));
 	mgmt_pending_remove(cmd);
 
 	return err;
-- 
1.7.8.1

