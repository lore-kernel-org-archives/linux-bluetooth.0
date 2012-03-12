Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add TX power tag to EIR data
Date: Sun, 11 Mar 2012 19:15:15 -0700
Message-Id: <1331518515-24388-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Inquiry Response TX power tag should be added to the Extended
Inquiry Data (EIR) as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |    4 ++++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |    9 ++++++---
 net/bluetooth/mgmt.c             |    9 +++++++++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 344b0f9..f87f893 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -716,6 +716,10 @@ struct hci_rp_read_local_oob_data {
 } __packed;
 
 #define HCI_OP_READ_INQ_RSP_TX_POWER	0x0c58
+struct hci_rp_read_inq_rsp_tx_power {
+	__u8     status;
+	__s8     tx_power;
+} __packed;
 
 #define HCI_OP_READ_FLOW_CONTROL_MODE	0x0c66
 struct hci_rp_read_flow_control_mode {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 74dfefa..0db4f80 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -158,6 +158,7 @@ struct hci_dev {
 	__u16		lmp_subver;
 	__u16		voice_setting;
 	__u8		io_capability;
+	__s8		inq_tx_power;
 
 	__u16		pkt_type;
 	__u16		esco_type;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 66ffe45..cfbe3f6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -888,11 +888,14 @@ static void hci_cc_write_inquiry_mode(struct hci_dev *hdev,
 static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
+	struct hci_rp_read_inq_rsp_tx_power *rp = (void *) skb->data;
 
-	BT_DBG("%s status 0x%x", hdev->name, status);
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (!rp->status)
+		hdev->inq_tx_power = rp->tx_power;
 
-	hci_req_complete(hdev, HCI_OP_READ_INQ_RSP_TX_POWER, status);
+	hci_req_complete(hdev, HCI_OP_READ_INQ_RSP_TX_POWER, rp->status);
 }
 
 static void hci_cc_set_event_flt(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 97b5b6c..32f6e29 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -479,6 +479,15 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		ptr += (name_len + 2);
 	}
 
+	if (hdev->inq_tx_power) {
+		ptr[0] = 1;
+		ptr[1] = EIR_TX_POWER;
+		ptr[2] = (u8) hdev->inq_tx_power;
+
+		eir_len += 3;
+		ptr += 3;
+	}
+
 	memset(uuid16_list, 0, sizeof(uuid16_list));
 
 	/* Group all UUID16 types */
-- 
1.7.7.6

