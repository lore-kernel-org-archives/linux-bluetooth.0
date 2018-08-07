Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ankit Navik <ankit.p.navik@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.b.panda@intel.com, ankit.p.navik@intel.com
Subject: [PATCH v2] Bluetooth: Add definitions for LE set address resolution
Date: Tue,  7 Aug 2018 13:16:35 +0530
Message-Id: <1533627995-11330-1-git-send-email-ankit.p.navik@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the definitions for LE address resolution enable HCI commands.
When the LE address resolution enable gets changed via HCI commands
make sure that flag gets updated.

Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
---
 include/net/bluetooth/hci.h |  3 +++
 net/bluetooth/hci_event.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1abcd14..236dd33 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -260,6 +260,7 @@ enum {
 	HCI_VENDOR_DIAG,
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
+	HCI_LL_RPA_RESOLUTION,
 
 	__HCI_NUM_FLAGS,
 };
@@ -1512,6 +1513,8 @@ struct hci_rp_le_read_resolv_list_size {
 	__u8	size;
 } __packed;
 
+#define HCI_OP_LE_SET_ADDR_RESOLV_ENABLE 0x202d
+
 #define HCI_OP_LE_READ_MAX_DATA_LEN	0x202f
 struct hci_rp_le_read_max_data_len {
 	__u8	status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e8d6df9..3121fe3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1372,6 +1372,30 @@ static void hci_cc_le_read_resolv_list_size(struct hci_dev *hdev,
 	hdev->le_resolv_list_size = rp->size;
 }
 
+static void hci_cc_le_set_addr_resolution_enable(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	__u8 *sent, status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE);
+	if (!sent)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (*sent)
+		hci_dev_set_flag(hdev, HCI_LL_RPA_RESOLUTION);
+	else
+		hci_dev_clear_flag(hdev, HCI_LL_RPA_RESOLUTION);
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_read_max_data_len(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
@@ -3097,6 +3121,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_read_resolv_list_size(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_ADDR_RESOLV_ENABLE:
+		hci_cc_le_set_addr_resolution_enable(hdev, skb);
+		break;
+
 	case HCI_OP_LE_READ_MAX_DATA_LEN:
 		hci_cc_le_read_max_data_len(hdev, skb);
 		break;
-- 
1.9.1

