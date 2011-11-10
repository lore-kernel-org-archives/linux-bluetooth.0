Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix deadlock with mgmt_pair_device
Date: Thu, 10 Nov 2011 15:54:37 +0200
Message-Id: <1320933279-12558-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_conn callbacks are called with the hci_dev lock already held so
no locking should be attempted in them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d23a803..c3d7852 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1331,19 +1331,14 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 {
 	struct pending_cmd *cmd;
-	struct hci_dev *hdev = conn->hdev;
 
 	BT_DBG("status %u", status);
 
-	hci_dev_lock_bh(hdev);
-
 	cmd = find_pairing(conn);
 	if (!cmd)
 		BT_DBG("Unable to find a pending command");
 	else
 		pairing_complete(cmd, status);
-
-	hci_dev_unlock_bh(hdev);
 }
 
 static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
-- 
1.7.7.1

