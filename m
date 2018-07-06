Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v3 18/18] Bluetooth: Implement secondary advertising on different PHYs
Date: Fri,  6 Jul 2018 17:05:44 +0530
Message-Id: <1530876944-17453-19-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for advertising in primary and secondary
channel on different PHYs. User can add the phy preference in
the flag based on which phy type will be added in extended
advertising parameter would be set.

@ MGMT Command: Add Advertising (0x003e) plen 11
        Instance: 1
        Flags: 0x00000200
          Advertise in CODED on Secondary channel
        Duration: 0
        Timeout: 0
        Advertising data length: 0
        Scan response length: 0
< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 2
        Extended advertising: Disabled (0x00)
        Number of sets: Disable all sets (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x00
        Properties: 0x0000
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: 127 dbm (0x7f)
        Primary PHY: LE Coded (0x03)
        Secondary max skip: 0x00
        Secondary PHY: LE Coded (0x03)
        SID: 0x00
        Scan request notifications: Disabled (0x00)

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h  |  4 ++++
 include/net/bluetooth/mgmt.h |  6 ++++++
 net/bluetooth/hci_request.c  | 39 +++++++++++++++++++++++++++++++--------
 net/bluetooth/mgmt.c         | 18 +++++++++++++++---
 4 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 620cb5b..8ba3fb0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -418,6 +418,8 @@ enum {
 #define HCI_LE_SLAVE_FEATURES		0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
+#define HCI_LE_PHY_2M			0x01
+#define HCI_LE_PHY_CODED		0x08
 #define HCI_LE_EXT_ADV			0x10
 #define HCI_LE_EXT_SCAN_POLICY		0x80
 #define HCI_LE_PHY_2M			0x01
@@ -1614,6 +1616,8 @@ struct hci_cp_le_set_ext_adv_params {
 } __packed;
 
 #define HCI_ADV_PHY_1M		0X01
+#define HCI_ADV_PHY_2M		0x02
+#define HCI_ADV_PHY_CODED	0x03
 
 struct hci_rp_le_set_ext_adv_params {
 	__u8  status;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 047e98d..70b85a7 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -562,6 +562,12 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_FLAG_TX_POWER		BIT(4)
 #define MGMT_ADV_FLAG_APPEARANCE	BIT(5)
 #define MGMT_ADV_FLAG_LOCAL_NAME	BIT(6)
+#define MGMT_ADV_FLAG_SEC_1M 		BIT(7)
+#define MGMT_ADV_FLAG_SEC_2M 		BIT(8)
+#define MGMT_ADV_FLAG_SEC_CODED 	BIT(9)
+
+#define MGMT_ADV_FLAG_SEC_MASK	(MGMT_ADV_FLAG_SEC_1M | MGMT_ADV_FLAG_SEC_2M | \
+				 MGMT_ADV_FLAG_SEC_CODED)
 
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 6825a65..0a8ac3e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1522,6 +1522,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 	bdaddr_t random_addr;
 	u8 own_addr_type;
 	int err;
+	bool secondary_adv;
 	/* In ext adv set param interval is 3 octets */
 	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
 
@@ -1551,20 +1552,42 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
 	memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
 
-	if (connectable)
-		cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
-	else if (get_adv_instance_scan_rsp_len(hdev, instance))
-		cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_SCAN_IND);
-	else
-		cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
+	secondary_adv = (flags & MGMT_ADV_FLAG_SEC_MASK);
+
+	if (connectable) {
+		if (secondary_adv)
+			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
+		else
+			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
+	} else if (get_adv_instance_scan_rsp_len(hdev, instance)) {
+		if (secondary_adv)
+			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);
+		else
+			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_SCAN_IND);
+	} else {
+		if (secondary_adv)
+			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_NON_CONN_IND);
+		else
+			cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
+	}
 
 	cp.own_addr_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 	cp.tx_power = 127;
-	cp.primary_phy = HCI_ADV_PHY_1M;
-	cp.secondary_phy = HCI_ADV_PHY_1M;
 	cp.handle = 0;
 
+	if (flags & MGMT_ADV_FLAG_SEC_2M) {
+		cp.primary_phy = HCI_ADV_PHY_1M;
+		cp.secondary_phy = HCI_ADV_PHY_2M;
+	} else if (flags & MGMT_ADV_FLAG_SEC_CODED) {
+		cp.primary_phy = HCI_ADV_PHY_CODED;
+		cp.secondary_phy = HCI_ADV_PHY_CODED;
+	} else {
+		/* In all other cases use 1M */
+		cp.primary_phy = HCI_ADV_PHY_1M;
+		cp.secondary_phy = HCI_ADV_PHY_1M;
+	}
+
 	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
 
 	if (own_addr_type == ADDR_LE_DEV_RANDOM &&
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c121f1e..67a581a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6356,6 +6356,16 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
 	    ext_adv_capable(hdev))
 		flags |= MGMT_ADV_FLAG_TX_POWER;
 
+	if (ext_adv_capable(hdev)) {
+		flags |= MGMT_ADV_FLAG_SEC_1M;
+
+		if (hdev->le_features[1] & HCI_LE_PHY_2M)
+			flags |= MGMT_ADV_FLAG_SEC_2M;
+
+		if (hdev->le_features[1] & HCI_LE_PHY_CODED)
+			flags |= MGMT_ADV_FLAG_SEC_CODED;
+	}
+
 	return flags;
 }
 
@@ -6561,7 +6571,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_cp_add_advertising *cp = data;
 	struct mgmt_rp_add_advertising rp;
 	u32 flags;
-	u32 supported_flags;
+	u32 supported_flags, phy_flags;
 	u8 status;
 	u16 timeout, duration;
 	unsigned int prev_instance_cnt = hdev->adv_instance_cnt;
@@ -6591,10 +6601,12 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	duration = __le16_to_cpu(cp->duration);
 
 	/* The current implementation only supports a subset of the specified
-	 * flags.
+	 * flags. Also need to check mutual exclusiveness of sec flags.
 	 */
 	supported_flags = get_supported_adv_flags(hdev);
-	if (flags & ~supported_flags)
+	phy_flags = flags & MGMT_ADV_FLAG_SEC_MASK;
+	if (flags & ~supported_flags ||
+	    ((phy_flags && (phy_flags ^ (phy_flags & -phy_flags)))))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-- 
2.7.4
