Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] bluetooth: hci_ll: add constant for vendor-specific command
Date: Sun,  3 Dec 2017 21:21:21 -0600
Message-Id: <1512357682-8911-3-git-send-email-david@lechnology.com>
In-Reply-To: <1512357682-8911-1-git-send-email-david@lechnology.com>
References: <1512357682-8911-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a #define for the vendor-specific HCI command to set the
baudrate instead of using the bare 0xff36 multiple times.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/bluetooth/hci_ll.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 447abea..974a788 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -56,6 +56,9 @@
 
 #include "hci_uart.h"
 
+/* Vendor-specific HCI commands */
+#define HCI_VS_UPDATE_UART_HCI_BAUDRATE		0xff36
+
 /* HCILL commands */
 #define HCILL_GO_TO_SLEEP_IND	0x30
 #define HCILL_GO_TO_SLEEP_ACK	0x31
@@ -620,7 +623,7 @@ static int download_firmware(struct ll_device *lldev)
 		case ACTION_SEND_COMMAND:	/* action send */
 			bt_dev_dbg(lldev->hu.hdev, "S");
 			cmd = (struct hci_command *)action_ptr;
-			if (cmd->opcode == 0xff36) {
+			if (cmd->opcode == HCI_VS_UPDATE_UART_HCI_BAUDRATE) {
 				/* ignore remote change
 				 * baud rate HCI VS command
 				 */
@@ -704,7 +707,10 @@ static int ll_setup(struct hci_uart *hu)
 		speed = 0;
 
 	if (speed) {
-		struct sk_buff *skb = __hci_cmd_sync(hu->hdev, 0xff36, sizeof(speed), &speed, HCI_INIT_TIMEOUT);
+		struct sk_buff *skb;
+
+		skb = __hci_cmd_sync(hu->hdev, HCI_VS_UPDATE_UART_HCI_BAUDRATE,
+				     sizeof(speed), &speed, HCI_INIT_TIMEOUT);
 		if (!IS_ERR(skb)) {
 			kfree_skb(skb);
 			serdev_device_set_baudrate(serdev, speed);
-- 
2.7.4
