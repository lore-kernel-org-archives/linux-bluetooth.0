Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix HCI request for Inquiry command
Date: Wed, 20 Mar 2013 11:11:47 -0300
Message-Id: <1363788708-28355-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1363788708-28355-1-git-send-email-andre.guedes@openbossa.org>
References: <1363788708-28355-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some HCI commands don't send a Command Complete Event once the
HCI command has completed so they require special handling by
the HCI request framework. HCI Inquiry command is one of those.

The HCI Inquiry command causes the controller to enter in inquiry
mode. A successful Command Status Event for this command means the
the controller is running the inquiry procedure therefore the HCI
Inquiry command has completed.

For that reason, the HCI request framework should consider the
HCI Inquiry command has completed once the host receives the
Command Status Event, instead of the Inquiry Complete Event. The
Inquiry Complete Event means the inquiry procedure has completed
(not the inquiry command).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1385807..b340335 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -53,8 +53,6 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	hci_dev_unlock(hdev);
 
-	hci_req_cmd_complete(hdev, HCI_OP_INQUIRY, status);
-
 	hci_conn_check_pending(hdev);
 }
 
@@ -1079,6 +1077,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	hci_req_cmd_complete(hdev, HCI_OP_INQUIRY, status);
+
 	if (status) {
 		hci_conn_check_pending(hdev);
 		hci_dev_lock(hdev);
@@ -1600,8 +1600,6 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	hci_req_cmd_complete(hdev, HCI_OP_INQUIRY, status);
-
 	hci_conn_check_pending(hdev);
 
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
-- 
1.8.1.2

