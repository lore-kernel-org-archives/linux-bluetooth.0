Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add event mask page 2 setting support
Date: Fri, 13 Sep 2013 11:40:02 +0300
Message-Id: <1379061602-8290-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379061602-8290-1-git-send-email-johan.hedberg@gmail.com>
References: <1379061602-8290-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For those controller that support the HCI_Set_Event_Mask_Page_2 command
we should include it in the init sequence. This patch implements sending
of the command and enables the events in it based on supported features
(currently only CSB is checked).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  2 ++
 net/bluetooth/hci_core.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 63cce97..57aa408 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -827,6 +827,8 @@ struct hci_rp_read_inq_rsp_tx_power {
 	__s8     tx_power;
 } __packed;
 
+#define HCI_OP_SET_EVENT_MASK_PAGE_2	0x0c63
+
 #define HCI_OP_READ_FLOW_CONTROL_MODE	0x0c66
 struct hci_rp_read_flow_control_mode {
 	__u8     status;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8f73b1f..35550d3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -604,6 +604,34 @@ static void hci_set_le_support(struct hci_request *req)
 			    &cp);
 }
 
+static void hci_set_event_mask_page_2(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	u8 events[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+
+	/* If Connectionless Slave Broadcast master role is supported
+	 * enable all necessary events for it.
+	 */
+	if (hdev->features[2][0] & 0x01) {
+		events[1] |= 0x40;	/* Triggered Clock Capture */
+		events[1] |= 0x80;	/* Synchronization Train Complete */
+		events[2] |= 0x10;	/* Slave Page Response Timeout */
+		events[2] |= 0x20;	/* CSB Channel Map Change */
+	}
+
+	/* If Connectionless Slave Broadcast slave role is supported
+	 * enable all necessary events for it.
+	 */
+	if (hdev->features[2][0] & 0x02) {
+		events[2] |= 0x01;	/* Synchronization Train Received */
+		events[2] |= 0x02;	/* CSB Receive */
+		events[2] |= 0x04;	/* CSB Timeout */
+		events[2] |= 0x08;	/* Truncated Page Complete */
+	}
+
+	hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2, sizeof(events), events);
+}
+
 static void hci_init3_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -649,6 +677,10 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
 
+	/* Set event mask page 2 if the HCI command for it is supported */
+	if (hdev->commands[22] & 0x04)
+		hci_set_event_mask_page_2(req);
+
 	/* Check for Synchronization Train support */
 	if (hdev->features[2][0] & 0x04)
 		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
-- 
1.8.4.rc3

