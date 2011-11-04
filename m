Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Periodic Inquiry and Discovery
Date: Fri,  4 Nov 2011 14:16:53 -0300
Message-Id: <1320427013-5684-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org>
References: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By using periodic inquiry command we're not able to detect correctly
when the controller has started inquiry.

Today we have this workaround in inquiry result event handler
to set the HCI_INQUIRY flag when it sees the first inquiry result
event. This workaround isn't enough because the device may be
performing an inquiry but the HCI_INQUIRY flag is not set. For
instance, if there is no device in range, no inquiry result event
is generated, consequently, the HCI_INQUIRY flags isn't set when
it should so.

We rely on HCI_INQUIRY flag to implement the discovery procedure
properly. So, as we aren't able to clear/set the HCI_INQUIRY flag
in a reliable manner, periodic inquiry events shouldn't change
the HCI_INQUIRY flag.

Thus, due to that issue and in order to keep compatibility with
userspace, periodic inquiry events shouldn't send mgmt discovering
events.

In future, we might track if periodic inquiry is enabled or not.
By tracking this state we'll be able to do some improvements in
Discovery such as failing MGMT_OP_START_DISCOVERY command in case
periodic inquiry is on. We can also send no mgmt_device_found
event if periodic inquiry is on.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   43 +++++++++++--------------------------------
 1 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d8fa657..bfee273 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -58,9 +58,9 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
-	if (test_and_clear_bit(HCI_INQUIRY, &hdev->flags) &&
-			test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_discovering(hdev->id, 0);
+	clear_bit(HCI_INQUIRY, &hdev->flags);
+
+	mgmt_discovering(hdev->id, 0);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
 
@@ -76,10 +76,6 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
-	if (test_and_clear_bit(HCI_INQUIRY, &hdev->flags) &&
-				test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_discovering(hdev->id, 0);
-
 	hci_conn_check_pending(hdev);
 }
 
@@ -984,9 +980,9 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		return;
 	}
 
-	if (!test_and_set_bit(HCI_INQUIRY, &hdev->flags) &&
-				test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_discovering(hdev->id, 1);
+	set_bit(HCI_INQUIRY, &hdev->flags);
+
+	mgmt_discovering(hdev->id, 1);
 }
 
 static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
@@ -1365,13 +1361,14 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	BT_DBG("%s status %d", hdev->name, status);
 
-	if (test_and_clear_bit(HCI_INQUIRY, &hdev->flags) &&
-				test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_discovering(hdev->id, 0);
-
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
 	hci_conn_check_pending(hdev);
+
+	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
+		return;
+
+	mgmt_discovering(hdev->id, 0);
 }
 
 static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1387,12 +1384,6 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 
 	hci_dev_lock(hdev);
 
-	if (!test_and_set_bit(HCI_INQUIRY, &hdev->flags)) {
-
-		if (test_bit(HCI_MGMT, &hdev->flags))
-			mgmt_discovering(hdev->id, 1);
-	}
-
 	for (; num_rsp; num_rsp--, info++) {
 		bacpy(&data.bdaddr, &info->bdaddr);
 		data.pscan_rep_mode	= info->pscan_rep_mode;
@@ -2393,12 +2384,6 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 
 	hci_dev_lock(hdev);
 
-	if (!test_and_set_bit(HCI_INQUIRY, &hdev->flags)) {
-
-		if (test_bit(HCI_MGMT, &hdev->flags))
-			mgmt_discovering(hdev->id, 1);
-	}
-
 	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
 		struct inquiry_info_with_rssi_and_pscan_mode *info;
 		info = (void *) (skb->data + 1);
@@ -2561,12 +2546,6 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 	if (!num_rsp)
 		return;
 
-	if (!test_and_set_bit(HCI_INQUIRY, &hdev->flags)) {
-
-		if (test_bit(HCI_MGMT, &hdev->flags))
-			mgmt_discovering(hdev->id, 1);
-	}
-
 	hci_dev_lock(hdev);
 
 	for (; num_rsp; num_rsp--, info++) {
-- 
1.7.7.1

