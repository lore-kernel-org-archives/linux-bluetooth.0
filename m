Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 03/16] Bluetooth: Implement Get PHY Configuration mgmt command
Date: Thu, 19 Jul 2018 17:09:34 +0530
Message-Id: <1532000387-3649-4-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This commands basically retrieve the supported packet types of
BREDR and supported PHYs of the controller.

BR_1M_1SLOT, LE_1M_TX and LE_1M_RX would be supported by default.
Other PHYs are supported based on the local features.

Also this sets PHY_CONFIGURATION bit in supported settings.

@ MGMT Command: Get PHY Configuration (0x0044) plen 0
@ MGMT Event: Command Complete (0x0001) plen 15
      Get PHY Configuration (0x0044) plen 12
        Status: Success (0x00)
        Supported PHYs: 0x7fff
          BR 1M 1SLOT
          BR 1M 3SLOT
          BR 1M 5SLOT
          EDR 2M 1SLOT
          EDR 2M 3SLOT
          EDR 2M 5SLOT
          EDR 3M 1SLOT
          EDR 3M 3SLOT
          EDR 3M 5SLOT
          LE 1M TX
          LE 1M RX
          LE 2M TX
          LE 2M RX
          LE CODED TX
          LE CODED RX
        Configurable PHYs: 0x79fe
          BR 1M 3SLOT
          BR 1M 5SLOT
          EDR 2M 1SLOT
          EDR 2M 3SLOT
          EDR 2M 5SLOT
          EDR 3M 1SLOT
          EDR 3M 3SLOT
          EDR 3M 5SLOT
          LE 2M TX
          LE 2M RX
          LE CODED TX
          LE CODED RX
        Selected PHYs: 0x07ff
          BR 1M 1SLOT
          BR 1M 3SLOT
          BR 1M 5SLOT
          EDR 2M 1SLOT
          EDR 2M 3SLOT
          EDR 2M 5SLOT
          EDR 3M 1SLOT
          EDR 3M 3SLOT
          EDR 3M 5SLOT
          LE 1M TX
          LE 1M RX

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/mgmt.h |  25 ++++++++
 net/bluetooth/mgmt.c         | 145 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e7303ee..1c93d6e 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -101,6 +101,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_PRIVACY		0x00002000
 #define MGMT_SETTING_CONFIGURATION	0x00004000
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
+#define MGMT_SETTING_PHY_CONFIGURATION  0x00010000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -604,6 +605,30 @@ struct mgmt_cp_set_appearance {
 } __packed;
 #define MGMT_SET_APPEARANCE_SIZE	2
 
+#define MGMT_OP_GET_PHY_CONFIGURATION	0x0044
+struct mgmt_rp_get_phy_confguration {
+	__le32	supported_phys;
+	__le32	configurable_phys;
+	__le32	selected_phys;
+} __packed;
+#define MGMT_GET_PHY_CONFIGURATION_SIZE	0
+
+#define MGMT_PHY_BR_1M_1SLOT	0x00000001
+#define MGMT_PHY_BR_1M_3SLOT	0x00000002
+#define MGMT_PHY_BR_1M_5SLOT	0x00000004
+#define MGMT_PHY_EDR_2M_1SLOT	0x00000008
+#define MGMT_PHY_EDR_2M_3SLOT	0x00000010
+#define MGMT_PHY_EDR_2M_5SLOT	0x00000020
+#define MGMT_PHY_EDR_3M_1SLOT	0x00000040
+#define MGMT_PHY_EDR_3M_3SLOT	0x00000080
+#define MGMT_PHY_EDR_3M_5SLOT	0x00000100
+#define MGMT_PHY_LE_1M_TX		0x00000200
+#define MGMT_PHY_LE_1M_RX		0x00000400
+#define MGMT_PHY_LE_2M_TX		0x00000800
+#define MGMT_PHY_LE_2M_RX		0x00001000
+#define MGMT_PHY_LE_CODED_TX	0x00002000
+#define MGMT_PHY_LE_CODED_RX	0x00004000
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8a80d48..c8c3b39 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -617,6 +617,127 @@ static int read_config_info(struct sock *sk, struct hci_dev *hdev,
 				 &rp, sizeof(rp));
 }
 
+static u32 get_supported_phys(struct hci_dev *hdev)
+{
+	u32 supported_phys = 0;
+
+	if (lmp_bredr_capable(hdev)) {
+		supported_phys |= MGMT_PHY_BR_1M_1SLOT;
+
+		if (hdev->features[0][0] & LMP_3SLOT)
+			supported_phys |= MGMT_PHY_BR_1M_3SLOT;
+
+		if (hdev->features[0][0] & LMP_5SLOT)
+			supported_phys |= MGMT_PHY_BR_1M_5SLOT;
+
+		if (lmp_edr_2m_capable(hdev)) {
+			supported_phys |= MGMT_PHY_EDR_2M_1SLOT;
+
+			if (lmp_edr_3slot_capable(hdev))
+				supported_phys |= MGMT_PHY_EDR_2M_3SLOT;
+
+			if (lmp_edr_5slot_capable(hdev))
+				supported_phys |= MGMT_PHY_EDR_2M_5SLOT;
+
+			if (lmp_edr_3m_capable(hdev)) {
+				supported_phys |= MGMT_PHY_EDR_3M_1SLOT;
+
+				if (lmp_edr_3slot_capable(hdev))
+					supported_phys |= MGMT_PHY_EDR_3M_3SLOT;
+
+				if (lmp_edr_5slot_capable(hdev))
+					supported_phys |= MGMT_PHY_EDR_3M_5SLOT;
+			}
+		}
+	}
+
+	if (lmp_le_capable(hdev)) {
+		supported_phys |= MGMT_PHY_LE_1M_TX;
+		supported_phys |= MGMT_PHY_LE_1M_RX;
+
+		if (hdev->le_features[1] & HCI_LE_PHY_2M) {
+			supported_phys |= MGMT_PHY_LE_2M_TX;
+			supported_phys |= MGMT_PHY_LE_2M_RX;
+		}
+
+		if (hdev->le_features[1] & HCI_LE_PHY_CODED) {
+			supported_phys |= MGMT_PHY_LE_CODED_TX;
+			supported_phys |= MGMT_PHY_LE_CODED_RX;
+		}
+	}
+
+	return supported_phys;
+}
+
+static u32 get_selected_phys(struct hci_dev *hdev)
+{
+	u32 selected_phys = 0;
+
+	if (lmp_bredr_capable(hdev)) {
+		selected_phys |= MGMT_PHY_BR_1M_1SLOT;
+
+		if (hdev->pkt_type & (HCI_DM3 | HCI_DH3))
+			selected_phys |= MGMT_PHY_BR_1M_3SLOT;
+
+		if (hdev->pkt_type & (HCI_DM5 | HCI_DH5))
+			selected_phys |= MGMT_PHY_BR_1M_5SLOT;
+
+		if (lmp_edr_2m_capable(hdev)) {
+			if (!(hdev->pkt_type & HCI_2DH1))
+				selected_phys |= MGMT_PHY_EDR_2M_1SLOT;
+
+			if (lmp_edr_3slot_capable(hdev) &&
+			    !(hdev->pkt_type & HCI_2DH3))
+				selected_phys |= MGMT_PHY_EDR_2M_3SLOT;
+
+			if (lmp_edr_5slot_capable(hdev) &&
+			    !(hdev->pkt_type & HCI_2DH5))
+				selected_phys |= MGMT_PHY_EDR_2M_5SLOT;
+
+			if (lmp_edr_3m_capable(hdev)) {
+				if (!(hdev->pkt_type & HCI_3DH1))
+					selected_phys |= MGMT_PHY_EDR_3M_1SLOT;
+
+				if (lmp_edr_3slot_capable(hdev) &&
+				    !(hdev->pkt_type & HCI_3DH3))
+					selected_phys |= MGMT_PHY_EDR_3M_3SLOT;
+
+				if (lmp_edr_5slot_capable(hdev) &&
+				    !(hdev->pkt_type & HCI_3DH5))
+					selected_phys |= MGMT_PHY_EDR_3M_5SLOT;
+			}
+		}
+	}
+
+	if (lmp_le_capable(hdev)) {
+		if (hdev->le_tx_def_phys & HCI_LE_SET_PHY_1M)
+			selected_phys |= MGMT_PHY_LE_1M_TX;
+
+		if (hdev->le_rx_def_phys & HCI_LE_SET_PHY_1M)
+			selected_phys |= MGMT_PHY_LE_1M_RX;
+
+		if (hdev->le_tx_def_phys & HCI_LE_SET_PHY_2M)
+			selected_phys |= MGMT_PHY_LE_2M_TX;
+
+		if (hdev->le_rx_def_phys & HCI_LE_SET_PHY_2M)
+			selected_phys |= MGMT_PHY_LE_2M_RX;
+
+		if (hdev->le_tx_def_phys & HCI_LE_SET_PHY_CODED)
+			selected_phys |= MGMT_PHY_LE_CODED_TX;
+
+		if (hdev->le_rx_def_phys & HCI_LE_SET_PHY_CODED)
+			selected_phys |= MGMT_PHY_LE_CODED_RX;
+	}
+
+	return selected_phys;
+}
+
+static u32 get_configurable_phys(struct hci_dev *hdev)
+{
+	return (get_supported_phys(hdev) & ~MGMT_PHY_BR_1M_1SLOT &
+		~MGMT_PHY_LE_1M_TX & ~MGMT_PHY_LE_1M_RX);
+}
+
 static u32 get_supported_settings(struct hci_dev *hdev)
 {
 	u32 settings = 0;
@@ -654,6 +775,8 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	    hdev->set_bdaddr)
 		settings |= MGMT_SETTING_CONFIGURATION;
 
+	settings |= MGMT_SETTING_PHY_CONFIGURATION;
+
 	return settings;
 }
 
@@ -3184,6 +3307,27 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int get_phy_configuration(struct sock *sk, struct hci_dev *hdev,
+				 void *data, u16 len)
+{
+	struct mgmt_rp_get_phy_confguration rp;
+
+	BT_DBG("sock %p %s", sk, hdev->name);
+
+	hci_dev_lock(hdev);
+
+	memset(&rp, 0, sizeof(rp));
+
+	rp.supported_phys = cpu_to_le32(get_supported_phys(hdev));
+	rp.selected_phys = cpu_to_le32(get_selected_phys(hdev));
+	rp.configurable_phys = cpu_to_le32(get_configurable_phys(hdev));
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
@@ -6544,6 +6688,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
 						HCI_MGMT_UNTRUSTED },
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
+	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.7.4
