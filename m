Return-Path: <mid@gtmp.org>
Message-ID: <3F4F70B1.20200@gtmp.org>
Date: Fri, 29 Aug 2003 17:26:41 +0200
From: "Alexandre Jousset@NL" <mid@gtmp.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Belkin F8T002 PC Card problem with Bluez
References: <3F4F6BF2.6080303@gtmp.org> <1062170277.27784.138.camel@pegasus>
In-Reply-To: <1062170277.27784.138.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

	Hi Marcel,

Marcel Holtmann wrote:
> try "hciattach /dev/ttyS4 bcsp".

	I tried this and it says, after some seconds : "BCSP initialization 
timed out".

> Send the patch (diff -urN) to the mailing list.

	Sorry I forgot this. I found the patch on 
"http://www.ussg.iu.edu/hypermail/linux/kernel/0203.0/0040.html".

and it is :

---------------------------------------
diff -ruN linux/drivers/char/serial.c linux-new/drivers/char/serial.c
--- linux/drivers/char/serial.c Fri Dec 21 18:41:54 2001
+++ linux-new/drivers/char/serial.c Fri Mar 1 09:43:42 2002
@@ -4658,6 +4658,9 @@
         { PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
                 PCI_ANY_ID, PCI_ANY_ID, 0, 0,
                 pbn_b0_2_115200 },
+ { PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_OXCB950,
+ PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+ pbn_b0_bt_1_115200 },

         /* Digitan DS560-558, from jimd@esoft.com */
         { PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
diff -ruN linux/include/linux/pci_ids.h linux-new/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h Fri Dec 21 18:42:03 2001
+++ linux-new/include/linux/pci_ids.h Fri Mar 1 09:43:52 2002
@@ -1458,6 +1458,7 @@
  #define PCI_DEVICE_ID_OXSEMI_12PCI840 0x8403
  #define PCI_DEVICE_ID_OXSEMI_16PCI954 0x9501
  #define PCI_DEVICE_ID_OXSEMI_16PCI952 0x950A
+#define PCI_DEVICE_ID_OXSEMI_OXCB950 0x950B
  #define PCI_DEVICE_ID_OXSEMI_16PCI95N 0x9511
  #define PCI_DEVICE_ID_OXSEMI_16PCI954PP 0x9513
---------------------------------------

	I applied the patch by hand since I have kernel 2.4.22 and not 2.4.17 
and after this I had the new ttyS4 device.
-- 
    \^/   Cordialement/Regards,
  -/ O \----------------------------------------
| |/ \|       Alexandre (Midnite) Jousset      |
  -|___|----------------------------------------
