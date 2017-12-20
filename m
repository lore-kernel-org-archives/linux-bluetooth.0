Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC 3/8] Bluetooth: Implement Set PHY Confguration command
Date: Wed, 20 Dec 2017 11:44:32 +0530
Message-Id: <1513750477-8438-3-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1513750477-8438-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1513750477-8438-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This enables user to set default phys which will be set
to the controller which inturn use those PHYs in all subsequent
connections. Also host will use the same in scanning as well.

This patch also implements PHY Changed event which will be
triggered whenever default PHYs change.

This also adds PHY_CONFIGURATION to mgmt settings which set
in the supported settings if controller supports 2M or CODED,
and set in current settings if either 2M or CODED is selected
as the default PHYs

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h  |   5 ++
 include/net/bluetooth/mgmt.h |  17 +++++
 net/bluetooth/hci_event.c    |  57 ++++++++++++++++
 net/bluetooth/mgmt.c         | 154 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 233 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 54273ad..79d6d51 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -214,6 +214,7 @@ enum {
 	HCI_MGMT_DEV_CLASS_EVENTS,
 	HCI_MGMT_LOCAL_NAME_EVENTS,
 	HCI_MGMT_OOB_DATA_EVENTS,
+	HCI_MGMT_PHY_CHANGED_EVENTS,
 };
 
 /*
@@ -1515,6 +1516,10 @@ struct hci_cp_le_set_default_phy {
 	__u8    rx_phys;
 } __packed;
 
+#define HCI_LE_SET_PHY_1M		0x01
+#define HCI_LE_SET_PHY_2M		0x02
+#define HCI_LE_SET_PHY_CODED		0x04
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 23c0e12..cbfe7e4 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -101,6 +101,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_PRIVACY		0x00002000
 #define MGMT_SETTING_CONFIGURATION	0x00004000
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
+#define MGMT_SETTING_PHY_CONFIGURATION  0x00010000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -618,6 +619,17 @@ struct mgmt_rp_get_phy_confguration {
 #define MGMT_PHY_LE_CODED_TX		0x0010
 #define MGMT_PHY_LE_CODED_RX		0x0020
 
+#define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
+			     MGMT_PHY_LE_CODED_TX)
+#define MGMT_PHY_LE_RX_MASK (MGMT_PHY_LE_1M_RX | MGMT_PHY_LE_2M_RX | \
+			     MGMT_PHY_LE_CODED_RX)
+
+#define MGMT_OP_SET_PHY_CONFIGURATION	0x0045
+#define MGMT_SET_PHY_CONFIGURATION_SIZE		2
+struct mgmt_cp_set_phy_confguration {
+	__u16	default_phys;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -838,3 +850,8 @@ struct mgmt_ev_ext_info_changed {
 	__le16	eir_len;
 	__u8	eir[0];
 } __packed;
+
+#define MGMT_EV_PHY_CONFIGURATION_CHANGED	0x0026
+struct mgmt_ev_phy_configuration_changed {
+	__le16	selected_phys;
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cd3bbb7..931376f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1041,6 +1041,59 @@ static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
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
+	/* Clear previous PHY flags */
+	hci_dev_clear_flag(hdev, HCI_LE_PHY_1M_TX);
+	hci_dev_clear_flag(hdev, HCI_LE_PHY_1M_RX);
+	hci_dev_clear_flag(hdev, HCI_LE_PHY_2M_TX);
+	hci_dev_clear_flag(hdev, HCI_LE_PHY_2M_RX);
+	hci_dev_clear_flag(hdev, HCI_LE_PHY_CODED_TX);
+	hci_dev_clear_flag(hdev, HCI_LE_PHY_CODED_RX);
+
+	if (cp->all_phys & 0x01) {
+		hci_dev_set_flag(hdev, HCI_LE_PHY_1M_TX);
+	} else {
+		if (cp->tx_phys & HCI_LE_SET_PHY_1M)
+			hci_dev_set_flag(hdev, HCI_LE_PHY_1M_TX);
+
+		if (cp->tx_phys & HCI_LE_SET_PHY_2M)
+			hci_dev_set_flag(hdev, HCI_LE_PHY_2M_TX);
+
+		if (cp->tx_phys & HCI_LE_SET_PHY_CODED)
+			hci_dev_set_flag(hdev, HCI_LE_PHY_CODED_TX);
+	}
+
+	if (cp->all_phys & 0x02) {
+		hci_dev_set_flag(hdev, HCI_LE_PHY_1M_RX);
+	} else {
+		if (cp->rx_phys & HCI_LE_SET_PHY_1M)
+			hci_dev_set_flag(hdev, HCI_LE_PHY_1M_RX);
+
+		if (cp->rx_phys & HCI_LE_SET_PHY_2M)
+			hci_dev_set_flag(hdev, HCI_LE_PHY_2M_RX);
+
+		if (cp->rx_phys & HCI_LE_SET_PHY_CODED)
+			hci_dev_set_flag(hdev, HCI_LE_PHY_CODED_RX);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 *sent, status = *((__u8 *) skb->data);
@@ -3039,6 +3092,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_write_ssp_debug_mode(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_DEFAULT_PHY:
+		hci_cc_le_set_default_phy(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3bc574d..0a5e87b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -648,6 +648,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_SECURE_CONN;
 		settings |= MGMT_SETTING_PRIVACY;
 		settings |= MGMT_SETTING_STATIC_ADDRESS;
+		if (hdev->le_features[1] & HCI_LE_PHY_2M ||
+		    hdev->le_features[1] & HCI_LE_PHY_CODED)
+			settings |= MGMT_SETTING_PHY_CONFIGURATION;
 	}
 
 	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
@@ -722,6 +725,12 @@ static u32 get_current_settings(struct hci_dev *hdev)
 			settings |= MGMT_SETTING_STATIC_ADDRESS;
 	}
 
+	if (hci_dev_test_flag(hdev, HCI_LE_PHY_2M_TX) ||
+	    hci_dev_test_flag(hdev, HCI_LE_PHY_2M_RX) ||
+	    hci_dev_test_flag(hdev, HCI_LE_PHY_CODED_TX) ||
+	    hci_dev_test_flag(hdev, HCI_LE_PHY_CODED_RX))
+		settings |= MGMT_SETTING_PHY_CONFIGURATION;
+
 	return settings;
 }
 
@@ -3260,6 +3269,150 @@ static int get_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 				 &rp, sizeof(rp));
 }
 
+static int phy_configuration_changed(struct hci_dev *hdev, struct sock *skip)
+{
+	struct mgmt_ev_phy_configuration_changed ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.selected_phys = cpu_to_le16(get_selected_phys(hdev));
+
+	return mgmt_limited_event(MGMT_EV_PHY_CONFIGURATION_CHANGED, hdev, &ev,
+				  sizeof(ev), HCI_MGMT_PHY_CHANGED_EVENTS,
+				  skip);
+}
+
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
+				  cp, sizeof(*cp));
+
+		phy_configuration_changed(hdev, cmd->sk);
+		new_settings(hdev, cmd->sk);
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
+	u16 default_phys, supported_phys, selected_phys;
+	u8 status;
+	int err;
+
+	BT_DBG("sock %p %s", sk, hdev->name);
+
+	status = mgmt_le_support(hdev);
+	if (status)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_PHY_CONFIGURATION, status);
+
+	supported_phys = get_supported_phys(hdev);
+	default_phys = __le16_to_cpu(cp->default_phys);
+
+	if (default_phys & ~supported_phys)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_PHY_CONFIGURATION,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	selected_phys = get_selected_phys(hdev);
+
+	if (default_phys == selected_phys)
+		return mgmt_cmd_complete(sk, hdev->id,
+					 MGMT_OP_SET_PHY_CONFIGURATION,
+					 0, cp, sizeof(*cp));
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
+	if (!(default_phys & MGMT_PHY_LE_TX_MASK))
+		cp_phy.all_phys |= 0x01;
+
+	if (!(default_phys & MGMT_PHY_LE_RX_MASK))
+		cp_phy.all_phys |= 0x02;
+
+	if (default_phys & MGMT_PHY_LE_1M_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (default_phys & MGMT_PHY_LE_2M_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (default_phys & MGMT_PHY_LE_CODED_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_CODED;
+
+	if (default_phys & MGMT_PHY_LE_1M_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (default_phys & MGMT_PHY_LE_2M_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (default_phys & MGMT_PHY_LE_CODED_RX)
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
@@ -6620,6 +6773,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_UNTRUSTED },
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
 	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
+	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.7.4

