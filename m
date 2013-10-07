Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Read location data on AMP controller init
Date: Mon,  7 Oct 2013 03:55:52 -0700
Message-Id: <1381143353-57149-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When initializing an AMP controller, read its current known location
data so that it can be analyzed later on.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3616ea7..c8a91cb 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -851,6 +851,8 @@ struct hci_rp_read_inq_rsp_tx_power {
 
 #define HCI_OP_SET_EVENT_MASK_PAGE_2	0x0c63
 
+#define HCI_OP_READ_LOCATION_DATA	0x0c64
+
 #define HCI_OP_READ_FLOW_CONTROL_MODE	0x0c66
 struct hci_rp_read_flow_control_mode {
 	__u8     status;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 99f83ab..967739c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -318,6 +318,9 @@ static void amp_init(struct hci_request *req)
 
 	/* Read Data Blk size */
 	hci_req_add(req, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
+
+	/* Read Location Data */
+	hci_req_add(req, HCI_OP_READ_LOCATION_DATA, 0, NULL);
 }
 
 static void hci_init1_req(struct hci_request *req, unsigned long opt)
-- 
1.8.3.1

