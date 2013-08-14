Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH v10 07/10] Bluetooth: Add constants and macro declaration for transparent data
Date: Wed, 14 Aug 2013 19:03:31 +0200
Message-Id: <1376499814-11386-8-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1376499814-11386-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1376499814-11386-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch defines constants and macro for transparent data LMP
features. It refers to Bluetooth Core V4.0 specification, Part C, Chap
3.3 which defines LMP feature mask.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a01fbb4..aaeaf09 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -238,6 +238,7 @@ enum {
 #define LMP_CVSD	0x01
 #define LMP_PSCHEME	0x02
 #define LMP_PCONTROL	0x04
+#define LMP_TRANSPARENT	0x08
 
 #define LMP_RSSI_INQ	0x40
 #define LMP_ESCO	0x80
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 61ca2ce..b2bfab8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -800,6 +800,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_lsto_capable(dev)      ((dev)->features[0][7] & LMP_LSTO)
 #define lmp_inq_tx_pwr_capable(dev) ((dev)->features[0][7] & LMP_INQ_TX_PWR)
 #define lmp_ext_feat_capable(dev)  ((dev)->features[0][7] & LMP_EXTFEATURES)
+#define lmp_transp_capable(dev)    ((dev)->features[0][2] & LMP_TRANSPARENT)
 
 /* ----- Extended LMP capabilities ----- */
 #define lmp_host_ssp_capable(dev)  ((dev)->features[1][0] & LMP_HOST_SSP)
-- 
1.7.9.5

