Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Add missing feature test macros
Date: Wed, 24 Oct 2012 21:12:00 +0300
Message-Id: <1351102323-4654-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
References: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds missing feature test macros needed for various use cases
and also sorts the macros according to the feature bit location in the
feature mask (for easy lookup).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c885e54..6642b3c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -750,18 +750,28 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
 
 /* ----- LMP capabilities ----- */
-#define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
 #define lmp_encrypt_capable(dev)   ((dev)->features[0] & LMP_ENCRYPT)
+#define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
+#define lmp_hold_capable(dev)      ((dev)->features[0] & LMP_HOLD)
 #define lmp_sniff_capable(dev)     ((dev)->features[0] & LMP_SNIFF)
-#define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
+#define lmp_park_capable(dev)      ((dev)->features[1] & LMP_PARK)
+#define lmp_inq_rssi_capable(dev)  ((dev)->features[3] & LMP_RSSI_INQ)
 #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
+#define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))
+#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
+#define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
+#define lmp_pause_enc_capable(dev) ((dev)->features[5] & LMP_PAUSE_ENC)
+#define lmp_ext_inq_capable(dev)   ((dev)->features[6] & LMP_EXT_INQ)
+#define lmp_le_br_capable(dev)     ((dev)->features[6] & LMP_SIMUL_LE_BR)
 #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
 #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
-#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
-#define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))
+#define lmp_lsto_capable(dev)      ((dev)->features[7] & LMP_LSTO)
+#define lmp_inq_tx_pwr_capable(dev) ((dev)->features[7] & LMP_INQ_TX_PWR)
+#define lmp_ext_feat_capable(dev)  ((dev)->features[7] & LMP_EXTFEATURES)
 
 /* ----- Extended LMP capabilities ----- */
 #define lmp_host_le_capable(dev)   ((dev)->host_features[0] & LMP_HOST_LE)
+#define lmp_host_le_br_capable(dev) ((dev)->host_features[0] & LMP_HOST_LE_BREDR)
 
 /* ----- HCI protocols ----- */
 static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
1.7.10.4

