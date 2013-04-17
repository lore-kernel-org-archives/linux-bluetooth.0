Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Track feature pages in a single table
Date: Wed, 17 Apr 2013 15:00:51 +0300
Message-Id: <1366200052-13196-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1366200052-13196-1-git-send-email-johan.hedberg@gmail.com>
References: <1366200052-13196-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The local and remote features are organized by page number. Page 0
are the LMP features, page 1 the host features, and any pages beyond 1
features that future core specification versions may define. So far
we've only had the first two pages and two separate variables has been
convenient enough, however with the introduction of Core Specification
Addendum 4 there are features defined on page 2.

Instead of requiring the addition of a new variable each time a new page
number is defined, this patch refactors the code to use a single table
for the features. The patch needs to update both the hci_dev and
hci_conn structures since there are macros that depend on the features
being represented in the same way in both of them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   49 ++++++++++++++++----------------
 net/bluetooth/hci_event.c        |   58 ++++++++++++++++++++------------------
 net/bluetooth/hci_sysfs.c        |   16 +++++------
 3 files changed, 63 insertions(+), 60 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 78ea9c7..07fb173 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -134,6 +134,8 @@ struct amp_assoc {
 	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
 };
 
+#define HCI_MAX_PAGES	2
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -151,8 +153,7 @@ struct hci_dev {
 	__u8		dev_class[3];
 	__u8		major_class;
 	__u8		minor_class;
-	__u8		features[8];
-	__u8		host_features[8];
+	__u8		features[HCI_MAX_PAGES][8];
 	__u8		le_features[8];
 	__u8		le_white_list_size;
 	__u8		le_states[8];
@@ -313,7 +314,7 @@ struct hci_conn {
 	bool		out;
 	__u8		attempt;
 	__u8		dev_class[3];
-	__u8		features[8];
+	__u8		features[HCI_MAX_PAGES][8];
 	__u16		interval;
 	__u16		pkt_type;
 	__u16		link_policy;
@@ -760,29 +761,29 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
 
 /* ----- LMP capabilities ----- */
-#define lmp_encrypt_capable(dev)   ((dev)->features[0] & LMP_ENCRYPT)
-#define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
-#define lmp_hold_capable(dev)      ((dev)->features[0] & LMP_HOLD)
-#define lmp_sniff_capable(dev)     ((dev)->features[0] & LMP_SNIFF)
-#define lmp_park_capable(dev)      ((dev)->features[1] & LMP_PARK)
-#define lmp_inq_rssi_capable(dev)  ((dev)->features[3] & LMP_RSSI_INQ)
-#define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
-#define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))
-#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
-#define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
-#define lmp_pause_enc_capable(dev) ((dev)->features[5] & LMP_PAUSE_ENC)
-#define lmp_ext_inq_capable(dev)   ((dev)->features[6] & LMP_EXT_INQ)
-#define lmp_le_br_capable(dev)     !!((dev)->features[6] & LMP_SIMUL_LE_BR)
-#define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
-#define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
-#define lmp_lsto_capable(dev)      ((dev)->features[7] & LMP_LSTO)
-#define lmp_inq_tx_pwr_capable(dev) ((dev)->features[7] & LMP_INQ_TX_PWR)
-#define lmp_ext_feat_capable(dev)  ((dev)->features[7] & LMP_EXTFEATURES)
+#define lmp_encrypt_capable(dev)   ((dev)->features[0][0] & LMP_ENCRYPT)
+#define lmp_rswitch_capable(dev)   ((dev)->features[0][0] & LMP_RSWITCH)
+#define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
+#define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
+#define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
+#define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_INQ)
+#define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
+#define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_BREDR))
+#define lmp_le_capable(dev)        ((dev)->features[0][4] & LMP_LE)
+#define lmp_sniffsubr_capable(dev) ((dev)->features[0][5] & LMP_SNIFF_SUBR)
+#define lmp_pause_enc_capable(dev) ((dev)->features[0][5] & LMP_PAUSE_ENC)
+#define lmp_ext_inq_capable(dev)   ((dev)->features[0][6] & LMP_EXT_INQ)
+#define lmp_le_br_capable(dev)     (!!((dev)->features[0][6] & LMP_SIMUL_LE_BR))
+#define lmp_ssp_capable(dev)       ((dev)->features[0][6] & LMP_SIMPLE_PAIR)
+#define lmp_no_flush_capable(dev)  ((dev)->features[0][6] & LMP_NO_FLUSH)
+#define lmp_lsto_capable(dev)      ((dev)->features[0][7] & LMP_LSTO)
+#define lmp_inq_tx_pwr_capable(dev) ((dev)->features[0][7] & LMP_INQ_TX_PWR)
+#define lmp_ext_feat_capable(dev)  ((dev)->features[0][7] & LMP_EXTFEATURES)
 
 /* ----- Extended LMP capabilities ----- */
-#define lmp_host_ssp_capable(dev)  ((dev)->host_features[0] & LMP_HOST_SSP)
-#define lmp_host_le_capable(dev)   !!((dev)->host_features[0] & LMP_HOST_LE)
-#define lmp_host_le_br_capable(dev) !!((dev)->host_features[0] & LMP_HOST_LE_BREDR)
+#define lmp_host_ssp_capable(dev)  ((dev)->features[1][0] & LMP_HOST_SSP)
+#define lmp_host_le_capable(dev)   (!!((dev)->features[1][0] & LMP_HOST_LE))
+#define lmp_host_le_br_capable(dev) (!!((dev)->features[1][0] & LMP_HOST_LE_BREDR))
 
 /* returns true if at least one AMP active */
 static inline bool hci_amp_capable(void)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f6ea3c7..39c61c9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -433,9 +433,9 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!status) {
 		if (sent->mode)
-			hdev->host_features[0] |= LMP_HOST_SSP;
+			hdev->features[1][0] |= LMP_HOST_SSP;
 		else
-			hdev->host_features[0] &= ~LMP_HOST_SSP;
+			hdev->features[1][0] &= ~LMP_HOST_SSP;
 	}
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
@@ -493,18 +493,18 @@ static void hci_cc_read_local_features(struct hci_dev *hdev,
 	/* Adjust default settings according to features
 	 * supported by device. */
 
-	if (hdev->features[0] & LMP_3SLOT)
+	if (hdev->features[0][0] & LMP_3SLOT)
 		hdev->pkt_type |= (HCI_DM3 | HCI_DH3);
 
-	if (hdev->features[0] & LMP_5SLOT)
+	if (hdev->features[0][0] & LMP_5SLOT)
 		hdev->pkt_type |= (HCI_DM5 | HCI_DH5);
 
-	if (hdev->features[1] & LMP_HV2) {
+	if (hdev->features[0][1] & LMP_HV2) {
 		hdev->pkt_type  |= (HCI_HV2);
 		hdev->esco_type |= (ESCO_HV2);
 	}
 
-	if (hdev->features[1] & LMP_HV3) {
+	if (hdev->features[0][1] & LMP_HV3) {
 		hdev->pkt_type  |= (HCI_HV3);
 		hdev->esco_type |= (ESCO_HV3);
 	}
@@ -512,26 +512,26 @@ static void hci_cc_read_local_features(struct hci_dev *hdev,
 	if (lmp_esco_capable(hdev))
 		hdev->esco_type |= (ESCO_EV3);
 
-	if (hdev->features[4] & LMP_EV4)
+	if (hdev->features[0][4] & LMP_EV4)
 		hdev->esco_type |= (ESCO_EV4);
 
-	if (hdev->features[4] & LMP_EV5)
+	if (hdev->features[0][4] & LMP_EV5)
 		hdev->esco_type |= (ESCO_EV5);
 
-	if (hdev->features[5] & LMP_EDR_ESCO_2M)
+	if (hdev->features[0][5] & LMP_EDR_ESCO_2M)
 		hdev->esco_type |= (ESCO_2EV3);
 
-	if (hdev->features[5] & LMP_EDR_ESCO_3M)
+	if (hdev->features[0][5] & LMP_EDR_ESCO_3M)
 		hdev->esco_type |= (ESCO_3EV3);
 
-	if (hdev->features[5] & LMP_EDR_3S_ESCO)
+	if (hdev->features[0][5] & LMP_EDR_3S_ESCO)
 		hdev->esco_type |= (ESCO_2EV5 | ESCO_3EV5);
 
 	BT_DBG("%s features 0x%.2x%.2x%.2x%.2x%.2x%.2x%.2x%.2x", hdev->name,
-	       hdev->features[0], hdev->features[1],
-	       hdev->features[2], hdev->features[3],
-	       hdev->features[4], hdev->features[5],
-	       hdev->features[6], hdev->features[7]);
+	       hdev->features[0][0], hdev->features[0][1],
+	       hdev->features[0][2], hdev->features[0][3],
+	       hdev->features[0][4], hdev->features[0][5],
+	       hdev->features[0][6], hdev->features[0][7]);
 }
 
 static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
@@ -544,14 +544,8 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	if (rp->status)
 		return;
 
-	switch (rp->page) {
-	case 0:
-		memcpy(hdev->features, rp->features, 8);
-		break;
-	case 1:
-		memcpy(hdev->host_features, rp->features, 8);
-		break;
-	}
+	if (rp->page < HCI_MAX_PAGES)
+		memcpy(hdev->features[rp->page], rp->features, 8);
 }
 
 static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
@@ -1046,14 +1040,14 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 
 	if (!status) {
 		if (sent->le)
-			hdev->host_features[0] |= LMP_HOST_LE;
+			hdev->features[1][0] |= LMP_HOST_LE;
 		else
-			hdev->host_features[0] &= ~LMP_HOST_LE;
+			hdev->features[1][0] &= ~LMP_HOST_LE;
 
 		if (sent->simul)
-			hdev->host_features[0] |= LMP_HOST_LE_BREDR;
+			hdev->features[1][0] |= LMP_HOST_LE_BREDR;
 		else
-			hdev->host_features[0] &= ~LMP_HOST_LE_BREDR;
+			hdev->features[1][0] &= ~LMP_HOST_LE_BREDR;
 	}
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
@@ -2113,7 +2107,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 		goto unlock;
 
 	if (!ev->status)
-		memcpy(conn->features, ev->features, 8);
+		memcpy(conn->features[0], ev->features, 8);
 
 	if (conn->state != BT_CONFIG)
 		goto unlock;
@@ -2925,6 +2919,9 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 	if (!conn)
 		goto unlock;
 
+	if (ev->page < HCI_MAX_PAGES)
+		memcpy(conn->features[ev->page], ev->features, 8);
+
 	if (!ev->status && ev->page == 0x01) {
 		struct inquiry_entry *ie;
 
@@ -3373,11 +3370,16 @@ static void hci_remote_host_features_evt(struct hci_dev *hdev,
 {
 	struct hci_ev_remote_host_features *ev = (void *) skb->data;
 	struct inquiry_entry *ie;
+	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
 
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
+	if (conn)
+		memcpy(conn->features[1], ev->features, 8);
+
 	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
 	if (ie)
 		ie->data.ssp_mode = (ev->features[0] & LMP_HOST_SSP);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index ff38561..f40858f 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -48,10 +48,10 @@ static ssize_t show_link_features(struct device *dev,
 	struct hci_conn *conn = to_hci_conn(dev);
 
 	return sprintf(buf, "0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
-		       conn->features[0], conn->features[1],
-		       conn->features[2], conn->features[3],
-		       conn->features[4], conn->features[5],
-		       conn->features[6], conn->features[7]);
+		       conn->features[0][0], conn->features[0][1],
+		       conn->features[0][2], conn->features[0][3],
+		       conn->features[0][4], conn->features[0][5],
+		       conn->features[0][6], conn->features[0][7]);
 }
 
 #define LINK_ATTR(_name, _mode, _show, _store) \
@@ -234,10 +234,10 @@ static ssize_t show_features(struct device *dev,
 	struct hci_dev *hdev = to_hci_dev(dev);
 
 	return sprintf(buf, "0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
-		       hdev->features[0], hdev->features[1],
-		       hdev->features[2], hdev->features[3],
-		       hdev->features[4], hdev->features[5],
-		       hdev->features[6], hdev->features[7]);
+		       hdev->features[0][0], hdev->features[0][1],
+		       hdev->features[0][2], hdev->features[0][3],
+		       hdev->features[0][4], hdev->features[0][5],
+		       hdev->features[0][6], hdev->features[0][7]);
 }
 
 static ssize_t show_manufacturer(struct device *dev,
-- 
1.7.10.4

