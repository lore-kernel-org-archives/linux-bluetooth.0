Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 17/26] Bluetooth: Fix error response for simultaneous fast connectable commands
Date: Wed, 13 Mar 2013 11:12:08 -0700
Message-Id: <1363198337-3896-18-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If there's another pending mgmt_set_fast_connectable command we should
return a "busy" error response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 34caf30..e89938e0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2953,6 +2953,12 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
+	if (mgmt_pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				 MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
 	if (cp->val) {
 		type = PAGE_SCAN_TYPE_INTERLACED;
 
-- 
1.7.10.4

