Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 04/16] Bluetooth: Implement Set PHY Confguration command
Date: Thu, 19 Jul 2018 17:09:35 +0530
Message-Id: <1532000387-3649-5-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This enables user to set phys which will be used in all subsequent
connections. Also host will use the same in LE scanning as well.

@ MGMT Command: Set PHY Configuration (0x0045) plen 4
        Selected PHYs: 0x7fff
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
< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3
        All PHYs preference: 0x00
        TX PHYs preference: 0x07
          LE 1M
          LE 2M
          LE Coded
        RX PHYs preference: 0x07
          LE 1M
          LE 2M
          LE Coded
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Default PHY (0x08|0x0031) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 3
      Set PHY Configuration (0x0045) plen 0
        Status: Success (0x00)
@ MGMT Event: PHY Configuration Changed (0x0026) plen 4
        Selected PHYs: 0x7fff
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

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/mgmt.h |  19 +++++
 net/bluetooth/hci_event.c    |  26 +++++++
 net/bluetooth/mgmt.c         | 182 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 1c93d6e..0916e20 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -629,6 +629,25 @@ struct mgmt_rp_get_phy_confguration {
 #define MGMT_PHY_LE_CODED_TX	0x00002000
 #define MGMT_PHY_LE_CODED_RX	0x00004000
 
+#define MGMT_PHY_BREDR_MASK (MGMT_PHY_BR_1M_1SLOT | MGMT_PHY_BR_1M_3SLOT | \
+			     MGMT_PHY_BR_1M_5SLOT | MGMT_PHY_EDR_2M_1SLOT | \
+			     MGMT_PHY_EDR_2M_3SLOT | MGMT_PHY_EDR_2M_5SLOT | \
+			     MGMT_PHY_EDR_3M_1SLOT | MGMT_PHY_EDR_3M_3SLOT | \
+			     MGMT_PHY_EDR_3M_5SLOT)
+#define MGMT_PHY_LE_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_1M_RX | \
+			  MGMT_PHY_LE_2M_TX | MGMT_PHY_LE_2M_RX | \
+			  MGMT_PHY_LE_CODED_TX | MGMT_PHY_LE_CODED_RX)
+#define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
+			     MGMT_PHY_LE_CODED_TX)
+#define MGMT_PHY_LE_RX_MASK (MGMT_PHY_LE_1M_RX | MGMT_PHY_LE_2M_RX | \
+			     MGMT_PHY_LE_CODED_RX)
+
+#define MGMT_OP_SET_PHY_CONFIGURATION	0x0045
+struct mgmt_cp_set_phy_confguration {
+	__le32	selected_phys;
+} __packed;
+#define MGMT_SET_PHY_CONFIGURATION_SIZE	4
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6819215..6942315 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1042,6 +1042,28 @@ static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_default_phy(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+	struct hci_cp_le_set_default_phy *cp;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_DEFAULT_PHY);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	hdev->le_tx_def_phys = cp->tx_phys;
+	hdev->le_rx_def_phys = cp->rx_phys;
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 *sent, status = *((__u8 *) skb->data);
@@ -3163,6 +3185,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_set_ext_scan_enable(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_DEFAULT_PHY:
+		hci_cc_le_set_default_phy(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c8c3b39..7cd6a37 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3328,6 +3328,187 @@ static int get_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 				 &rp, sizeof(rp));
 }
 
+static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
+				     u16 opcode, struct sk_buff *skb)
+{
+	struct mgmt_cp_set_phy_confguration *cp;
+	struct mgmt_pending_cmd *cmd;
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	cmd = pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev);
+	if (!cmd)
+		goto unlock;
+
+	cp = cmd->param;
+
+	if (status) {
+		mgmt_cmd_status(cmd->sk, hdev->id,
+				MGMT_OP_SET_PHY_CONFIGURATION,
+				mgmt_status(status));
+	} else {
+		mgmt_cmd_complete(cmd->sk, hdev->id,
+				  MGMT_OP_SET_PHY_CONFIGURATION, 0,
+				  NULL, 0);
+	}
+
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
+				 void *data, u16 len)
+{
+	struct mgmt_cp_set_phy_confguration *cp = data;
+	struct hci_cp_le_set_default_phy cp_phy;
+	struct mgmt_pending_cmd *cmd;
+	struct hci_request req;
+	u32 selected_phys, configurable_phys, supported_phys, unconfigure_phys;
+	u16 pkt_type = (HCI_DH1 | HCI_DM1);
+	int err;
+
+	BT_DBG("sock %p %s", sk, hdev->name);
+
+	configurable_phys = get_configurable_phys(hdev);
+	supported_phys = get_supported_phys(hdev);
+	selected_phys = __le32_to_cpu(cp->selected_phys);
+
+	if (selected_phys & ~supported_phys)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_PHY_CONFIGURATION,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	unconfigure_phys = supported_phys & ~configurable_phys;
+
+	if ((selected_phys & unconfigure_phys) != unconfigure_phys)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_PHY_CONFIGURATION,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	if (selected_phys == get_selected_phys(hdev))
+		return mgmt_cmd_complete(sk, hdev->id,
+					 MGMT_OP_SET_PHY_CONFIGURATION,
+					 0, NULL, 0);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_PHY_CONFIGURATION,
+				      MGMT_STATUS_REJECTED);
+		goto unlock;
+	}
+
+	if (pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_PHY_CONFIGURATION,
+				      MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	if (selected_phys & MGMT_PHY_BR_1M_3SLOT)
+		pkt_type |= (HCI_DH3 | HCI_DM3);
+	else
+		pkt_type &= ~(HCI_DH3 | HCI_DM3);
+
+	if (selected_phys & MGMT_PHY_BR_1M_5SLOT)
+		pkt_type |= (HCI_DH5 | HCI_DM5);
+	else
+		pkt_type &= ~(HCI_DH5 | HCI_DM5);
+
+	if (selected_phys & MGMT_PHY_EDR_2M_1SLOT)
+		pkt_type &= ~HCI_2DH1;
+	else
+		pkt_type |= HCI_2DH1;
+
+	if (selected_phys & MGMT_PHY_EDR_2M_3SLOT)
+		pkt_type &= ~HCI_2DH3;
+	else
+		pkt_type |= HCI_2DH3;
+
+	if (selected_phys & MGMT_PHY_EDR_2M_5SLOT)
+		pkt_type &= ~HCI_2DH5;
+	else
+		pkt_type |= HCI_2DH5;
+
+	if (selected_phys & MGMT_PHY_EDR_3M_1SLOT)
+		pkt_type &= ~HCI_3DH1;
+	else
+		pkt_type |= HCI_3DH1;
+
+	if (selected_phys & MGMT_PHY_EDR_3M_3SLOT)
+		pkt_type &= ~HCI_3DH3;
+	else
+		pkt_type |= HCI_3DH3;
+
+	if (selected_phys & MGMT_PHY_EDR_3M_5SLOT)
+		pkt_type &= ~HCI_3DH5;
+	else
+		pkt_type |= HCI_3DH5;
+
+	if (pkt_type != hdev->pkt_type)
+		hdev->pkt_type = pkt_type;
+
+	if ((selected_phys & MGMT_PHY_LE_MASK) ==
+	    (get_selected_phys(hdev) & MGMT_PHY_LE_MASK)) {
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_SET_PHY_CONFIGURATION,
+					0, NULL, 0);
+
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_PHY_CONFIGURATION, hdev, data,
+			       len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	hci_req_init(&req, hdev);
+
+	memset(&cp_phy, 0, sizeof(cp_phy));
+
+	if (!(selected_phys & MGMT_PHY_LE_TX_MASK))
+		cp_phy.all_phys |= 0x01;
+
+	if (!(selected_phys & MGMT_PHY_LE_RX_MASK))
+		cp_phy.all_phys |= 0x02;
+
+	if (selected_phys & MGMT_PHY_LE_1M_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (selected_phys & MGMT_PHY_LE_2M_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (selected_phys & MGMT_PHY_LE_CODED_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_CODED;
+
+	if (selected_phys & MGMT_PHY_LE_1M_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (selected_phys & MGMT_PHY_LE_2M_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (selected_phys & MGMT_PHY_LE_CODED_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_CODED;
+
+	hci_req_add(&req, HCI_OP_LE_SET_DEFAULT_PHY, sizeof(cp_phy), &cp_phy);
+
+	err = hci_req_run_skb(&req, set_default_phy_complete);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -6689,6 +6870,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_UNTRUSTED },
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
 	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
+	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.7.4
