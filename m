Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>,
        Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 2/6] Bluetooth: Add support for appearance in scan rsp
Date: Sun, 18 Sep 2016 12:50:03 +0200
Message-Id: <1474195807-12310-2-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

This patch enables prepending appearance value to scan response data.
It also adds support for setting appearance value through mgmt command.
If currently advertised instance has apperance flag set it is expired
immediately.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  6 ++++++
 net/bluetooth/hci_request.c      |  8 ++++++++
 net/bluetooth/mgmt.c             | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a48f71d..f00bf66 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -211,6 +211,7 @@ struct hci_dev {
 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
 	__u8		short_name[HCI_MAX_SHORT_NAME_LENGTH];
 	__u8		eir[HCI_MAX_EIR_LENGTH];
+	__u16		appearance;
 	__u8		dev_class[3];
 	__u8		major_class;
 	__u8		minor_class;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 611b243..72a456b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -598,6 +598,12 @@ struct mgmt_rp_read_ext_info {
 	__u8     eir[0];
 } __packed;
 
+#define MGMT_OP_SET_APPEARANCE		0x0043
+struct mgmt_cp_set_appearance {
+	__u16	appearance;
+} __packed;
+#define MGMT_SET_APPEARANCE_SIZE	2
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 0ce6cdd..c813568 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1015,6 +1015,14 @@ static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
 
 	instance_flags = adv_instance->flags;
 
+	if ((instance_flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance) {
+		ptr[0] = 3;
+		ptr[1] = EIR_APPEARANCE;
+		put_unaligned_le16(hdev->appearance, ptr + 2);
+		scan_rsp_len += 4;
+		ptr += 4;
+	}
+
 	memcpy(ptr, adv_instance->scan_rsp_data,
 	       adv_instance->scan_rsp_len);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fa1f1c7..b9c997c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -105,6 +105,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_GET_ADV_SIZE_INFO,
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_READ_EXT_INFO,
+	MGMT_OP_SET_APPEARANCE,
 };
 
 static const u16 mgmt_events[] = {
@@ -3145,6 +3146,34 @@ failed:
 	return err;
 }
 
+static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
+			  u16 len)
+{
+	struct mgmt_cp_set_appearance *cp = data;
+	u16 apperance;
+	int err;
+
+	BT_DBG("");
+
+	apperance = le16_to_cpu(cp->appearance);
+
+	hci_dev_lock(hdev);
+
+	if (hdev->appearance != apperance) {
+		hdev->appearance = apperance;
+
+		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+			adv_expire(hdev, MGMT_ADV_FLAG_APPEARANCE);
+	}
+
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_APPEARANCE, 0, NULL,
+				0);
+
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -5920,6 +5949,7 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
 	flags |= MGMT_ADV_FLAG_DISCOV;
 	flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
 	flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
+	flags |= MGMT_ADV_FLAG_APPEARANCE;
 	flags |= MGMT_ADV_FLAG_LOCAL_NAME;
 
 	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID)
@@ -6001,6 +6031,9 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		/* at least 1 byte of name should fit in */
 		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
 			max_len -= 3;
+
+		if (adv_flags & MGMT_ADV_FLAG_APPEARANCE)
+			max_len -= 4;
 	}
 
 	if (len > max_len)
@@ -6337,6 +6370,9 @@ static u8 tlv_data_max_len(u32 adv_flags, bool is_adv_data)
 		/* at least 1 byte of name should fit in */
 		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
 			max_len -= 3;
+
+		if (adv_flags & (MGMT_ADV_FLAG_APPEARANCE))
+			max_len -= 4;
 	}
 
 	return max_len;
@@ -6472,6 +6508,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ start_limited_discovery, MGMT_START_DISCOVERY_SIZE },
 	{ read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
 						HCI_MGMT_UNTRUSTED },
+	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.7.4

