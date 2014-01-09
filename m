Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] Bluetooth: Add LMP feature definitions for Secure Connections support
Date: Thu,  9 Jan 2014 12:56:21 -0800
Message-Id: <1389300990-20255-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The support for Secure Connections introduces two new controller
features and one new host feature.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      | 4 ++++
 include/net/bluetooth/hci_core.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 66c1cd87bfe7..cd40219d32aa 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -282,10 +282,14 @@ enum {
 #define LMP_SYNC_TRAIN	0x04
 #define LMP_SYNC_SCAN	0x08
 
+#define LMP_SC		0x01
+#define LMP_PING	0x02
+
 /* Host features */
 #define LMP_HOST_SSP		0x01
 #define LMP_HOST_LE		0x02
 #define LMP_HOST_LE_BREDR	0x04
+#define LMP_HOST_SC		0x08
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f2f0cf5865c4..bb984d0626b7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -803,9 +803,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_csb_slave_capable(dev)  ((dev)->features[2][0] & LMP_CSB_SLAVE)
 #define lmp_sync_train_capable(dev) ((dev)->features[2][0] & LMP_SYNC_TRAIN)
 #define lmp_sync_scan_capable(dev)  ((dev)->features[2][0] & LMP_SYNC_SCAN)
+#define lmp_sc_capable(dev)         ((dev)->features[2][1] & LMP_SC)
+#define lmp_ping_capable(dev)       ((dev)->features[2][1] & LMP_PING)
 
 /* ----- Host capabilities ----- */
 #define lmp_host_ssp_capable(dev)  ((dev)->features[1][0] & LMP_HOST_SSP)
+#define lmp_host_sc_capable(dev)   ((dev)->features[1][0] & LMP_HOST_SC)
 #define lmp_host_le_capable(dev)   (!!((dev)->features[1][0] & LMP_HOST_LE))
 #define lmp_host_le_br_capable(dev) (!!((dev)->features[1][0] & LMP_HOST_LE_BREDR))
 
-- 
1.8.4.2

