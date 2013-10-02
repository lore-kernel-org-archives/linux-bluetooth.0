Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix REJECTED vs NOT_SUPPORTED mgmt responses
Date: Wed,  2 Oct 2013 15:45:22 +0300
Message-Id: <1380717922-25142-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The REJECTED management response should mainly be used when the adapter
is in a state where we cannot accept some command or a specific
parameter value. The NOT_SUPPORTED response in turn means that the
adapter really cannot support the command or parameter value.

This patch fixes this distinction and adds two helper functions to
easily get the appropriate LE or BR/EDR related status response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 76 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b871632..461d5bb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -920,20 +920,41 @@ static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
+static u8 mgmt_bredr_support(struct hci_dev *hdev)
+{
+	if (!lmp_bredr_capable(hdev))
+		return MGMT_STATUS_NOT_SUPPORTED;
+	else if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+		return MGMT_STATUS_REJECTED;
+	else
+		return MGMT_STATUS_SUCCESS;
+}
+
+static u8 mgmt_le_support(struct hci_dev *hdev)
+{
+	if (!lmp_le_capable(hdev))
+		return MGMT_STATUS_NOT_SUPPORTED;
+	else if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		return MGMT_STATUS_REJECTED;
+	else
+		return MGMT_STATUS_SUCCESS;
+}
+
 static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 len)
 {
 	struct mgmt_cp_set_discoverable *cp = data;
 	struct pending_cmd *cmd;
 	u16 timeout;
-	u8 scan;
+	u8 scan, status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	status = mgmt_bredr_support(hdev);
+	if (status)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
-				 MGMT_STATUS_NOT_SUPPORTED);
+				  status);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
@@ -1082,14 +1103,15 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
 	struct hci_request req;
-	u8 scan;
+	u8 scan, status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	status = mgmt_bredr_support(hdev);
+	if (status)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
-				  MGMT_STATUS_NOT_SUPPORTED);
+				  status);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
@@ -1205,14 +1227,15 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
-	u8 val;
+	u8 val, status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	status = mgmt_bredr_support(hdev);
+	if (status)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
-				  MGMT_STATUS_NOT_SUPPORTED);
+				  status);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
@@ -1340,13 +1363,14 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	bool changed;
+	u8 status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+	status = mgmt_bredr_support(hdev);
+	if (status)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS, status);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
@@ -2776,6 +2800,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	struct hci_request req;
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+	u8 status;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2812,9 +2837,10 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
-		if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		status = mgmt_bredr_support(hdev);
+		if (status) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 MGMT_STATUS_NOT_SUPPORTED);
+					 status);
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -2836,9 +2862,10 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	case DISCOV_TYPE_LE:
 	case DISCOV_TYPE_INTERLEAVED:
-		if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+		status = mgmt_le_support(hdev);
+		if (status) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 MGMT_STATUS_NOT_SUPPORTED);
+					 status);
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3182,18 +3209,15 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data, u1
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
 	struct hci_request req;
-	u8 val, enabled;
+	u8 val, enabled, status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!lmp_le_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
-				  MGMT_STATUS_NOT_SUPPORTED);
-
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	status = mgmt_le_support(hdev);
+	if (status)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
-				  MGMT_STATUS_REJECTED);
+				  status);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
@@ -3252,13 +3276,15 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 			      void *data, u16 len)
 {
 	struct mgmt_cp_set_static_address *cp = data;
+	u8 status;
 	int err;
 
 	BT_DBG("%s", hdev->name);
 
-	if (!lmp_le_capable(hdev))
+	status = mgmt_le_support(hdev);
+	if (status)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+				  status);
 
 	if (hdev_is_powered(hdev))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
-- 
1.8.3.1

