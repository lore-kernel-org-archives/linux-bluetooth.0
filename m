Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 01/26] Bluetooth: Move power on HCI command updates to their own function
Date: Fri, 15 Mar 2013 17:06:51 -0500
Message-Id: <1363385236-25704-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These commands will in a subsequent patch be performed in their own
asynchronous request, so it's more readable (not just from a resulting
code perspective but also the way the patches look like) to have them
performed in their own function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   78 +++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 39395c7..7d58b44 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3058,53 +3058,59 @@ static int set_bredr_scan(struct hci_dev *hdev)
 	return hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
-int mgmt_powered(struct hci_dev *hdev, u8 powered)
+static int powered_update_hci(struct hci_dev *hdev)
 {
-	struct cmd_lookup match = { NULL, hdev };
-	int err;
+	u8 link_sec;
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
-		return 0;
+	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
+	    !lmp_host_ssp_capable(hdev)) {
+		u8 ssp = 1;
 
-	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
+	}
 
-	if (powered) {
-		u8 link_sec;
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+		struct hci_cp_write_le_host_supported cp;
 
-		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
-		    !lmp_host_ssp_capable(hdev)) {
-			u8 ssp = 1;
+		cp.le = 1;
+		cp.simul = lmp_le_br_capable(hdev);
 
-			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
-		}
+		/* Check first if we already have the right
+		 * host state (host features set)
+		 */
+		if (cp.le != lmp_host_le_capable(hdev) ||
+		    cp.simul != lmp_host_le_br_capable(hdev))
+			hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+				     sizeof(cp), &cp);
+	}
 
-		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
-			struct hci_cp_write_le_host_supported cp;
+	link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
+	if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
+		hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE,
+			     sizeof(link_sec), &link_sec);
 
-			cp.le = 1;
-			cp.simul = lmp_le_br_capable(hdev);
+	if (lmp_bredr_capable(hdev)) {
+		set_bredr_scan(hdev);
+		update_class(hdev);
+		update_name(hdev, hdev->dev_name);
+		update_eir(hdev);
+	}
 
-			/* Check first if we already have the right
-			 * host state (host features set)
-			 */
-			if (cp.le != lmp_host_le_capable(hdev) ||
-			    cp.simul != lmp_host_le_br_capable(hdev))
-				hci_send_cmd(hdev,
-					     HCI_OP_WRITE_LE_HOST_SUPPORTED,
-					     sizeof(cp), &cp);
-		}
+	return 0;
+}
 
-		link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
-		if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
-			hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE,
-				     sizeof(link_sec), &link_sec);
+int mgmt_powered(struct hci_dev *hdev, u8 powered)
+{
+	struct cmd_lookup match = { NULL, hdev };
+	int err;
 
-		if (lmp_bredr_capable(hdev)) {
-			set_bredr_scan(hdev);
-			update_class(hdev);
-			update_name(hdev, hdev->dev_name);
-			update_eir(hdev);
-		}
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+		return 0;
+
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+
+	if (powered) {
+		powered_update_hci(hdev);
 	} else {
 		u8 status = MGMT_STATUS_NOT_POWERED;
 		u8 zero_cod[] = { 0, 0, 0 };
-- 
1.7.10.4

