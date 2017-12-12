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
Subject: [PATCH v3 1/3] Bluetooth: hci_ll: add support for setting public address
Date: Tue, 12 Dec 2017 15:59:16 -0600
Message-Id: <1513115958-23761-2-git-send-email-david@lechnology.com>
In-Reply-To: <1513115958-23761-1-git-send-email-david@lechnology.com>
References: <1513115958-23761-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for setting the public address on Texas Instruments
Bluetooth chips using a vendor-specific command.

This has been tested on a CC2560A chip. The TI wiki also indicates that
this command should work on TI WL17xx/WL18xx Bluetooth chips.

During review, there was some question as to the correctness of the byte
swapping since TI's documentation is not clear on this matter. This can
be tested with the btmgmt utility from bluez. The adapter must be powered
off to change the address. If the baswap() is omitted, address is reversed.

In case there is a issue in the future, here is the output of btmon during
the command `btmgmt public-addr 00:11:22:33:44:55`:

Bluetooth monitor ver 5.43
= Note: Linux version 4.15.0-rc2-08561-gcb132a1-dirty (armv5tejl)      0.707043
= Note: Bluetooth subsystem version 2.22                               0.707091
= New Index: 00:17:E7:BD:1C:8E (Primary,UART,hci0)              [hci0] 0.707106
@ MGMT Open: btmgmt (privileged) version 1.14                 {0x0002} 0.707124
@ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.707137
@ MGMT Open: btmon (privileged) version 1.14                  {0x0003} 0.707540
@ MGMT Command: Set Public Address (0x0039) plen 6    {0x0002} [hci0] 11.167991
        Address: 00:11:22:33:44:55 (CIMSYS Inc)
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0002} [hci0] 11.175681
      Set Public Address (0x0039) plen 4
        Status: Success (0x00)
        Missing options: 0x00000000
@ MGMT Event: Index Removed (0x0005) plen 0           {0x0003} [hci0] 11.175757
@ MGMT Event: Index Removed (0x0005) plen 0           {0x0002} [hci0] 11.175757
@ MGMT Event: Index Removed (0x0005) plen 0           {0x0001} [hci0] 11.175757
= Open Index: 00:17:E7:BD:1C:8E                                [hci0] 11.176807
< HCI Command: Vendor (0x3f|0x0006) plen 6                     [hci0] 11.176975
        00 11 22 33 44 55                                .."3DU
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 11.188260
      Vendor (0x3f|0x0006) ncmd 1
        Status: Success (0x00)
...
< HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0  [hci0] 11.189859
> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 11.190732
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 2.1 (0x04) - Revision 0 (0x0000)
        LMP version: Bluetooth 2.1 (0x04) - Subversion 6431 (0x191f)
        Manufacturer: Texas Instruments Inc. (13)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0               [hci0] 11.191027
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 11.192101
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:11:22:33:44:55 (CIMSYS Inc)
...

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/bluetooth/hci_ll.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index efcfbe9..c948e8d 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -57,6 +57,7 @@
 #include "hci_uart.h"
 
 /* Vendor-specific HCI commands */
+#define HCI_VS_WRITE_BD_ADDR			0xfc06
 #define HCI_VS_UPDATE_UART_HCI_BAUDRATE		0xff36
 
 /* HCILL commands */
@@ -662,6 +663,24 @@ static int download_firmware(struct ll_device *lldev)
 	return err;
 }
 
+static int ll_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	bdaddr_t bdaddr_swapped;
+	struct sk_buff *skb;
+
+	/* HCI_VS_WRITE_BD_ADDR (at least on a CC2560A chip) expects the BD
+	 * address to be MSB first, but bdaddr_t has the convention of being
+	 * LSB first.
+	 */
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
@@ -674,6 +693,8 @@ static int ll_setup(struct hci_uart *hu)
 
 	lldev = serdev_device_get_drvdata(serdev);
 
+	hu->hdev->set_bdaddr = ll_set_bdaddr;
+
 	serdev_device_set_flow_control(serdev, true);
 
 	do {
-- 
2.7.4
