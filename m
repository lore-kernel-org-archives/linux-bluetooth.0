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
Subject: [PATCH v2 1/3] Bluetooth: hci_ll: add support for setting public address
Date: Thu,  7 Dec 2017 20:57:38 -0600
Message-Id: <1512701860-8321-2-git-send-email-david@lechnology.com>
In-Reply-To: <1512701860-8321-1-git-send-email-david@lechnology.com>
References: <1512701860-8321-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for setting the public address on Texas Instruments
Bluetooth chips using a vendor-specific command.

This has been tested on a CC2560A. The TI wiki also indicates that this
command should work on TI WL17xx/WL18xx Bluetooth chips.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes:
* This is a new patch in v2

 drivers/bluetooth/hci_ll.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 974a788..b732004 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -57,6 +57,7 @@
 #include "hci_uart.h"
 
 /* Vendor-specific HCI commands */
+#define HCI_VS_WRITE_BD_ADDR			0xfc06
 #define HCI_VS_UPDATE_UART_HCI_BAUDRATE		0xff36
 
 /* HCILL commands */
@@ -662,6 +663,20 @@ static int download_firmware(struct ll_device *lldev)
 	return err;
 }
 
+static int ll_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	bdaddr_t bdaddr_swapped;
+	struct sk_buff *skb;
+
+	baswap(&bdaddr_swapped, bdaddr);
+	skb = __hci_cmd_sync(hdev, HCI_VS_WRITE_BD_ADDR, sizeof(bdaddr_t),
+			     &bdaddr_swapped, HCI_INIT_TIMEOUT);
+	if (!IS_ERR(skb))
+		kfree_skb(skb);
+	
+	return PTR_ERR_OR_ZERO(skb);
+}
+
 static int ll_setup(struct hci_uart *hu)
 {
 	int err, retry = 3;
@@ -674,6 +689,8 @@ static int ll_setup(struct hci_uart *hu)
 
 	lldev = serdev_device_get_drvdata(serdev);
 
+	hu->hdev->set_bdaddr = ll_set_bdaddr;
+
 	serdev_device_set_flow_control(serdev, true);
 
 	do {
-- 
2.7.4
