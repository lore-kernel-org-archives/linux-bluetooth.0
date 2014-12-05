Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Add support for enabling Extended Scanner Filter Policies
Date: Fri,  5 Dec 2014 16:20:14 +0100
Message-Id: <1417792815-55907-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new Extended Scanner Filter Policies feature has to be enabled by
selecting the correct filter policy for the scan parameters. This
patch does that when the controller has been enabled to use LE Privacy.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index da8969e08b0c..c1d5726cb8c9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5625,6 +5625,19 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	 */
 	filter_policy = update_white_list(req);
 
+	/* When the controller is using random resolvable addresses and
+	 * with that having LE privacy enabled, then controllers with
+	 * Extended Scanner Filter Policies support can now enable support
+	 * for handling directed advertising.
+	 *
+	 * So instead of using filter polices 0x00 (no whitelist)
+	 * and 0x01 (whitelist enabled) use the new filter policies
+	 * 0x02 (no whitelist) and 0x03 (whitelist enabled).
+	 */
+	if (test_bit(HCI_PRIVACY, &hdev->dev_flags) &&
+	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
+		filter_policy |= 0x02;
+
 	memset(&param_cp, 0, sizeof(param_cp));
 	param_cp.type = LE_SCAN_PASSIVE;
 	param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
-- 
1.9.3

