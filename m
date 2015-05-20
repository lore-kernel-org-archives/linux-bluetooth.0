Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 1/5] Bluetooth: btbcm: Add BCM4324B3 UART device
Date: Wed, 20 May 2015 17:46:06 +0200
Message-Id: <1432136770-13328-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
References: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add "waiting for configuration" address.
Add lmp_subver and firmware name for BCM4324B3 controller.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btbcm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 728fce3..acb9171 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -33,6 +33,7 @@
 #define VERSION "0.1"
 
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
+#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
@@ -56,10 +57,11 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
 
-	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
-	 * with no configured address.
+	/* Check if the address indicates a controller with no configured
+	 * address.
 	 */
-	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0)) {
+	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3)) {
 		BT_INFO("%s: BCM: Using default device address (%pMR)",
 			hdev->name, &bda->bdaddr);
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
@@ -242,6 +244,7 @@ static const struct {
 	const char *name;
 } bcm_uart_subver_table[] = {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
+	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ }
 };
 
@@ -296,6 +299,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
+	case 3:
 		for (i = 0; bcm_uart_subver_table[i].name; i++) {
 			if (subver == bcm_uart_subver_table[i].subver) {
 				hw_name = bcm_uart_subver_table[i].name;
-- 
1.9.1

