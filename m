Return-Path: <cyrus@holtmann.org>
From: Eugene Shatokhin <eugene.shatokhin@rosalab.ru>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Andrey Ponomarenko <aponomarenko@rosalab.ru>,
	linux-kernel@vger.kernel.org,
	Eugene Shatokhin <eugene.shatokhin@rosalab.ru>
Subject: [PATCH] Bluetooth: btusb: Add a quirk for BCM43142A0 (105b:e065)
Date: Tue, 19 May 2015 20:36:25 +0300
Message-Id: <1432056985-30040-1-git-send-email-eugene.shatokhin@rosalab.ru>
List-ID: <linux-bluetooth.vger.kernel.org>

USB Bluetooth module by Foxconn International, Inc. (USB IDs: 105b:e065)
is based on BCM43142A0 chip by Broadcom. This module can be found, for
example, in Lenovo B590 and a few other laptops.

This device requires firmware update to be operational, so this patch
adds a quirk for it.

With the firmware properly converted and placed:
Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=0000 lmp_ver=06
lmp_subver=210b
Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=00ac lmp_ver=06
lmp_subver=210b

>From the output of usb-devices:
T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=105b ProdID=e065 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM43142A0
S:  SerialNumber=F82FA8FAFEBA
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Tested on Lenovo B590 with kernel 4.0.1 and 4.0.3, x86_64.

Signed-off-by: Eugene Shatokhin <eugene.shatokhin@rosalab.ru>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d21f3b4..ed3c72a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -120,6 +120,9 @@ static const struct usb_device_id btusb_table[] = {
 	/* Broadcom BCM20702B0 (Dynex/Insignia) */
 	{ USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
 
+	/* Broadcom BCM43142A0 (Foxconn) */
+	{ USB_DEVICE(0x105b, 0xe065), .driver_info = BTUSB_BCM_PATCHRAM },
+
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
 	  .driver_info = BTUSB_BCM_PATCHRAM },
-- 
2.3.2
