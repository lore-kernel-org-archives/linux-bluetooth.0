Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btbcm: Add BCM4330B1 UART device
Date: Mon, 27 Jul 2015 18:02:25 +0200
Message-Id: <1438012945-9549-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add "waiting for configuration" address.
Add lmp_subver and firmware name for BCM4330B1 controller.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btbcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 9ceb8ac..02ed816 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -34,6 +34,7 @@
 
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
 #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
+#define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
 
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
@@ -66,9 +67,13 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	 *
 	 * The address 43:24:B3:00:00:00 indicates a BCM4324B3 controller
 	 * with waiting for configuration state.
+	 *
+	 * The address 43:30:B1:00:00:00 indicates a BCM4330B1 controller
+	 * with waiting for configuration state.
 	 */
 	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
-	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3)) {
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1)) {
 		BT_INFO("%s: BCM: Using default device address (%pMR)",
 			hdev->name, &bda->bdaddr);
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
@@ -241,6 +246,7 @@ static const struct {
 	u16 subver;
 	const char *name;
 } bcm_uart_subver_table[] = {
+	{ 0x4103, "BCM4330B1"	},	/* 002.001.003 */
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
-- 
1.9.1

