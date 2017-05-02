Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Set LE Default PHY preferences
Date: Mon,  1 May 2017 23:54:19 -0700
Message-Id: <20170502065419.7959-3-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the LE Set Default PHY command is supported, the indicate to the
controller that the host has no preferences for transmitter PHY or
receiver PHY selection.

Issuing this command gives the controller a clear indication that other
PHY can be selected if available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  7 +++++++
 net/bluetooth/hci_core.c    | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index dd43cfdd443a..fe98f0a5bef0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1499,6 +1499,13 @@ struct hci_rp_le_read_max_data_len {
 	__le16	rx_time;
 } __packed;
 
+#define HCI_OP_LE_SET_DEFAULT_PHY	0x2031
+struct hci_cp_le_set_default_phy {
+	__u8    all_phys;
+	__u8    tx_phys;
+	__u8    rx_phys;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 88a616a2b959..43fecd59dfef 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -794,6 +794,18 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_LE_WRITE_DEF_DATA_LEN, sizeof(cp), &cp);
 	}
 
+	/* Set Default PHY parameters if command is supported */
+	if (hdev->commands[35] & 0x20) {
+		struct hci_cp_le_set_default_phy cp;
+
+		/* No transmitter PHY or receiver PHY preferences */
+		cp.all_phys = 0x03;
+		cp.tx_phys = 0;
+		cp.rx_phys = 0;
+
+		hci_req_add(req, HCI_OP_LE_SET_DEFAULT_PHY, sizeof(cp), &cp);
+	}
+
 	return 0;
 }
 
-- 
2.9.3

