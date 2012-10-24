Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 2/9] Bluetooth: Set advertising parameters on LE setup
Date: Wed, 24 Oct 2012 12:58:08 -0300
Message-Id: <1351094295-10418-3-git-send-email-aloisio.almeida@openbossa.org>
In-Reply-To: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
References: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To enable broadcasting we need to set up the advertising parameters. As these
parameters are constant (only observer will use until now), they are set on LE
setup.

This patch makes the advertising non-connectable as default. To make connectable
advertising using 'hciconfig leadv' command, you must change these parameters
first.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 net/bluetooth/hci_event.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0b9e646..3df6e67 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -592,11 +592,22 @@ static void bredr_setup(struct hci_dev *hdev)
 
 static void le_setup(struct hci_dev *hdev)
 {
+	struct hci_cp_le_set_adv_params params;
+
 	/* Read LE Buffer Size */
 	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
 
 	/* Read LE Advertising Channel TX Power */
 	hci_send_cmd(hdev, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
+
+	/* Set ADV params */
+	memset(&params, 0, sizeof(params));
+	params.interval_min = __constant_cpu_to_le16(0x0800);
+	params.interval_max = __constant_cpu_to_le16(0x0800);
+	params.type = ADV_NONCONN_IND;
+	params.own_address_type = ADDR_LE_DEV_PUBLIC;
+	params.channel_map = ADV_USE_ALL_CHANNELS;
+	hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_PARAMS, sizeof(params), &params);
 }
 
 static void hci_setup(struct hci_dev *hdev)
@@ -1310,6 +1321,15 @@ static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
 	amp_write_rem_assoc_continue(hdev, rp->phy_handle);
 }
 
+static void hci_cc_le_set_adv_params(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	hci_req_complete(hdev, HCI_OP_LE_SET_ADV_PARAMS, status);
+}
+
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -2569,6 +2589,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_write_remote_amp_assoc(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_ADV_PARAMS:
+		hci_cc_le_set_adv_params(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
-- 
1.7.10.4

