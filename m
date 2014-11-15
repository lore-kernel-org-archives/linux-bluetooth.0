Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix clearing remote OOB data through mgmt
Date: Sat, 15 Nov 2014 09:34:23 +0200
Message-Id: <1416036863-27634-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When passed BDADDR_ANY the Remove Remote OOB Data comand is specified to
clear all entries. This patch adds the necessary check and calls
hci_remote_oob_data_clear() when necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ce0272c6f71f..f85817604d0a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3635,12 +3635,19 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
+	if (bacmp(&cp->addr.bdaddr, BDADDR_ANY)) {
+		hci_remote_oob_data_clear(hdev);
+		status = MGMT_STATUS_SUCCESS;
+		goto done;
+	}
+
 	err = hci_remove_remote_oob_data(hdev, &cp->addr.bdaddr);
 	if (err < 0)
 		status = MGMT_STATUS_INVALID_PARAMS;
 	else
 		status = MGMT_STATUS_SUCCESS;
 
+done:
 	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 			   status, &cp->addr, sizeof(cp->addr));
 
-- 
2.1.0

