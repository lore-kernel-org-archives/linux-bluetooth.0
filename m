Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Run special init procedure for unconfigured controllers
Date: Sat,  5 Jul 2014 10:48:02 +0200
Message-Id: <1404550083-29418-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For an unconfigured controller it is required to read at least the
local version information. If the set_bdaddr driver callback is
provideded, then also the local Bluetooth address will be read.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b29f3938e6b3..f996e2c4815c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1791,6 +1791,35 @@ static int __hci_init(struct hci_dev *hdev)
 	return 0;
 }
 
+static void hci_init0_req(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	BT_DBG("%s %ld", hdev->name, opt);
+
+	/* Reset */
+	if (!test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks))
+		hci_reset_req(req, 0);
+
+	/* Read Local Version */
+	hci_req_add(req, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
+
+	/* Read BD Address */
+	if (hdev->set_bdaddr)
+		hci_req_add(req, HCI_OP_READ_BD_ADDR, 0, NULL);
+}
+
+static int __hci_unconf_init(struct hci_dev *hdev)
+{
+	int err;
+
+	err = __hci_req_sync(hdev, hci_init0_req, 0, HCI_INIT_TIMEOUT);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static void hci_scan_req(struct hci_request *req, unsigned long opt)
 {
 	__u8 scan = opt;
@@ -2259,6 +2288,17 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
 		    test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
 			set_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
+
+		/* For an unconfigured controller it is required to
+		 * read at least the version information provided by
+		 * the Read Local Version Information command.
+		 *
+		 * If the set_bdaddr driver callback is provided, then
+		 * also the original Bluetooth public device address
+		 * will be read using the Read BD Address command.
+		 */
+		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+			ret = __hci_unconf_init(hdev);
 	}
 
 	/* If public address change is configured, ensure that the
-- 
1.9.3

