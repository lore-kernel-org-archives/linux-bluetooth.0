Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix tracking local SSP authentication requirement
Date: Fri, 11 Jul 2014 15:02:09 +0300
Message-Id: <1405080129-27193-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we need to make the decision whether to perform just-works or real
user confirmation we need to know the exact local authentication
requirement that was passed to the controller. So far conn->auth_type
(the local requirement) wasn't in one case updated appropriately in fear
of the user confirmation being rejected later.

The real problem however was not really that conn->auth_type couldn't
represent the true value but that we were checking the local MITM
requirement in an incorrect way. It's perfectly fine to let auth_type
follow what we tell the controller since we're still tracking the target
security level with conn->pending_sec_level.

This patch updates the check for local MITM requirement in the
hci_user_confirm_request_evt function to use the locally requested
security level and ensures that auth_type always represents what we tell
the controller. All other code in hci_user_confirm_request_evt still
uses the auth_type instead of pending_sec_level for determining whether
to do just-works or not, since that's the only value that's in sync with
what the remote device knows.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f0f220057f21..2ba3113cb608 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3664,18 +3664,15 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		/* If we are initiators, there is no remote information yet */
 		if (conn->remote_auth == 0xff) {
-			cp.authentication = conn->auth_type;
-
 			/* Request MITM protection if our IO caps allow it
 			 * except for the no-bonding case.
-			 * conn->auth_type is not updated here since
-			 * that might cause the user confirmation to be
-			 * rejected in case the remote doesn't have the
-			 * IO capabilities for MITM.
 			 */
 			if (conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
 			    cp.authentication != HCI_AT_NO_BONDING)
-				cp.authentication |= 0x01;
+				conn->auth_type |= 0x01;
+
+			cp.authentication = conn->auth_type;
+
 		} else {
 			conn->auth_type = hci_get_auth_req(conn);
 			cp.authentication = conn->auth_type;
@@ -3747,9 +3744,12 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 	rem_mitm = (conn->remote_auth & 0x01);
 
 	/* If we require MITM but the remote device can't provide that
-	 * (it has NoInputNoOutput) then reject the confirmation request
+	 * (it has NoInputNoOutput) then reject the confirmation
+	 * request. We check the security level here since it doesn't
+	 * necessarily match conn->auth_type.
 	 */
-	if (loc_mitm && conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) {
+	if (conn->pending_sec_level > BT_SECURITY_MEDIUM &&
+	    conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) {
 		BT_DBG("Rejecting request: remote device can't provide MITM");
 		hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_NEG_REPLY,
 			     sizeof(ev->bdaddr), &ev->bdaddr);
-- 
1.9.3

