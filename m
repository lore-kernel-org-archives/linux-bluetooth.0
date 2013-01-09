Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Fix checking for exact values of boolean mgmt parameters
Date: Wed,  9 Jan 2013 15:29:39 +0200
Message-Id: <1357738180-4128-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All mgmt_set_* commands that take a boolean value encoded in the form of
a byte should only accept the values 0x00 and 0x01. This patch adds the
necessary checks for this and returns "invalid params" responses if
anything else is provided as the value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 69221ce..eb9d48a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -777,6 +777,10 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
@@ -872,6 +876,10 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 				 MGMT_STATUS_NOT_SUPPORTED);
 
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	timeout = __le16_to_cpu(cp->timeout);
 	if (!cp->val && timeout > 0)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
@@ -971,6 +979,10 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -1041,6 +1053,10 @@ static int set_pairable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_PAIRABLE,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	if (cp->val)
@@ -1073,6 +1089,10 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -1137,6 +1157,10 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	val = !!cp->val;
@@ -1197,6 +1221,10 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	if (cp->val)
 		set_bit(HCI_HS_ENABLED, &hdev->dev_flags);
 	else
@@ -1219,6 +1247,10 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	val = !!cp->val;
@@ -2630,6 +2662,10 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	if (!hdev_is_powered(hdev))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				  MGMT_STATUS_NOT_POWERED);
-- 
1.7.10.4

