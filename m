Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <403137F9.1050108@yahoo.com>
From: "Todd E. Johnson" <tejohnson@yahoo.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net, linux-usb-users@lists.sourceforge.net,
   maxk@qualcomm.com
References: <402E2E29.7040207@yahoo.com> <1076769794.14758.2.camel@pegasus>	 <402E4E02.9020600@yahoo.com> <1076851622.14758.22.camel@pegasus> <402F99AC.7020500@yahoo.com>
In-Reply-To: <402F99AC.7020500@yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------090500050406070108090209"
Subject: [Bluez-users] 2.6.2 errors with DBT-120 (B2)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 16 Feb 2004 16:36:57 -0500

This is a multi-part message in MIME format.
--------------090500050406070108090209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I have been attempting to get SCO over HCI to work... I have a D-Link 
DBT-120 (B2).  When I startup hcid, I was getting the following error 
message:

hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb de96e614 err -90
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb de96e614 err -90

It appears this occurs since the hci_usb driver is picking a bogus 
endpoint with a wMaxPacketSize = 0 when submitting the urb.

Attached are a few files for assistance:

hciconfig.txt                          'hciconfig -a'
lsusb.txt                                'lsusb -v'
hci_usb_sco_debug.log.gz     Debug logs from /var/log/messages
patch-2.6.2-tj1.gz                  a patch

The attached patch includes patch-2.4.24-mh2, a fix for the error, and a 
few minor fixes so the kernel can build when debugging is enabled...

This does not fix SCO support, It simply assists in getting an endpoint 
where wMaxPacketSize != 0.

Here is the critical part, or what eliminates -90:

<patch>

diff --unified --recursive --new-file linux-2.6.2/drivers/bluetooth/hci_usb.c linux-2.6.2-tj/drivers/bluetooth/hci_usb.c
--- linux-2.6.2/drivers/bluetooth/hci_usb.c	2004-02-03 22:44:43.000000000 -0500
+++ linux-2.6.2-tj/drivers/bluetooth/hci_usb.c	2004-02-16 13:15:11.000000000 -0500

@@ -833,7 +834,7 @@
 
 #ifdef CONFIG_BT_HCIUSB_SCO
 				case USB_ENDPOINT_XFER_ISOC:
-					if (ep->desc.wMaxPacketSize < size || a > 2)
+					if (ep->desc.wMaxPacketSize <= size)
 						break;
 					size = ep->desc.wMaxPacketSize;

</patch>

Now that the error is gone, SCO still is not working.  Since I enabled 
debugging with this patch, I was able to capture additional data to 
assist someone whom knows much more than I in fixing the SCO over HCI_USB.

If I'm completely clueless, please disregard, and sorry to waste your 
time! Thanks in advance!

        Regards,

        Todd E. Johnson

--------------090500050406070108090209
Content-Type: text/plain;
 name="hciconfig.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hciconfig.txt"

hci0:	Type: USB
	BD Address: 00:80:C8:1F:B0:1F ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:1942 acl:36 sco:0 events:62 errors:0
	TX bytes:889 acl:25 sco:0 commands:23 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x700408
	Service Classes: Object Transfer, Audio, Telephony
	Device Class: Audio/Video, Hands-free
	HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
	Manufacturer: Cambridge Silicon Radio (10)


--------------090500050406070108090209
Content-Type: text/plain;
 name="lsusb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsusb.txt"


Bus 002 Device 002: ID 0a12:0001 Cambridge Silicon Radio Ltd. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 
  bDeviceSubClass         1 
  bDeviceProtocol         1 
  bMaxPacketSize0        64
  idVendor           0x0a12 Cambridge Silicon Radio Ltd.
  idProduct          0x0001 
  bcdDevice            4.43
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          193
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         16
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          0
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          0
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          9
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          9
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         17
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         17
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         25
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         25
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         33
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         33
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 
      bInterfaceSubClass      1 
      bInterfaceProtocol      1 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         49
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         49
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 
      bInterfaceSubClass      1 
      bInterfaceProtocol      0 
      iInterface              0 
  unknown descriptor type: 07 21 07 88 13 ff 03
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.2-mh2 ohci_hcd
  iProduct                2 OHCI Host Controller
  iSerial                 1 0000:00:01.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.2-mh2 ohci_hcd
  iProduct                2 OHCI Host Controller
  iSerial                 1 0000:00:01.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

--------------090500050406070108090209
Content-Type: application/x-gzip;
 name="hci_usb_sco_debug.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hci_usb_sco_debug.log.gz"

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
7ac+7uMXNv0f9dDPn+6BBgA=
--------------090500050406070108090209
Content-Type: application/x-gzip;
 name="patch-2.6.2-tj1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch-2.6.2-tj1.gz"

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
kFE1LaayyGWtGjPd6fg/S8Fu6i0/AAA=
--------------090500050406070108090209--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
