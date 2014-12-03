Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/49] Bluetooth: Add mgmt_set_secure_conn support for any LE adapter
Date: Wed,  3 Dec 2014 17:02:02 +0200
Message-Id: <1417618963-18010-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since LE Secure Connections is a purely host-side feature we should
offer the Secure Connections mgmt setting for any adapter with LE
support. This patch updates the supported settings value and the
set_secure_conn command handler accordingly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 868769543d83..6e8165364b7f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -574,6 +574,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (lmp_le_capable(hdev)) {
 		settings |= MGMT_SETTING_LE;
 		settings |= MGMT_SETTING_ADVERTISING;
+		settings |= MGMT_SETTING_SECURE_CONN;
 		settings |= MGMT_SETTING_PRIVACY;
 	}
 
@@ -4572,18 +4573,13 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
-	u8 val, status;
+	u8 val;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	status = mgmt_bredr_support(hdev);
-	if (status)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
-				  status);
-
-	if (!lmp_sc_capable(hdev) &&
-	    !test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
+	    !lmp_sc_capable(hdev) && !test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
@@ -4593,7 +4589,10 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!hdev_is_powered(hdev)) {
+	if (!hdev_is_powered(hdev) ||
+	    (!lmp_sc_capable(hdev) &&
+	     !test_bit(HCI_FORCE_SC, &hdev->dbg_flags)) ||
+	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
 		bool changed;
 
 		if (cp->val) {
-- 
2.1.0

