Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 05/16] Bluetooth: Implement PHY changed event
Date: Thu, 19 Jul 2018 17:09:36 +0530
Message-Id: <1532000387-3649-6-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This defines and implement phy changed event and send it to user
whenever selected PHYs changes using SET_PHY_CONFIGURATION.

This will be also trigerred when BREDR pkt_type is changed using
the legacy ioctl HCISETPTYPE.

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
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  5 +++++
 net/bluetooth/hci_core.c         |  4 ++++
 net/bluetooth/mgmt.c             | 22 +++++++++++++++++++++-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a64d13f..ab5d494 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1544,6 +1544,7 @@ void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
 void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 			      u8 instance);
+int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
 
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 0916e20..7f372e9 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -868,3 +868,8 @@ struct mgmt_ev_ext_info_changed {
 	__le16	eir_len;
 	__u8	eir[0];
 } __packed;
+
+#define MGMT_EV_PHY_CONFIGURATION_CHANGED	0x0026
+struct mgmt_ev_phy_configuration_changed {
+	__le32	selected_phys;
+} __packed;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 432f89f..523e91a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1924,7 +1924,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		break;
 
 	case HCISETPTYPE:
+		if (hdev->pkt_type == (__u16) dr.dev_opt)
+			break;
+
 		hdev->pkt_type = (__u16) dr.dev_opt;
+		mgmt_phy_configuration_changed(hdev, NULL);
 		break;
 
 	case HCISETACLMTU:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7cd6a37..1867aad 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3328,6 +3328,18 @@ static int get_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 				 &rp, sizeof(rp));
 }
 
+int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip)
+{
+	struct mgmt_ev_phy_configuration_changed ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.selected_phys = cpu_to_le32(get_selected_phys(hdev));
+
+	return mgmt_event(MGMT_EV_PHY_CONFIGURATION_CHANGED, hdev, &ev,
+			  sizeof(ev), skip);
+}
+
 static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode, struct sk_buff *skb)
 {
@@ -3352,6 +3364,8 @@ static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
 		mgmt_cmd_complete(cmd->sk, hdev->id,
 				  MGMT_OP_SET_PHY_CONFIGURATION, 0,
 				  NULL, 0);
+
+		mgmt_phy_configuration_changed(hdev, cmd->sk);
 	}
 
 	mgmt_pending_remove(cmd);
@@ -3369,6 +3383,7 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 	struct hci_request req;
 	u32 selected_phys, configurable_phys, supported_phys, unconfigure_phys;
 	u16 pkt_type = (HCI_DH1 | HCI_DM1);
+	bool changed = false;
 	int err;
 
 	BT_DBG("sock %p %s", sk, hdev->name);
@@ -3450,11 +3465,16 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 	else
 		pkt_type |= HCI_3DH5;
 
-	if (pkt_type != hdev->pkt_type)
+	if (pkt_type != hdev->pkt_type) {
 		hdev->pkt_type = pkt_type;
+		changed = true;
+	}
 
 	if ((selected_phys & MGMT_PHY_LE_MASK) ==
 	    (get_selected_phys(hdev) & MGMT_PHY_LE_MASK)) {
+		if (changed)
+			mgmt_phy_configuration_changed(hdev, sk);
+
 		err = mgmt_cmd_complete(sk, hdev->id,
 					MGMT_OP_SET_PHY_CONFIGURATION,
 					0, NULL, 0);
-- 
2.7.4
