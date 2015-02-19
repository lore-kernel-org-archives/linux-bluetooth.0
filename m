Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Fix checking for pending Set SSP in Set HS handler
Date: Thu, 19 Feb 2015 17:38:07 +0200
Message-Id: <1424360287-2379-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1424360287-2379-1-git-send-email-johan.hedberg@gmail.com>
References: <1424360287-2379-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Changing the HS setting requires that SSP is enabled, however so far the
code only checked for the SSP flag but not a potentially ongoing Set SSP
operation. This patch adds a check for a pending Set SSP command in the
Set HS handler, and returns a 'busy' error if one is found.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cc67d19a7cb8..3a1b537c9aa6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2175,6 +2175,12 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
+	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+				 MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
 	if (cp->val) {
 		changed = !test_and_set_bit(HCI_HS_ENABLED, &hdev->dev_flags);
 	} else {
-- 
2.1.0

