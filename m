Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix HCI init for 1st generation BlueFRITZ! devices
Date: Fri, 11 Oct 2013 16:42:07 -0700
Message-Id: <1381534927-27310-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The 1st generation of BlueFRITZ! devices from AVM Berlin pretend
to be HCI version 1.2 controllers, but they are not. They are simple
Bluetooth 1.1 devices.

Since this company never created any newer controllers, it is safe
to use the manufacturer ID instead of an USB quirk.

< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0
> HCI Event: Command Complete (0x0e) plen 8
      Read Page Scan Activity (0x03|0x001b) ncmd 1
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 21.250 msec (0x0022)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0
> HCI Event: Command Status (0x0f) plen 4
      Read Page Scan Type (0x03|0x0046) ncmd 1
        Status: Unknown HCI Command (0x01)

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8f70a35..082f396 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -353,6 +353,8 @@ static void hci_init1_req(struct hci_request *req, unsigned long opt)
 
 static void bredr_setup(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
+
 	__le16 param;
 	__u8 flt_type;
 
@@ -376,8 +378,10 @@ static void bredr_setup(struct hci_request *req)
 	param = __constant_cpu_to_le16(0x7d00);
 	hci_req_add(req, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
 
-	/* Read page scan parameters */
-	if (req->hdev->hci_ver > BLUETOOTH_VER_1_1) {
+	/* AVM Berlin (31), aka "BlueFRITZ!", reports version 1.2,
+	 * but it does not support page scan related HCI commands.
+	 */
+	if (hdev->manufacturer != 31 && hdev->hci_ver > BLUETOOTH_VER_1_1) {
 		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
 		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_TYPE, 0, NULL);
 	}
-- 
1.8.3.1

