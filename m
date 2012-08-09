Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v4 2/3] Bluetooth: Fix minor coding style in hci_event.c
Date: Thu,  9 Aug 2012 09:52:29 +0200
Message-Id: <1344498750-2698-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1344498750-2698-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1344498750-2698-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Replace the status checks with the short form of the boolean expression.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 net/bluetooth/hci_event.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0386e1e..32fcc74 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -303,7 +303,7 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (status != 0) {
+	if (status) {
 		mgmt_write_scan_failed(hdev, param, status);
 		hdev->discov_timeout = 0;
 		goto done;
@@ -925,7 +925,7 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_pin_code_reply_complete(hdev, &rp->bdaddr, rp->status);
 
-	if (rp->status != 0)
+	if (rp->status)
 		goto unlock;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_PIN_CODE_REPLY);
@@ -1906,7 +1906,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags) &&
 	    (conn->type == ACL_LINK || conn->type == LE_LINK)) {
-		if (ev->status != 0)
+		if (ev->status)
 			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 					       conn->dst_type, ev->status);
 		else
@@ -3275,7 +3275,7 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	 * initiated the authentication. A traditional auth_complete
 	 * event gets always produced as initiator and is also mapped to
 	 * the mgmt_auth_failed event */
-	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) && ev->status != 0)
+	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) && ev->status)
 		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
 				 ev->status);
 
-- 
1.7.7.6

