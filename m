Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix allowing initiating pairing when not pairable
Date: Thu, 17 Jul 2014 15:35:40 +0300
Message-Id: <1405600540-28292-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1405600540-28292-1-git-send-email-johan.hedberg@gmail.com>
References: <1405600540-28292-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're not pairable we should still allow us to act as initiators
for pairing, i.e. the HCI_PAIRABLE flag should only be affecting
incoming pairing attempts. This patch fixes the relevant checks for the
hci_io_capa_request_evt() and hci_pin_code_request_evt() functions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index af2cdca03d73..4c41774aa556 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3118,10 +3118,11 @@ static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_drop(conn);
 	}
 
-	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags))
+	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags) &&
+	    !test_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags)) {
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 			     sizeof(ev->bdaddr), &ev->bdaddr);
-	else if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
+	} else if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
 		u8 secure;
 
 		if (conn->pending_sec_level == BT_SECURITY_HIGH)
@@ -3647,7 +3648,11 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		goto unlock;
 
+	/* Allow pairing if we're pairable, the initiators of the
+	 * pairing or if the remote is not requesting bonding.
+	 */
 	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags) ||
+	    test_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags) ||
 	    (conn->remote_auth & ~0x01) == HCI_AT_NO_BONDING) {
 		struct hci_cp_io_capability_reply cp;
 
-- 
1.9.3

