Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Sort feature test macros by bitmask location
Date: Tue, 23 Oct 2012 19:54:00 +0300
Message-Id: <1351011241-32515-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch sorts the feature test marcos according to the location of
each feature bit in the features bit mask. This helps easy lookup when
adding new marcos and wanting to check if there already is a macro

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3ad3281..006aca7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -751,16 +751,16 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
 
 /* ----- LMP capabilities ----- */
-#define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
 #define lmp_encrypt_capable(dev)   ((dev)->features[0] & LMP_ENCRYPT)
+#define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
 #define lmp_sniff_capable(dev)     ((dev)->features[0] & LMP_SNIFF)
-#define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
 #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
-#define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
-#define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
-#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
 #define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))
+#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
+#define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
 #define lmp_le_br_capable(dev)     ((dev)->features[6] & LMP_SIMUL_LE_BR)
+#define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
+#define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
 
 /* ----- Extended LMP capabilities ----- */
 #define lmp_host_le_capable(dev)   ((dev)->host_features[0] & LMP_HOST_LE)
-- 
1.7.10.4

