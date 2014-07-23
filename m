Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Read list of local codecs supported by the controller
Date: Wed, 23 Jul 2014 19:13:24 +0200
Message-Id: <1406135604-26220-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the Bluetooth controller supports Read Local Supported Codecs
command, the issue it during initialization so that the list of
codecs is known.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f0a3d8890760..5d30919eaba9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1074,6 +1074,8 @@ struct hci_rp_read_data_block_size {
 	__le16   num_blocks;
 } __packed;
 
+#define HCI_OP_READ_LOCAL_CODECS	0x100b
+
 #define HCI_OP_READ_PAGE_SCAN_ACTIVITY	0x0c1b
 struct hci_rp_read_page_scan_activity {
 	__u8     status;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cfcb6055ced8..f3e14103b76b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1686,6 +1686,10 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[22] & 0x04)
 		hci_set_event_mask_page_2(req);
 
+	/* Read local codec list if the HCI command is supported */
+	if (hdev->commands[29] & 0x20)
+		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
+
 	/* Check for Synchronization Train support */
 	if (lmp_sync_train_capable(hdev))
 		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
-- 
1.9.3

