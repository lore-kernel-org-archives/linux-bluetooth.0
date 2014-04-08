Return-Path: <cyrus@holtmann.org>
From: Timo Mueller <timo.mueller@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFCv5 2/4] Bluetooth: Refactor code for outgoing dedicated bonding
Date: Tue,  8 Apr 2014 14:21:32 +0200
Message-Id: <cab20b0aaed6f4543ccbdad89d8e81e379167722.1396943583.git.timo.mueller@bmw-carit.de>
In-Reply-To: <4493824f7a251d7345f2120c70e80b673368b475.1396943583.git.timo.mueller@bmw-carit.de>
References: <cover.1396943583.git.timo.mueller@bmw-carit.de>
 <4493824f7a251d7345f2120c70e80b673368b475.1396943583.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1396943583.git.timo.mueller@bmw-carit.de>
References: <cover.1396943583.git.timo.mueller@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Do not always set the MITM protection requirement by default in the
field conn->auth_type, since this will be added later in
hci_io_capa_request_evt(), as part of the requirements specified in
HCI_OP_IO_CAPABILITY_REPLY.

This avoids a hackish exception for the auto-reject case, but doesn't
change the behavior of the code at all.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 net/bluetooth/hci_event.c | 14 ++++++++------
 net/bluetooth/mgmt.c      |  5 +----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0801668..2c09732 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3471,6 +3471,11 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		/* If we are initiators, there is no remote information yet */
 		if (conn->remote_auth == 0xff) {
 			cp.authentication = conn->auth_type;
+
+			/* Use MITM protection for outgoing dedicated bonding */
+			if (conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
+			    cp.authentication == HCI_AT_DEDICATED_BONDING)
+				cp.authentication |= 0x01;
 		} else {
 			conn->auth_type = hci_get_auth_req(conn);
 			cp.authentication = conn->auth_type;
@@ -3542,12 +3547,9 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 	rem_mitm = (conn->remote_auth & 0x01);
 
 	/* If we require MITM but the remote device can't provide that
-	 * (it has NoInputNoOutput) then reject the confirmation
-	 * request. The only exception is when we're dedicated bonding
-	 * initiators (connect_cfm_cb set) since then we always have the MITM
-	 * bit set. */
-	if (!conn->connect_cfm_cb && loc_mitm &&
-	    conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) {
+	 * (it has NoInputNoOutput) then reject the confirmation request
+	 */
+	if (loc_mitm && conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) {
 		BT_DBG("Rejecting request: remote device can't provide MITM");
 		hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_NEG_REPLY,
 			     sizeof(ev->bdaddr), &ev->bdaddr);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 11cb00a..54abbce 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2850,10 +2850,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	sec_level = BT_SECURITY_MEDIUM;
-	if (cp->io_cap == 0x03)
-		auth_type = HCI_AT_DEDICATED_BONDING;
-	else
-		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
+	auth_type = HCI_AT_DEDICATED_BONDING;
 
 	if (cp->addr.type == BDADDR_BREDR) {
 		conn = hci_connect_acl(hdev, &cp->addr.bdaddr, sec_level,
-- 
1.9.0

