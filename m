Return-Path: <cyrus@holtmann.org>
From: Timo Mueller <mail@timomueller.eu>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFCv4 2/5] Bluetooth: Refactor code for outgoing dedicated bonding
Date: Thu, 19 Dec 2013 14:08:15 +0100
Message-Id: <e95862fa0cf2deb0a55144702941359ea52dda5d.1387450436.git.timo.mueller@bmw-carit.de>
In-Reply-To: <f8e5fc8f70fc013f80c95245a94f6c31c2dfb8f2.1387450436.git.timo.mueller@bmw-carit.de>
References: <cover.1387450435.git.timo.mueller@bmw-carit.de>
 <f8e5fc8f70fc013f80c95245a94f6c31c2dfb8f2.1387450436.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1387450435.git.timo.mueller@bmw-carit.de>
References: <cover.1387450435.git.timo.mueller@bmw-carit.de>
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
index 6f9c425..1cbec8f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3089,6 +3089,11 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3160,12 +3165,9 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
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
index a03ca3c..8e302f4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2692,10 +2692,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	sec_level = BT_SECURITY_MEDIUM;
-	if (cp->io_cap == 0x03)
-		auth_type = HCI_AT_DEDICATED_BONDING;
-	else
-		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
+	auth_type = HCI_AT_DEDICATED_BONDING;
 
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr,
-- 
1.8.3.1

