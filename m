Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix not sending command complete for add remote OOB data
Date: Tue, 18 Nov 2014 17:33:10 +0100
Message-Id: <1416328390-19390-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add Remote OOB Data management command should generate Command Complete
event on failure.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cbeef5f..b5cd4c5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3629,9 +3629,16 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
 				   status, &cp->addr, sizeof(cp->addr));
 	} else {
+		struct mgmt_cp_add_remote_oob_data *cp = data;
+
+		/* It is safe to cast data to mgmt_cp_add_remote_oob_data cause
+		 * len is always >= MGMT_ADD_REMOTE_OOB_DATA_SIZE here.
+		 */
+
 		BT_ERR("add_remote_oob_data: invalid length of %u bytes", len);
-		err = cmd_status(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
-				 MGMT_STATUS_INVALID_PARAMS);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
+				   MGMT_STATUS_INVALID_PARAMS,
+				   &cp->addr, sizeof(cp->addr));
 	}
 
 unlock:
-- 
1.9.1

