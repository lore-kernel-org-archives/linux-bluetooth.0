Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v3 5/8] Bluetooth: Refactor code for outgoing dedicated bonding
Date: Fri, 28 Jun 2013 10:56:31 +0200
Message-Id: <1372409794-24688-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
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
index fe78b9c..4e5dc5b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3075,6 +3075,11 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3146,12 +3151,9 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
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
index fedc539..ca0ad32 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2185,10 +2185,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
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
1.8.1.4

