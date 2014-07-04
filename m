Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Add quirk for invalid controller address setting
Date: Fri,  4 Jul 2014 16:54:37 +0200
Message-Id: <1404485680-1682-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a Bluetooth controller does not have a valid public Bluetooth
address, then allow the driver to indicate this. If the quirk is
set, the Bluetooth core will switch to unconfigured state first
and will allow userspace to configure the address before starting
the full initialization of the controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 10 ++++++++++
 net/bluetooth/hci_core.c    |  6 +++++-
 net/bluetooth/mgmt.c        | 21 +++++++++++++++++----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 744713cd5335..148b21699446 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -110,6 +110,16 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_BROKEN_STORED_LINK_KEY,
+
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. Controller configuration is
+	 * required before this device can be used.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_INVALID_BDADDR,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 038b4748375b..c92bee84413f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2246,9 +2246,13 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	atomic_set(&hdev->cmd_cnt, 1);
 	set_bit(HCI_INIT, &hdev->flags);
 
-	if (hdev->setup && test_bit(HCI_SETUP, &hdev->dev_flags))
+	if (hdev->setup && test_bit(HCI_SETUP, &hdev->dev_flags)) {
 		ret = hdev->setup(hdev);
 
+		if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
+			set_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
+	}
+
 	/* If public address change is configured, ensure that the
 	 * address gets programmed. If the driver does not support
 	 * changing the public address, fail the power on procedure.
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 90eabcae3ed2..c7e5d4651021 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -441,10 +441,22 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static __le32 get_missing_options(struct hci_dev *hdev)
+{
+	u32 options = 0;
+
+	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
+	    !bacmp(&hdev->public_addr, BDADDR_ANY))
+		options |= MGMT_OPTION_PUBLIC_ADDRESS;
+
+	return cpu_to_le32(options);
+}
+
 static int read_config_info(struct sock *sk, struct hci_dev *hdev,
 			    void *data, u16 data_len)
 {
 	struct mgmt_rp_read_config_info rp;
+	u32 options = 0;
 
 	BT_DBG("sock %p %s", sk, hdev->name);
 
@@ -452,11 +464,12 @@ static int read_config_info(struct sock *sk, struct hci_dev *hdev,
 
 	memset(&rp, 0, sizeof(rp));
 	rp.manufacturer = cpu_to_le16(hdev->manufacturer);
+
 	if (hdev->set_bdaddr)
-		rp.supported_options = cpu_to_le32(MGMT_OPTION_PUBLIC_ADDRESS);
-	else
-		rp.supported_options = cpu_to_le32(0);
-	rp.missing_options = cpu_to_le32(0);
+		options |= MGMT_OPTION_PUBLIC_ADDRESS;
+
+	rp.supported_options = cpu_to_le32(options);
+	rp.missing_options = get_missing_options(hdev);
 
 	hci_dev_unlock(hdev);
 
-- 
1.9.3

