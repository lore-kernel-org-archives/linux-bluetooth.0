Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Read number of supported IAC on controller setup
Date: Mon, 14 Oct 2013 13:56:16 -0700
Message-Id: <1381784176-48692-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When initializing a controller make sure to read out the number of
supported IAC and store its result. This value is needed to determine
if limited discoverable for BR/EDR can be configured or not.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  6 ++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  6 +++++-
 net/bluetooth/hci_event.c        | 19 +++++++++++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c8a91cb..8567f44 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -815,6 +815,12 @@ struct hci_cp_host_buffer_size {
 	__le16   sco_max_pkt;
 } __packed;
 
+#define HCI_OP_READ_NUM_SUPPORTED_IAC	0x0c38
+struct hci_rp_read_num_supported_iac {
+	__u8	status;
+	__u8	num_iac;
+} __packed;
+
 #define HCI_OP_WRITE_INQUIRY_MODE	0x0c45
 
 #define HCI_MAX_EIR_LENGTH		240
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0326b16..4e20842 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -159,6 +159,7 @@ struct hci_dev {
 	__u16		manufacturer;
 	__u16		lmp_subver;
 	__u16		voice_setting;
+	__u8		num_iac;
 	__u8		io_capability;
 	__s8		inq_tx_power;
 	__u16		page_scan_interval;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0e05ede..b5ef05e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -370,6 +370,9 @@ static void bredr_setup(struct hci_request *req)
 	/* Read Voice Setting */
 	hci_req_add(req, HCI_OP_READ_VOICE_SETTING, 0, NULL);
 
+	/* Read Number of Supported IAC */
+	hci_req_add(req, HCI_OP_READ_NUM_SUPPORTED_IAC, 0, NULL);
+
 	/* Clear Event Filters */
 	flt_type = HCI_FLT_CLEAR_ALL;
 	hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
@@ -2271,7 +2274,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
-	hdev->io_capability = 0x03; /* No Input No Output */
+	hdev->num_iac = 0x01;		/* One IAC support is mandatory */
+	hdev->io_capability = 0x03;	/* No Input No Output */
 	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
 	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index da2bc3d..5391469 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -418,6 +418,21 @@ static void hci_cc_write_voice_setting(struct hci_dev *hdev,
 		hdev->notify(hdev, HCI_NOTIFY_VOICE_SETTING);
 }
 
+static void hci_cc_read_num_supported_iac(struct hci_dev *hdev,
+					  struct sk_buff *skb)
+{
+	struct hci_rp_read_num_supported_iac *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->num_iac = rp->num_iac;
+
+	BT_DBG("%s num iac %d", hdev->name, hdev->num_iac);
+}
+
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2135,6 +2150,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_write_voice_setting(hdev, skb);
 		break;
 
+	case HCI_OP_READ_NUM_SUPPORTED_IAC:
+		hci_cc_read_num_supported_iac(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_SSP_MODE:
 		hci_cc_write_ssp_mode(hdev, skb);
 		break;
-- 
1.8.3.1

