Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 5/5] Bluetooth: hci_uart: Add bcm_set_baudrate()
Date: Wed, 20 May 2015 17:46:10 +0200
Message-Id: <1432136770-13328-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
References: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add vendor specific command to change controller device speed.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index cede445..b4fd532 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
+#include <linux/tty.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -31,11 +32,55 @@
 #include "btbcm.h"
 #include "hci_uart.h"
 
+#define BCM43XX_CLOCK_48 1
+#define BCM43XX_CLOCK_24 2
+
 struct bcm_data {
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
 };
 
+struct hci_cp_bcm_set_speed {
+	__le16   dummy;
+	__le32   speed;
+} __packed;
+
+static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	struct hci_cp_bcm_set_speed param = { 0, cpu_to_le32(speed) };
+
+	if (speed > 3000000) {
+		u8 clock = BCM43XX_CLOCK_48;
+
+		BT_DBG("%s: Set Controller clock (%d)", hdev->name, clock);
+
+		skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			BT_ERR("%s: failed to write update clock command (%ld)",
+			       hdev->name, PTR_ERR(skb));
+			return PTR_ERR(skb);
+		}
+
+		kfree_skb(skb);
+	}
+
+	BT_DBG("%s: Set Controller UART speed to %d bit/s", hdev->name, speed);
+
+	skb = __hci_cmd_sync(hdev, 0xfc18, sizeof(param), &param,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: failed to write update baudrate command (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static int bcm_open(struct hci_uart *hu)
 {
 	struct bcm_data *bcm;
@@ -98,6 +143,14 @@ static int bcm_setup(struct hci_uart *hu)
 	if (hu->proto->init_speed)
 		hci_uart_set_baudrate(hu, hu->proto->init_speed);
 
+	if (hu->proto->oper_speed) {
+		err = bcm_set_baudrate(hu, hu->proto->oper_speed);
+		if (!err)
+			/* hci_uart_set_baudrate() has no return value as
+			   tty_set_termios() return is always 0 */
+			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
+	}
+
 	err = btbcm_finalize(hu->hdev);
 
 	return err;
@@ -150,10 +203,13 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 static const struct hci_uart_proto bcm_proto = {
 	.id		= HCI_UART_BCM,
 	.name		= "BCM",
+	.init_speed	= 115200,
+	.oper_speed	= 4000000,
 	.open		= bcm_open,
 	.close		= bcm_close,
 	.flush		= bcm_flush,
 	.setup		= bcm_setup,
+	.set_baudrate	= bcm_set_baudrate,
 	.recv		= bcm_recv,
 	.enqueue	= bcm_enqueue,
 	.dequeue	= bcm_dequeue,
-- 
1.9.1

