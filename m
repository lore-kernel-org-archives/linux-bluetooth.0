Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Add tracking of advertising address type
Date: Thu, 27 Feb 2014 14:05:40 +0200
Message-Id: <1393502743-9995-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393502743-9995-1-git-send-email-johan.hedberg@gmail.com>
References: <1393502743-9995-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To know the real source address for incoming connections (needed e.g.
for SMP) we should store the own_address_type parameter that was used
for the last HCI_LE_Write_Advertising_Parameters command. This patch
adds a proper command complete handler for the command and stores the
address type in a new adv_addr_type variable in the hci_dev struct.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 79a75edc62d0..853376df4f99 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -156,6 +156,7 @@ struct hci_dev {
 	bdaddr_t	bdaddr;
 	bdaddr_t	random_addr;
 	bdaddr_t	static_addr;
+	__u8		adv_addr_type;
 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
 	__u8		short_name[HCI_MAX_SHORT_NAME_LENGTH];
 	__u8		eir[HCI_MAX_EIR_LENGTH];
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cda92db2a9fc..f26e91f72930 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1078,6 +1078,25 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 	}
 }
 
+static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_cp_le_set_adv_param *cp;
+	u8 status = *((u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_PARAM);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+	hdev->adv_addr_type = cp->own_address_type;
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
@@ -2367,6 +2386,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_write_le_host_supported(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_ADV_PARAM:
+		hci_cc_set_adv_param(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_REMOTE_AMP_ASSOC:
 		hci_cc_write_remote_amp_assoc(hdev, skb);
 		break;
-- 
1.8.5.3

