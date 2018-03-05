Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v1 07/11] Bluetooth: Implement Get PHY Configuration mgmt command
Date: Mon,  5 Mar 2018 16:58:05 +0530
Message-Id: <1520249289-3111-8-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1520249289-3111-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1520249289-3111-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commands basically retrieve the supported PHYs of the
LE controller. 1M would be supported by default. Other PHYs
are supported based on the local LE features.

@ MGMT Command: Get PHY Configuration (0x0044) plen 0
@ MGMT Event: Command Complete (0x0001) plen 7
      Get PHY Configuration (0x0044) plen 4
        Status: Success (0x00)
        Supported PHYs: 0x003f
          1MTX
          1MRX
          2MTX
          2MRX
          CODEDTX
          CODEDRX
        Selected PHYs: 0x003f
          1MTX
          1MRX
          2MTX
          2MRX
          CODEDTX
          CODEDRX

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h  |  2 ++
 include/net/bluetooth/mgmt.h | 14 ++++++++
 net/bluetooth/mgmt.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c4105e6..93164af 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -406,6 +406,8 @@ enum {
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
 #define HCI_LE_EXT_SCAN_POLICY		0x80
+#define HCI_LE_PHY_2M			0x01
+#define HCI_LE_PHY_CODED		0x08
 #define HCI_LE_CHAN_SEL_ALG2		0x40
 
 /* Connection modes */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e7303ee..da9675c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -604,6 +604,20 @@ struct mgmt_cp_set_appearance {
 } __packed;
 #define MGMT_SET_APPEARANCE_SIZE	2
 
+#define MGMT_OP_GET_PHY_CONFIGURATION	0x0044
+#define MGMT_GET_PHY_CONFIGURATION_SIZE		0
+struct mgmt_rp_get_phy_confguration {
+	__le16	supported_phys;
+	__le16	selected_phys;
+} __packed;
+
+#define MGMT_PHY_LE_1M_TX		0x0001
+#define MGMT_PHY_LE_1M_RX		0x0002
+#define MGMT_PHY_LE_2M_TX		0x0004
+#define MGMT_PHY_LE_2M_RX		0x0008
+#define MGMT_PHY_LE_CODED_TX		0x0010
+#define MGMT_PHY_LE_CODED_RX		0x0020
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6e9fc86..3bc574d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -725,6 +725,56 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	return settings;
 }
 
+static u16 get_supported_phys(struct hci_dev *hdev)
+{
+	u16 supported_phys = 0;
+
+	if (!lmp_le_capable(hdev))
+		return 0;
+
+	supported_phys |= MGMT_PHY_LE_1M_TX;
+	supported_phys |= MGMT_PHY_LE_1M_RX;
+
+	if (hdev->le_features[1] & HCI_LE_PHY_2M) {
+		supported_phys |= MGMT_PHY_LE_2M_TX;
+		supported_phys |= MGMT_PHY_LE_2M_RX;
+	}
+	if (hdev->le_features[1] & HCI_LE_PHY_CODED) {
+		supported_phys |= MGMT_PHY_LE_CODED_TX;
+		supported_phys |= MGMT_PHY_LE_CODED_RX;
+	}
+
+	return supported_phys;
+}
+
+static u16 get_selected_phys(struct hci_dev *hdev)
+{
+	u16 selected_phys = 0;
+
+	if (!lmp_le_capable(hdev))
+		return 0;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_PHY_1M_TX))
+		selected_phys |= MGMT_PHY_LE_1M_TX;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_PHY_1M_RX))
+		selected_phys |= MGMT_PHY_LE_1M_RX;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_PHY_2M_TX))
+		selected_phys |= MGMT_PHY_LE_2M_TX;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_PHY_2M_RX))
+		selected_phys |= MGMT_PHY_LE_2M_RX;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_PHY_CODED_TX))
+		selected_phys |= MGMT_PHY_LE_CODED_TX;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_PHY_CODED_RX))
+		selected_phys |= MGMT_PHY_LE_CODED_RX;
+
+	return selected_phys;
+}
+
 static struct mgmt_pending_cmd *pending_find(u16 opcode, struct hci_dev *hdev)
 {
 	return mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
@@ -3184,6 +3234,32 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int get_phy_configuration(struct sock *sk, struct hci_dev *hdev,
+				 void *data, u16 len)
+{
+	struct mgmt_rp_get_phy_confguration rp;
+	u8 status;
+
+	BT_DBG("sock %p %s", sk, hdev->name);
+
+	status = mgmt_le_support(hdev);
+	if (status)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_GET_PHY_CONFIGURATION, status);
+
+	hci_dev_lock(hdev);
+
+	memset(&rp, 0, sizeof(rp));
+
+	rp.supported_phys = cpu_to_le16(get_supported_phys(hdev));
+	rp.selected_phys = cpu_to_le16(get_selected_phys(hdev));
+
+	hci_dev_unlock(hdev);
+
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_PHY_CONFIGURATION, 0,
+				 &rp, sizeof(rp));
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -6543,6 +6619,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
 						HCI_MGMT_UNTRUSTED },
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
+	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.7.4

