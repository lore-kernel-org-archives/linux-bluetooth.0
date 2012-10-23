Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Make use feature test macros
Date: Tue, 23 Oct 2012 19:54:01 +0300
Message-Id: <1351011241-32515-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For better code readability and avoiding simple bugs of checking the
wrong byte of the features make use of feature test macros whenever
possible.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    8 ++++++++
 net/bluetooth/hci_event.c        |   26 +++++++++++++-------------
 net/bluetooth/mgmt.c             |    8 ++++----
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 006aca7..d447f45fa 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -753,14 +753,22 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* ----- LMP capabilities ----- */
 #define lmp_encrypt_capable(dev)   ((dev)->features[0] & LMP_ENCRYPT)
 #define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
+#define lmp_hold_capable(dev)      ((dev)->features[0] & LMP_HOLD)
 #define lmp_sniff_capable(dev)     ((dev)->features[0] & LMP_SNIFF)
+#define lmp_park_capable(dev)      ((dev)->features[1] & LMP_PARK)
+#define lmp_inq_rssi_capable(dev)  ((dev)->features[3] & LMP_RSSI_INQ)
 #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
 #define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))
 #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
 #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
+#define lmp_pause_enc_capable(dev) ((dev)->features[5] & LMP_PAUSE_ENC)
+#define lmp_ext_inq_capable(dev)   ((dev)->features[6] & LMP_EXT_INQ)
 #define lmp_le_br_capable(dev)     ((dev)->features[6] & LMP_SIMUL_LE_BR)
 #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
 #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
+#define lmp_lsto_capable(dev)      ((dev)->features[7] & LMP_LSTO)
+#define lmp_inq_tx_pwr_capable(dev) ((dev)->features[7] & LMP_INQ_TX_PWR)
+#define lmp_ext_feat_capable(dev)  ((dev)->features[7] & LMP_EXTFEATURES)
 
 /* ----- Extended LMP capabilities ----- */
 #define lmp_host_le_capable(dev)   ((dev)->host_features[0] & LMP_HOST_LE)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b63a5f3..0dbdf9b 100644
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
 	else if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fe77f2c..e024f91 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -572,7 +572,7 @@ static int update_eir(struct hci_dev *hdev)
 	if (!hdev_is_powered(hdev))
 		return 0;
 
-	if (!(hdev->features[6] & LMP_EXT_INQ))
+	if (!lmp_ext_inq_capable(hdev))
 		return 0;
 
 	if (!test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
@@ -1302,7 +1302,7 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 static u8 get_le_mode(struct hci_dev *hdev)
 {
-	if (hdev->host_features[0] & LMP_HOST_LE) {
+	if (lmp_host_le_capable(hdev)) {
 		if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
 			return MGMT_LE_PERIPHERAL;
 		return MGMT_LE_CENTRAL;
@@ -1403,7 +1403,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	if (old_mode == MGMT_LE_OFF) {
 		hci_cp.le = 1;
-		hci_cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
+		hci_cp.simul = !!lmp_le_br_capable(hdev);
 	}
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
@@ -3510,7 +3510,7 @@ static int clear_eir(struct hci_dev *hdev)
 {
 	struct hci_cp_write_eir cp;
 
-	if (!(hdev->features[6] & LMP_EXT_INQ))
+	if (!lmp_ext_inq_capable(hdev))
 		return 0;
 
 	memset(hdev->eir, 0, sizeof(hdev->eir));
-- 
1.7.10.4

