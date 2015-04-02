Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/5] Bluetooth: hci_uart: Add BCM specific UART speed management
Date: Thu,  2 Apr 2015 16:37:36 +0200
Message-Id: <1427985456-31536-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com>
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to setup the final speed for UART communication.
This also allows to load firmware at final speed.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 111 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 7cec648..7501732 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -11,6 +11,7 @@
 */
 
 #include <linux/kernel.h>
+#include <linux/tty.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
 #include <linux/firmware.h>
@@ -20,6 +21,9 @@
 
 #include "hci_uart.h"
 
+#define BCM43XX_CLOCK_48 1
+#define BCM43XX_CLOCK_24 2
+
 static int hci_bcm_reset(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -113,6 +117,87 @@ static int hci_bcm_read_local_version(struct hci_uart *hu, char *name,
 	return 0;
 }
 
+static int hci_bcm_set_clock(struct hci_uart *hu, unsigned char clock)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+
+	BT_DBG("%s: Set Controller clock (%d)", hdev->name, clock);
+
+	skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: failed to write update clock command (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->data[0]) {
+		u8 evt_status = skb->data[0];
+
+		BT_ERR("%s: write update clock event failed (%02x)",
+		       hdev->name, evt_status);
+		kfree_skb(skb);
+		return -bt_to_errno(evt_status);
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int hci_bcm_set_speed(struct hci_uart *hu, uint32_t speed)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	unsigned char param[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	struct ktermios ktermios;
+
+	if (speed > 3000000 && hci_bcm_set_clock(hu, BCM43XX_CLOCK_48))
+		return -EINVAL;
+
+	param[2] = (uint8_t) (speed);
+	param[3] = (uint8_t) (speed >> 8);
+	param[4] = (uint8_t) (speed >> 16);
+	param[5] = (uint8_t) (speed >> 24);
+
+	BT_DBG("%s: Set Controller UART speed to %d bit/s", hdev->name, speed);
+
+	skb = __hci_cmd_sync(hdev, 0xfc18, sizeof(param), param,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: failed to write update baudrate command (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->data[0]) {
+		u8 evt_status = skb->data[0];
+
+		BT_ERR("%s: write update baudrate event failed (%02x)",
+		       hdev->name, evt_status);
+		kfree_skb(skb);
+		return -bt_to_errno(evt_status);
+	}
+
+	kfree_skb(skb);
+
+	if (!hu->tty) {
+		BT_ERR("%s: Can't set host baud rate", hdev->name);
+		return -EIO;
+	}
+
+	ktermios = hu->tty->termios;
+	ktermios.c_cflag &= ~CBAUD;
+	ktermios.c_cflag |= BOTHER;
+	tty_termios_encode_baud_rate(&ktermios, speed, speed);
+
+	tty_set_termios(hu->tty, &ktermios);
+
+	BT_DBG("%s: New tty speed: %d", hdev->name, hu->tty->termios.c_ispeed);
+
+	return 0;
+}
+
 static const struct firmware *hci_bcm_get_fw(struct hci_uart *hu,
 						const char *fwname)
 {
@@ -223,15 +308,41 @@ int hci_bcm_setup(struct hci_uart *hu)
 
 	fw = hci_bcm_get_fw(hu, fwname);
 	if (fw) {
+		struct ktermios ktermios;
+		speed_t init_speed = hu->tty->termios.c_ispeed;
+
+		BT_DBG("%s: tty speed: %d",
+		       hu->hdev->name, hu->tty->termios.c_ispeed);
+
+		if (hu->speed) {
+			err = hci_bcm_set_speed(hu, hu->speed);
+			if (err)
+				goto failed;
+		}
+
 		err = hci_bcm_load_firmware(hu, fw);
 		if (err)
 			goto failed;
 
+		/* Controller speed has been reset to default speed */
+		if (hu->speed) {
+			ktermios = hu->tty->termios;
+			tty_termios_encode_baud_rate(&ktermios, init_speed,
+						     init_speed);
+			tty_set_termios(hu->tty, &ktermios);
+
+			BT_DBG("%s: New tty speed: %d",
+			       hu->hdev->name, hu->tty->termios.c_ispeed);
+		}
+
 		err = hci_bcm_reset(hu);
 		if (err)
 			goto failed;
 	}
 
+	if (hu->speed)
+		err = hci_bcm_set_speed(hu, hu->speed);
+
 failed:
 	if (fw)
 		release_firmware(fw);
-- 
1.9.1

