Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Make Set Connectable also update the LE advertising type
Date: Mon, 14 Oct 2013 21:15:24 +0300
Message-Id: <1381774527-13746-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
References: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the Set Connectable Management command to also update
the LE advertising type to either connectable or non-connectable
advertising. An extra helper function is needed for getting the right
advertising type since we can not only rely on the HCI_CONNECTABLE flag
but must also check for a pending Set Connectable command (in which case
the flag does not yet have its final value).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index caa552c..a07b081 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1072,6 +1072,25 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 }
 
+static u8 get_adv_type(struct hci_dev *hdev)
+{
+	struct pending_cmd *cmd;
+	bool connectable;
+
+	/* If there's a pending mgmt command the flag will not yet have
+	 * it's final value, so check for this first.
+	 */
+	cmd = mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
+	if (cmd) {
+		struct mgmt_mode *cp = cmd->param;
+		connectable = !!cp->val;
+	} else {
+		connectable = test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+	}
+
+	return connectable ? LE_ADV_IND : LE_ADV_NONCONN_IND;
+}
+
 static void enable_advertising(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -1081,7 +1100,7 @@ static void enable_advertising(struct hci_request *req)
 	memset(&cp, 0, sizeof(cp));
 	cp.min_interval = __constant_cpu_to_le16(0x0800);
 	cp.max_interval = __constant_cpu_to_le16(0x0800);
-	cp.type = LE_ADV_IND;
+	cp.type = get_adv_type(hdev);
 	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
 		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
 	else
@@ -1144,15 +1163,15 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
 	struct hci_request req;
-	u8 scan, status;
+	u8 scan;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	status = mgmt_bredr_support(hdev);
-	if (status)
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
+	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
-				  status);
+				  MGMT_STATUS_REJECTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
@@ -1223,6 +1242,12 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (cp->val || test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
 		write_fast_connectable(&req, false);
 
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) &&
+	    hci_conn_num(hdev, LE_LINK) == 0) {
+		disable_advertising(&req);
+		enable_advertising(&req);
+	}
+
 	err = hci_req_run(&req, set_connectable_complete);
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
-- 
1.8.3.1

