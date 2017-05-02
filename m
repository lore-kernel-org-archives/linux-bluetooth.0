Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set LE Suggested Default Data Length to maximum
Date: Mon,  1 May 2017 21:43:24 -0700
Message-Id: <20170502044324.11714-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When LE Data Packet Length Extension is supported, then actually
increase the suggested default data length to the maximum to enable
higher througput.

< HCI Command: LE Read Maximum Data Length (0x08|0x002f) plen 0
> HCI Event: Command Complete (0x0e) plen 12
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120

< HCI Command: LE Read Suggested Default Data Length (0x08|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 8
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 27
        TX time: 328

< HCI Command: LE Write Suggested Default Data Length (0x08|0x0024) plen 4
        TX octets: 251
        TX time: 2120
> HCI Event: Command Complete (0x0e) plen 4
      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
        Status: Success (0x00)

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 05686776a5fb..4a0cac774107 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -771,6 +771,15 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 			    sizeof(support), &support);
 	}
 
+	/* Set Suggested Default Data Length to maximum if supported */
+	if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
+		struct hci_cp_le_write_def_data_len cp;
+
+		cp.tx_len = hdev->le_max_tx_len;
+		cp.tx_time = hdev->le_max_tx_time;
+		hci_req_add(req, HCI_OP_LE_WRITE_DEF_DATA_LEN, sizeof(cp), &cp);
+	}
+
 	return 0;
 }
 
-- 
2.9.3

