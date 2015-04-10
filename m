Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: btbcm: Add BCM4324B3 UART device
Date: Fri, 10 Apr 2015 15:37:40 +0200
Message-Id: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btbcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d0741f3..47e0563 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -33,6 +33,7 @@
 #define VERSION "0.1"
 
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
+#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
@@ -69,6 +70,10 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 		BT_INFO("%s: BCM: Using default device address (%pMR)",
 			hdev->name, &bda->bdaddr);
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	} else if (!bacmp(&bda->bdaddr, BDADDR_BCM4324B3)) {
+		BT_INFO("%s: BCM: Using default device address (%pMR)",
+			hdev->name, &bda->bdaddr);
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
 	}
 
 	kfree_skb(skb);
@@ -176,6 +181,7 @@ static const struct {
 	const char *name;
 } bcm_uart_subver_table[] = {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
+	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ }
 };
 
@@ -234,6 +240,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
+	case 3:
 		for (i = 0; bcm_uart_subver_table[i].name; i++) {
 			if (subver == bcm_uart_subver_table[i].subver) {
 				hw_name = bcm_uart_subver_table[i].name;
-- 
1.9.1

