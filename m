Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Get MWS transport configuration of the controller
Date: Wed, 23 Jul 2014 19:24:57 +0200
Message-Id: <1406136297-31644-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the Bluetooth controller supports Get MWS Transport Layer
Configuration command, then issue it during initialization.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5d30919eaba9..e3fd926df13f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1172,6 +1172,8 @@ struct hci_rp_write_remote_amp_assoc {
 	__u8     phy_handle;
 } __packed;
 
+#define HCI_OP_GET_MWS_TRANSPORT_CONFIG	0x140c
+
 #define HCI_OP_ENABLE_DUT_MODE		0x1803
 
 #define HCI_OP_WRITE_SSP_DEBUG_MODE	0x1804
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f3e14103b76b..078f1ecbc058 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1690,6 +1690,10 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[29] & 0x20)
 		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
 
+	/* Get MWS transport configuration if the HCI command is supported */
+	if (hdev->commands[30] & 0x08)
+		hci_req_add(req, HCI_OP_GET_MWS_TRANSPORT_CONFIG, 0, NULL);
+
 	/* Check for Synchronization Train support */
 	if (lmp_sync_train_capable(hdev))
 		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
-- 
1.9.3

