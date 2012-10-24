Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Make use feature test macros
Date: Wed, 24 Oct 2012 21:12:01 +0300
Message-Id: <1351102323-4654-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
References: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For better code readability and avoiding simple bugs of checking the
wrong byte of the features make use of feature test macros whenever
possible.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |   26 +++++++++++++-------------
 net/bluetooth/mgmt.c      |   10 +++++-----
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aa325ee..aae8053 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -460,10 +460,10 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
 {
-	if (hdev->features[6] & LMP_EXT_INQ)
+	if (lmp_ext_inq_capable(hdev))
 		return 2;
 
-	if (hdev->features[3] & LMP_RSSI_INQ)
+	if (lmp_inq_rssi_capable(hdev))
 		return 1;
 
 	if (hdev->manufacturer == 11 && hdev->hci_rev == 0x00 &&
@@ -515,22 +515,22 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 		events[5] |= 0x10; /* Synchronous Connection Changed */
 	}
 
-	if (hdev->features[3] & LMP_RSSI_INQ)
+	if (lmp_inq_rssi_capable(hdev))
 		events[4] |= 0x02; /* Inquiry Result with RSSI */
 
 	if (lmp_sniffsubr_capable(hdev))
 		events[5] |= 0x20; /* Sniff Subrating */
 
-	if (hdev->features[5] & LMP_PAUSE_ENC)
+	if (lmp_pause_enc_capable(hdev))
 		events[5] |= 0x80; /* Encryption Key Refresh Complete */
 
-	if (hdev->features[6] & LMP_EXT_INQ)
+	if (lmp_ext_inq_capable(hdev))
 		events[5] |= 0x40; /* Extended Inquiry Result */
 
 	if (lmp_no_flush_capable(hdev))
 		events[7] |= 0x01; /* Enhanced Flush Complete */
 
-	if (hdev->features[7] & LMP_LSTO)
+	if (lmp_lsto_capable(hdev))
 		events[6] |= 0x80; /* Link Supervision Timeout Changed */
 
 	if (lmp_ssp_capable(hdev)) {
@@ -633,13 +633,13 @@ static void hci_setup(struct hci_dev *hdev)
 		}
 	}
 
-	if (hdev->features[3] & LMP_RSSI_INQ)
+	if (lmp_inq_rssi_capable(hdev))
 		hci_setup_inquiry_mode(hdev);
 
-	if (hdev->features[7] & LMP_INQ_TX_PWR)
+	if (lmp_inq_tx_pwr_capable(hdev))
 		hci_send_cmd(hdev, HCI_OP_READ_INQ_RSP_TX_POWER, 0, NULL);
 
-	if (hdev->features[7] & LMP_EXTFEATURES) {
+	if (lmp_ext_feat_capable(hdev)) {
 		struct hci_cp_read_local_ext_features cp;
 
 		cp.page = 0x01;
@@ -686,11 +686,11 @@ static void hci_setup_link_policy(struct hci_dev *hdev)
 
 	if (lmp_rswitch_capable(hdev))
 		link_policy |= HCI_LP_RSWITCH;
-	if (hdev->features[0] & LMP_HOLD)
+	if (lmp_hold_capable(hdev))
 		link_policy |= HCI_LP_HOLD;
 	if (lmp_sniff_capable(hdev))
 		link_policy |= HCI_LP_SNIFF;
-	if (hdev->features[1] & LMP_PARK)
+	if (lmp_park_capable(hdev))
 		link_policy |= HCI_LP_PARK;
 
 	cp.policy = cpu_to_le16(link_policy);
@@ -780,10 +780,10 @@ static void hci_set_le_support(struct hci_dev *hdev)
 
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 		cp.le = 1;
-		cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
+		cp.simul = !!lmp_le_br_capable(hdev);
 	}
 
-	if (cp.le != !!(hdev->host_features[0] & LMP_HOST_LE))
+	if (cp.le != !!lmp_host_le_capable(hdev))
 		hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp),
 			     &cp);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6215c97..0ee150e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -566,7 +566,7 @@ static int update_eir(struct hci_dev *hdev)
 	if (!hdev_is_powered(hdev))
 		return 0;
 
-	if (!(hdev->features[6] & LMP_EXT_INQ))
+	if (!lmp_ext_inq_capable(hdev))
 		return 0;
 
 	if (!test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
@@ -1226,7 +1226,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	val = !!cp->val;
-	enabled = !!(hdev->host_features[0] & LMP_HOST_LE);
+	enabled = !!lmp_host_le_capable(hdev);
 
 	if (!hdev_is_powered(hdev) || val == enabled) {
 		bool changed = false;
@@ -1262,7 +1262,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	if (val) {
 		hci_cp.le = val;
-		hci_cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
+		hci_cp.simul = !!lmp_le_br_capable(hdev);
 	}
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
@@ -2924,7 +2924,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 			struct hci_cp_write_le_host_supported cp;
 
 			cp.le = 1;
-			cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
+			cp.simul = !!lmp_le_br_capable(hdev);
 
 			hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
 				     sizeof(cp), &cp);
@@ -3384,7 +3384,7 @@ static int clear_eir(struct hci_dev *hdev)
 {
 	struct hci_cp_write_eir cp;
 
-	if (!(hdev->features[6] & LMP_EXT_INQ))
+	if (!lmp_ext_inq_capable(hdev))
 		return 0;
 
 	memset(hdev->eir, 0, sizeof(hdev->eir));
-- 
1.7.10.4

