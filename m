Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix check for support for page scan related commands
Date: Thu, 11 Dec 2014 20:21:54 +0100
Message-Id: <1418325714-15366-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Read Page Scan Activity and Read Page Scan Type commands are not
supported by all controllers. Move the execution of both commands
into the 3rd phase of the init procedure. And then check the bit
mask of supported commands before adding them to the init sequence.

With this re-ordering of the init sequence, the extra check for
AVM BlueFritz! controllers is no longer needed. They will report
that these two commands are not supported.

This fixes an issue with the Microsoft Corp. Wireless Transceiver
for Bluetooth 2.0 (ID 045e:009c).

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ecd7c01317bc..cc60465ea774 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1373,8 +1373,6 @@ static void hci_init1_req(struct hci_request *req, unsigned long opt)
 
 static void bredr_setup(struct hci_request *req)
 {
-	struct hci_dev *hdev = req->hdev;
-
 	__le16 param;
 	__u8 flt_type;
 
@@ -1403,14 +1401,6 @@ static void bredr_setup(struct hci_request *req)
 	/* Connection accept timeout ~20 secs */
 	param = cpu_to_le16(0x7d00);
 	hci_req_add(req, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
-
-	/* AVM Berlin (31), aka "BlueFRITZ!", reports version 1.2,
-	 * but it does not support page scan related HCI commands.
-	 */
-	if (hdev->manufacturer != 31 && hdev->hci_ver > BLUETOOTH_VER_1_1) {
-		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
-		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_TYPE, 0, NULL);
-	}
 }
 
 static void le_setup(struct hci_request *req)
@@ -1718,6 +1708,16 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[5] & 0x10)
 		hci_setup_link_policy(req);
 
+	if (hdev->commands[8] & 0x01)
+		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
+
+	/* Some older Broadcom based Bluetooth 1.2 controllers do not
+	 * support the Read Page Scan Type command. Check support for
+	 * this command in the bit mask of supported commands.
+	 */
+	if (hdev->commands[13] & 0x01)
+		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_TYPE, 0, NULL);
+
 	if (lmp_le_capable(hdev)) {
 		u8 events[8];
 
-- 
2.1.0

