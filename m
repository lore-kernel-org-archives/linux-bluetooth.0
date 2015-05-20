Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 3/5] Bluetooth: btbcm: Add helper functions for UART setup
Date: Wed, 20 May 2015 17:46:08 +0200
Message-Id: <1432136770-13328-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
References: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Firmware loading may reset the controller UART speed and needs to set
host UART speed back to init speed.

UART drivers setup is split in 3 parts:
- btbcm_initialize() resets the controller and returns the firmware
  name based on controller revision and sub_version.
- btbtcm_patchram() (already existing and public), which takes the
  firmware name as parameter, requests the firmware and loads it to
  the controller.
- btbcm_finalize() which resets the controller, reads local version
  and checks if the controller address is a default one or not.

Remove firmware name retrieval for UART controllers from
btbcm_setup_patchram().

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btbcm.c | 101 ++++++++++++++++++++++++++++++++++++++++------
 drivers/bluetooth/btbcm.h |  14 +++++++
 2 files changed, 103 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index acb9171..3e3250c 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -248,6 +248,95 @@ static const struct {
 	{ }
 };
 
+int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
+{
+	u16 subver, rev;
+	const char *hw_name = NULL;
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *ver;
+	int i, err;
+
+	/* Reset */
+	err = btbcm_reset(hdev);
+	if (err)
+		return err;
+
+	/* Read Local Version Info */
+	skb = btbcm_read_local_version(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ver = (struct hci_rp_read_local_version *)skb->data;
+	rev = le16_to_cpu(ver->hci_rev);
+	subver = le16_to_cpu(ver->lmp_subver);
+	kfree_skb(skb);
+
+	/* Read Verbose Config Version Info */
+	skb = btbcm_read_verbose_config(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
+	kfree_skb(skb);
+
+	switch ((rev & 0xf000) >> 12) {
+	case 0:
+	case 3:
+		for (i = 0; bcm_uart_subver_table[i].name; i++) {
+			if (subver == bcm_uart_subver_table[i].subver) {
+				hw_name = bcm_uart_subver_table[i].name;
+				break;
+			}
+		}
+
+		snprintf(fw_name, len, "brcm/%s.hcd", hw_name ? : "BCM");
+		break;
+	default:
+		return 0;
+	}
+
+	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
+		hw_name ? : "BCM", (subver & 0x7000) >> 13,
+		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_initialize);
+
+int btbcm_finalize(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *ver;
+	u16 subver, rev;
+	int err;
+
+	/* Reset */
+	err = btbcm_reset(hdev);
+	if (err)
+		return err;
+
+	/* Read Local Version Info */
+	skb = btbcm_read_local_version(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ver = (struct hci_rp_read_local_version *)skb->data;
+	rev = le16_to_cpu(ver->hci_rev);
+	subver = le16_to_cpu(ver->lmp_subver);
+	kfree_skb(skb);
+
+	BT_INFO("%s: BCM (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
+		(subver & 0x7000) >> 13, (subver & 0x1f00) >> 8,
+		(subver & 0x00ff), rev & 0x0fff);
+
+	btbcm_check_bdaddr(hdev);
+
+	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_finalize);
+
 static const struct {
 	u16 subver;
 	const char *name;
@@ -298,18 +387,6 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	kfree_skb(skb);
 
 	switch ((rev & 0xf000) >> 12) {
-	case 0:
-	case 3:
-		for (i = 0; bcm_uart_subver_table[i].name; i++) {
-			if (subver == bcm_uart_subver_table[i].subver) {
-				hw_name = bcm_uart_subver_table[i].name;
-				break;
-			}
-		}
-
-		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
-			 hw_name ? : "BCM");
-		break;
 	case 1:
 	case 2:
 		/* Read USB Product Info */
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index eb6ab5f..3c35a06 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -30,6 +30,9 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware);
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
 
+int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len);
+int btbcm_finalize(struct hci_dev *hdev);
+
 #else
 
 static inline int btbcm_check_bdaddr(struct hci_dev *hdev)
@@ -57,4 +60,15 @@ static inline int btbcm_setup_apple(struct hci_dev *hdev)
 	return 0;
 }
 
+static inline int btbcm_initialize(struct hci_dev *hdev, char *fw_name,
+				   size_t len)
+{
+	return 0;
+}
+
+static inline int btbcm_finalize(struct hci_dev *hdev)
+{
+	return 0;
+}
+
 #endif
-- 
1.9.1

