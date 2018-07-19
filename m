Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 02/16] Bluetooth: Add defines for BREDR pkt_type and LE PHYs
Date: Thu, 19 Jul 2018 17:09:33 +0530
Message-Id: <1532000387-3649-3-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This also add macros for checking LMP support for different
pkt_types

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      | 14 ++++++++++++++
 include/net/bluetooth/hci_core.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 664fe1e..89bf800 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -291,6 +291,14 @@ enum {
 #define HCI_DH3		0x0800
 #define HCI_DH5		0x8000
 
+/* HCI packet types inverted masks */
+#define HCI_2DH1	0x0002
+#define HCI_3DH1	0x0004
+#define HCI_2DH3	0x0100
+#define HCI_3DH3	0x0200
+#define HCI_2DH5	0x1000
+#define HCI_3DH5	0x2000
+
 #define HCI_HV1		0x0020
 #define HCI_HV2		0x0040
 #define HCI_HV3		0x0080
@@ -354,6 +362,8 @@ enum {
 #define LMP_PCONTROL	0x04
 #define LMP_TRANSPARENT	0x08
 
+#define LMP_EDR_2M		0x02
+#define LMP_EDR_3M		0x04
 #define LMP_RSSI_INQ	0x40
 #define LMP_ESCO	0x80
 
@@ -361,7 +371,9 @@ enum {
 #define LMP_EV5		0x02
 #define LMP_NO_BREDR	0x20
 #define LMP_LE		0x40
+#define LMP_EDR_3SLOT	0x80
 
+#define LMP_EDR_5SLOT	0x01
 #define LMP_SNIFF_SUBR	0x02
 #define LMP_PAUSE_ENC	0x04
 #define LMP_EDR_ESCO_2M	0x20
@@ -399,6 +411,8 @@ enum {
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
 #define HCI_LE_EXT_SCAN_POLICY		0x80
+#define HCI_LE_PHY_2M			0x01
+#define HCI_LE_PHY_CODED		0x08
 #define HCI_LE_CHAN_SEL_ALG2		0x40
 
 /* Connection modes */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 71f79df..a64d13f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1141,6 +1141,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_inq_tx_pwr_capable(dev) ((dev)->features[0][7] & LMP_INQ_TX_PWR)
 #define lmp_ext_feat_capable(dev)  ((dev)->features[0][7] & LMP_EXTFEATURES)
 #define lmp_transp_capable(dev)    ((dev)->features[0][2] & LMP_TRANSPARENT)
+#define lmp_edr_2m_capable(dev)    ((dev)->features[0][3] & LMP_EDR_2M)
+#define lmp_edr_3m_capable(dev)    ((dev)->features[0][3] & LMP_EDR_3M)
+#define lmp_edr_3slot_capable(dev) ((dev)->features[0][4] & LMP_EDR_3SLOT)
+#define lmp_edr_5slot_capable(dev) ((dev)->features[0][5] & LMP_EDR_5SLOT)
 
 /* ----- Extended LMP capabilities ----- */
 #define lmp_csb_master_capable(dev) ((dev)->features[2][0] & LMP_CSB_MASTER)
-- 
2.7.4
