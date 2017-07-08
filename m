Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sebastian.reichel@collabora.co.uk,
	marcel@holtmann.org,
	ohad@bencohen.org
Subject: [PATCH 4/4] bluetooth: Add HCI_QUIRK_INVALID_BDADDR for BCM43430A0
Date: Sat,  8 Jul 2017 17:12:28 +0100
Message-Id: <20170708161228.24324-4-ian@mnementh.co.uk>
In-Reply-To: <20170708161228.24324-1-ian@mnementh.co.uk>
References: <20170708161228.24324-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the default BDADDR for Broadcom BCM43430A0
Bluetooth devices.
---
 drivers/bluetooth/btbcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 9ab6cfbb831d..28eac429a2ab 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -35,6 +35,7 @@
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
 #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
+#define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xf8, 0x1a, 0x08, 0xca, 0x25, 0x00}})
 
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
@@ -70,10 +71,14 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	 *
 	 * The address 43:30:B1:00:00:00 indicates a BCM4330B1 controller
 	 * with waiting for configuration state.
+	 *
+	 * The address 00:25:CA:08:1A:F8 indicates a BCM43430A0 controller
+	 * with no configured address.
 	 */
 	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
-	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1)) {
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0)) {
 		BT_INFO("%s: BCM: Using default device address (%pMR)",
 			hdev->name, &bda->bdaddr);
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-- 
2.11.0
