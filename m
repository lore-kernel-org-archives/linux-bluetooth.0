Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add quirk for external configuration requirement
Date: Fri,  4 Jul 2014 17:23:33 +0200
Message-Id: <1404487415-15089-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a controller requires external configuration, then setting this
quirk will allow indicating this.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 9 +++++++++
 net/bluetooth/hci_core.c    | 3 ++-
 net/bluetooth/mgmt.c        | 9 ++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 148b21699446..4f1c4c7e2f00 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -111,6 +111,15 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_STORED_LINK_KEY,
 
+	/* When this quirk is set, an external configuration step
+	 * is required and will be indicated with the controller
+	 * configuation.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_EXTERNAL_CONFIG,
+
 	/* When this quirk is set, the public Bluetooth address
 	 * initially reported by HCI Read BD Address command
 	 * is considered invalid. Controller configuration is
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c92bee84413f..c007b3543e70 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2249,7 +2249,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	if (hdev->setup && test_bit(HCI_SETUP, &hdev->dev_flags)) {
 		ret = hdev->setup(hdev);
 
-		if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
+		if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
+		    test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
 			set_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 766411e11ac7..d2d0e051e4f2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -445,6 +445,9 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 {
 	u32 options = 0;
 
+	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks))
+		options |= MGMT_OPTION_EXTERNAL_CONFIG;
+
 	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		options |= MGMT_OPTION_PUBLIC_ADDRESS;
@@ -465,6 +468,9 @@ static int read_config_info(struct sock *sk, struct hci_dev *hdev,
 	memset(&rp, 0, sizeof(rp));
 	rp.manufacturer = cpu_to_le16(hdev->manufacturer);
 
+	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks))
+		options |= MGMT_OPTION_EXTERNAL_CONFIG;
+
 	if (hdev->set_bdaddr)
 		options |= MGMT_OPTION_PUBLIC_ADDRESS;
 
@@ -509,7 +515,8 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_PRIVACY;
 	}
 
-	if (hdev->set_bdaddr)
+	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
+	    hdev->set_bdaddr)
 		settings |= MGMT_SETTING_CONFIGURATION;
 
 	return settings;
-- 
1.9.3

