Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v4 01/13] Bluetooth: Define default phys in hdev and set 1M as default
Date: Wed, 11 Jul 2018 15:01:23 +0530
Message-Id: <1531301495-14479-2-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1M would be set as default and same would be set during power on
if controller support SetDefaultPHY.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      | 4 ++++
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_core.c         | 9 +++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 73e48be..664fe1e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1514,6 +1514,10 @@ struct hci_cp_le_set_default_phy {
 	__u8    rx_phys;
 } __packed;
 
+#define HCI_LE_SET_PHY_1M		0x01
+#define HCI_LE_SET_PHY_2M		0x02
+#define HCI_LE_SET_PHY_CODED		0x04
+
 #define HCI_OP_LE_SET_EXT_SCAN_PARAMS   0x2041
 struct hci_cp_le_set_ext_scan_params {
 	__u8    own_addr_type;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a744535..71f79df 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -315,6 +315,9 @@ struct hci_dev {
 	unsigned long	sco_last_tx;
 	unsigned long	le_last_tx;
 
+	__u8		le_tx_def_phys;
+	__u8		le_rx_def_phys;
+
 	struct workqueue_struct	*workqueue;
 	struct workqueue_struct	*req_workqueue;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f5c21004..432f89f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -830,10 +830,9 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[35] & 0x20) {
 		struct hci_cp_le_set_default_phy cp;
 
-		/* No transmitter PHY or receiver PHY preferences */
-		cp.all_phys = 0x03;
-		cp.tx_phys = 0;
-		cp.rx_phys = 0;
+		cp.all_phys = 0x00;
+		cp.tx_phys = hdev->le_tx_def_phys;
+		cp.rx_phys = hdev->le_rx_def_phys;
 
 		hci_req_add(req, HCI_OP_LE_SET_DEFAULT_PHY, sizeof(cp), &cp);
 	}
@@ -3027,6 +3026,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_max_tx_time = 0x0148;
 	hdev->le_max_rx_len = 0x001b;
 	hdev->le_max_rx_time = 0x0148;
+	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
+	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
-- 
2.7.4

