Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_ll: Add endianness conversion when setting baudrate
Date: Thu,  7 Dec 2017 20:22:19 -0600
Message-Id: <1512699739-22162-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds an endianness conversion when setting the baudrate using a
vendor-specific command. Otherwise, bad things might happen on a big-
endian system.

Suggested-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/bluetooth/hci_ll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 944cdd2..486b4ea 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -739,10 +739,12 @@ static int ll_setup(struct hci_uart *hu)
 		speed = 0;
 
 	if (speed) {
+		__le32 speed_le = cpu_to_le32(speed);
 		struct sk_buff *skb;
 
 		skb = __hci_cmd_sync(hu->hdev, HCI_VS_UPDATE_UART_HCI_BAUDRATE,
-				     sizeof(speed), &speed, HCI_INIT_TIMEOUT);
+				     sizeof(speed_le), &speed_le,
+				     HCI_INIT_TIMEOUT);
 		if (!IS_ERR(skb)) {
 			kfree_skb(skb);
 			serdev_device_set_baudrate(serdev, speed);
-- 
2.7.4
