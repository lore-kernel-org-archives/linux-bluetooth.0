Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v3 3/8] Bluetooth: Use defines instead of integer literals
Date: Fri, 28 Jun 2013 10:56:29 +0200
Message-Id: <1372409794-24688-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Replace the occurrences of integer literals in hci_event.c with the
newly introduced macros in hci.h.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 net/bluetooth/hci_event.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ce8be0b..50e39f4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3069,7 +3069,7 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		/* Change the IO capability from KeyboardDisplay
 		 * to DisplayYesNo as it is not supported by BT spec. */
 		cp.capability = (conn->io_capability == 0x04) ?
-						0x01 : conn->io_capability;
+				HCI_IO_DISPLAY_YESNO : conn->io_capability;
 		conn->auth_type = hci_get_auth_req(conn);
 		cp.authentication = conn->auth_type;
 
@@ -3143,7 +3143,8 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 	 * request. The only exception is when we're dedicated bonding
 	 * initiators (connect_cfm_cb set) since then we always have the MITM
 	 * bit set. */
-	if (!conn->connect_cfm_cb && loc_mitm && conn->remote_cap == 0x03) {
+	if (!conn->connect_cfm_cb && loc_mitm &&
+	    conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) {
 		BT_DBG("Rejecting request: remote device can't provide MITM");
 		hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_NEG_REPLY,
 			     sizeof(ev->bdaddr), &ev->bdaddr);
@@ -3151,8 +3152,8 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 	}
 
 	/* If no side requires MITM protection; auto-accept */
-	if ((!loc_mitm || conn->remote_cap == 0x03) &&
-	    (!rem_mitm || conn->io_capability == 0x03)) {
+	if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
+	    (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
 
 		/* If we're not the initiators request authorization to
 		 * proceed from user space (mgmt_user_confirm with
-- 
1.8.1.4

