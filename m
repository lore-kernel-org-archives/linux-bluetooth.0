Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Deal with USB devices that are faking CSR vendor
Date: Fri,  3 Jan 2014 03:02:36 -0800
Message-Id: <1388746956-9944-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There exists a set of Bluetooth USB devices that show up on the USB
bus as 0a12:0001 and identify themselves as devices from CSR. However
they are not. When sending Read Local Version command they now have
a split personality and say they are from Broadcom.

  < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
  > HCI Event: Command Complete (0x0e) plen 12
      Read Local Version Information (0x04|0x0001) ncmd 1
      status 0x00
      HCI Version: 2.0 (0x3) HCI Revision: 0x3000
      LMP Version: 2.0 (0x3) LMP Subversion: 0x420b
      Manufacturer: Broadcom Corporation (15)

The assumption is that they are neither CSR nor Broadcom based devices
and that they are designed and manufactured by someone else.

For the most parts they follow the Bluetooth HCI specification and
can be used as standard Bluetooth devices. However they have the
minor problem that the Delete Stored Link Key command is not working
as it should.

During the Bluetooth controller setup, this command is needed if
stored link keys are supported. For these devices it has to be
assumed that this is broken and so just set a quirk to clearly
indicate the behavior. After that the setup can just proceed.

Now the trick part is to detect these faulty devices since we do
not want to punish all CSR and all Broadcom devices. The original
devices do actually work according to the specification.

What is known so far is that these broken devices set the USB bcdDevice
revision information to 1.0 or less.

T:  Bus=02 Lev=01 Prnt=01 Port=08 Cnt=03 Dev#=  9 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev= 1.00
S:  Manufacturer=Bluetooth v2.0
S:  Product=Bluetooth V2.0 Dongle

T:  Bus=05 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev= 0.07

In case of CSR devices, the bcdDevice revision contains the firmware
build ID and that is normally a higher value. If the bcdDevice revision
is 1.0 or less, then an extra setup stage is checking if Read Local
Version returns CSR manufacturer information. If not then it will be
assumed that this is a broken device and the Delete Stored Link Key
command will be marked as broken.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bfbcc5a772a6..e7b36beca42c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -964,6 +964,45 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btusb_setup_csr(struct hci_dev *hdev)
+{
+	struct hci_rp_read_local_version *rp;
+	struct sk_buff *skb;
+	int ret;
+
+	BT_DBG("%s", hdev->name);
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("Reading local version failed (%ld)", -PTR_ERR(skb));
+		return -PTR_ERR(skb);
+	}
+
+	rp = (struct hci_rp_read_local_version *) skb->data;
+
+	if (!rp->status) {
+		if (le16_to_cpu(rp->manufacturer) != 10) {
+			/* Clear the reset quirk since this is not an actual
+			 * early Bluetooth 1.1 device from CSR.
+			 */
+			clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
+
+			/* These fake CSR controllers have all a broken
+			 * stored link key handling and so just disable it.
+			 */
+			set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY,
+				&hdev->quirks);
+		}
+	}
+
+	ret = -bt_to_errno(rp->status);
+
+	kfree_skb(skb);
+
+	return ret;
+}
+
 struct intel_version {
 	u8 status;
 	u8 hw_platform;
@@ -1464,10 +1503,15 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_CSR) {
 		struct usb_device *udev = data->udev;
+		u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
 
 		/* Old firmware would otherwise execute USB reset */
-		if (le16_to_cpu(udev->descriptor.bcdDevice) < 0x117)
+		if (bcdDevice < 0x117)
 			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
+
+		/* Fake CSR devices with broken commands */
+		if (bcdDevice <= 0x100)
+			hdev->setup = btusb_setup_csr;
 	}
 
 	if (id->driver_info & BTUSB_SNIFFER) {
-- 
1.8.4.2

