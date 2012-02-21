Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] Bluetooth: mgmt: Fix powered checks for commands
Date: Tue, 21 Feb 2012 17:59:57 +0200
Message-Id: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Having the HCI_AUTO_OFF flag set means that from a mgmt interface
perspective we're still not powered, so all tests for HCI_UP should also
include a test for HCI_AUTO_OFF. This patch adds a convenience macro for
it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c25cb64..c27481c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -118,6 +118,9 @@ static const u16 mgmt_events[] = {
 
 #define SERVICE_CACHE_TIMEOUT (5 * 1000)
 
+#define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
+				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+
 struct pending_cmd {
 	struct list_head list;
 	u16 opcode;
@@ -733,7 +736,7 @@ static int set_powered(struct sock *sk, u16 index, void *data, u16 len)
 	struct mgmt_mode *cp = data;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
-	int err, up;
+	int err;
 
 	BT_DBG("request for hci%u", index);
 
@@ -758,8 +761,7 @@ static int set_powered(struct sock *sk, u16 index, void *data, u16 len)
 		}
 	}
 
-	up = test_bit(HCI_UP, &hdev->flags);
-	if ((cp->val && up) || (!cp->val && !up)) {
+	if (!!cp->val == hdev_is_powered(hdev)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_POWERED, hdev);
 		goto failed;
 	}
@@ -810,7 +812,7 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -877,7 +879,7 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -1005,7 +1007,7 @@ static int set_link_security(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -1064,7 +1066,7 @@ static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_SSP,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -1621,7 +1623,7 @@ static int pin_code_reply(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -1690,7 +1692,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -1933,7 +1935,7 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
 		err = cmd_status(sk, index, mgmt_op, MGMT_STATUS_NOT_POWERED);
 		goto done;
 	}
@@ -2109,7 +2111,7 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
 						MGMT_STATUS_NOT_POWERED);
 		goto unlock;
@@ -2280,7 +2282,7 @@ static int start_discovery(struct sock *sk, u16 index,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
-- 
1.7.9

