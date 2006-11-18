Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: =?iso-8859-1?Q?H=E5kan_Lager?= <hakan@digiloo.net>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Sat, 18 Nov 2006 16:08:04 +0100
Message-ID: <011801c70b23$5be3b8c0$0200a8c0@BLACKBIRD>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0119_01C70B2B.BE055BF0"
In-Reply-To: <1163673121.5169.28.camel@localhost>
Subject: Re: [Bluez-users] VB:  Problem with 2nd second dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0119_01C70B2B.BE055BF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi,

Here is the result:

0)

$ ./hcid -n
hcid[205]: Bluetooth HCI daemon
Failed to open connection to system message bus: Failed to connect to =
socket
/var/run/dbus/system_bus_socket: No such file or directory

hcid[205]: Unable to get on D-BUS

1) $ insmod hci_usb.o isoc=3D0
Using /bluetooth/mod/hci_usb.o
insmod: invalid parameter isoc

2) See appended file=20
=20

-----Ursprungligt meddelande-----
Fr=E5n: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] F=F6r Marcel Holtmann
Skickat: den 16 november 2006 11:32
Till: BlueZ users
=C4mne: Re: [Bluez-users] VB: Problem with 2nd second dongle

Hi Hakan,

> I begin to suspect this is a dbus error. Is there any simple way to =
check
> this suspicion?

it can't be a D-Bus error. Please try to load the hci_usb driver with
isoc=3D0. What does "lsusb" actually tell you?

Regards

Marcel



-------------------------------------------------------------------------=

Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_NextPart_000_0119_01C70B2B.BE055BF0
Content-Type: application/octet-stream;
	name="lsusb"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lsusb"

=0A=
Bus 001 Device 001: ID 0000:0000 Virtual Hub=0A=
Device Descriptor:=0A=
  bLength                18=0A=
  bDescriptorType         1=0A=
  bcdUSB               1.10=0A=
  bDeviceClass            9 Hub=0A=
  bDeviceSubClass         0 =0A=
  bDeviceProtocol         0 =0A=
  bMaxPacketSize0         8=0A=
  idVendor           0x0000 Virtual=0A=
  idProduct          0x0000 Hub=0A=
  bcdDevice            0.00=0A=
  iManufacturer           0 =0A=
  iProduct                2 USB OHCI Root Hub=0A=
  iSerial                 1 e0020000=0A=
  bNumConfigurations      1=0A=
  Configuration Descriptor:=0A=
    bLength                 9=0A=
    bDescriptorType         2=0A=
    wTotalLength           25=0A=
    bNumInterfaces          1=0A=
    bConfigurationValue     1=0A=
    iConfiguration          0=0A=
    bmAttributes         0x40=0A=
      Self Powered=0A=
    MaxPower                0mA=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        0=0A=
      bAlternateSetting       0=0A=
      bNumEndpoints           1=0A=
      bInterfaceClass         9 Hub=0A=
      bInterfaceSubClass      0 =0A=
      bInterfaceProtocol      0 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x81  EP 1 IN=0A=
        bmAttributes            3=0A=
          Transfer Type            Interrupt=0A=
          Synch Type               none=0A=
        wMaxPacketSize          2=0A=
        bInterval             255=0A=
  Language IDs: (length=3D4)=0A=
     0000 (null)((null))=0A=
=0A=
Bus 001 Device 002: ID 0409:005a NEC Systems =0A=
  Language IDs: none (cannot get min. string descriptor; got len=3D-1, =
error=3D32:Broken pipe)=0A=
Device Descriptor:=0A=
  bLength                18=0A=
  bDescriptorType         1=0A=
  bcdUSB               2.00=0A=
  bDeviceClass            9 Hub=0A=
  bDeviceSubClass         0 =0A=
  bDeviceProtocol         0 =0A=
  bMaxPacketSize0        64=0A=
  idVendor           0x0409 NEC Systems=0A=
  idProduct          0x005a =0A=
  bcdDevice            1.00=0A=
  iManufacturer           0 =0A=
  iProduct                0 =0A=
  iSerial                 0 =0A=
  bNumConfigurations      1=0A=
  Configuration Descriptor:=0A=
    bLength                 9=0A=
    bDescriptorType         2=0A=
    wTotalLength           25=0A=
    bNumInterfaces          1=0A=
    bConfigurationValue     1=0A=
    iConfiguration          0=0A=
    bmAttributes         0xe0=0A=
      Self Powered=0A=
      Remote Wakeup=0A=
    MaxPower              100mA=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        0=0A=
      bAlternateSetting       0=0A=
      bNumEndpoints           1=0A=
      bInterfaceClass         9 Hub=0A=
      bInterfaceSubClass      0 =0A=
      bInterfaceProtocol      0 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x81  EP 1 IN=0A=
        bmAttributes            3=0A=
          Transfer Type            Interrupt=0A=
          Synch Type               none=0A=
        wMaxPacketSize          1=0A=
        bInterval             255=0A=
  Language IDs: none (cannot get min. string descriptor; got len=3D-1, =
error=3D32:Broken pipe)=0A=
=0A=
Bus 001 Device 009: ID 0a5c:200a Broadcom Corp. =0A=
Device Descriptor:=0A=
  bLength                18=0A=
  bDescriptorType         1=0A=
  bcdUSB               1.10=0A=
  bDeviceClass          224 =0A=
  bDeviceSubClass         1 =0A=
  bDeviceProtocol         1 =0A=
  bMaxPacketSize0        64=0A=
  idVendor           0x0a5c Broadcom Corp.=0A=
  idProduct          0x200a =0A=
  bcdDevice            0.01=0A=
  iManufacturer           1 Broadcom=0A=
  iProduct                2 BCM92035DGROM=0A=
  iSerial                 3 000EA13427B6=0A=
  bNumConfigurations      1=0A=
  Configuration Descriptor:=0A=
    bLength                 9=0A=
    bDescriptorType         2=0A=
    wTotalLength          200=0A=
    bNumInterfaces          3=0A=
    bConfigurationValue     1=0A=
    iConfiguration          0=0A=
    bmAttributes         0xa0=0A=
      Remote Wakeup=0A=
    MaxPower              100mA=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        0=0A=
      bAlternateSetting       0=0A=
      bNumEndpoints           3=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x81  EP 1 IN=0A=
        bmAttributes            3=0A=
          Transfer Type            Interrupt=0A=
          Synch Type               none=0A=
        wMaxPacketSize         16=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x82  EP 2 IN=0A=
        bmAttributes            2=0A=
          Transfer Type            Bulk=0A=
          Synch Type               none=0A=
        wMaxPacketSize         64=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x02  EP 2 OUT=0A=
        bmAttributes            2=0A=
          Transfer Type            Bulk=0A=
          Synch Type               none=0A=
        wMaxPacketSize         64=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       0=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize          0=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize          0=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       1=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize          9=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize          9=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       2=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         17=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         17=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       3=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         32=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         32=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       4=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         64=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         64=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       5=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         64=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         64=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        2=0A=
      bAlternateSetting       0=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       255 Vendor Specific Class=0A=
      bInterfaceSubClass    255 Vendor Specific Subclass=0A=
      bInterfaceProtocol    255 Vendor Specific Protocol=0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x84  EP 4 IN=0A=
        bmAttributes            2=0A=
          Transfer Type            Bulk=0A=
          Synch Type               none=0A=
        wMaxPacketSize         32=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x04  EP 4 OUT=0A=
        bmAttributes            2=0A=
          Transfer Type            Bulk=0A=
          Synch Type               none=0A=
        wMaxPacketSize         32=0A=
        bInterval               1=0A=
  Language IDs: (length=3D4)=0A=
     0409 English(US)=0A=
=0A=
Bus 001 Device 010: ID 0db0:6970  =0A=
Device Descriptor:=0A=
  bLength                18=0A=
  bDescriptorType         1=0A=
  bcdUSB               1.10=0A=
  bDeviceClass          224 =0A=
  bDeviceSubClass         1 =0A=
  bDeviceProtocol         1 =0A=
  bMaxPacketSize0        64=0A=
  idVendor           0x0db0 =0A=
  idProduct          0x6970 =0A=
  bcdDevice            5.25=0A=
  iManufacturer           0 =0A=
  iProduct                0 =0A=
  iSerial                 0 =0A=
  bNumConfigurations      1=0A=
  Configuration Descriptor:=0A=
    bLength                 9=0A=
    bDescriptorType         2=0A=
    wTotalLength          193=0A=
    bNumInterfaces          3=0A=
    bConfigurationValue     1=0A=
    iConfiguration          0=0A=
    bmAttributes         0x80=0A=
    MaxPower              100mA=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        0=0A=
      bAlternateSetting       0=0A=
      bNumEndpoints           3=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x81  EP 1 IN=0A=
        bmAttributes            3=0A=
          Transfer Type            Interrupt=0A=
          Synch Type               none=0A=
        wMaxPacketSize         16=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x02  EP 2 OUT=0A=
        bmAttributes            2=0A=
          Transfer Type            Bulk=0A=
          Synch Type               none=0A=
        wMaxPacketSize         64=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x82  EP 2 IN=0A=
        bmAttributes            2=0A=
          Transfer Type            Bulk=0A=
          Synch Type               none=0A=
        wMaxPacketSize         64=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       0=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize          0=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize          0=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       1=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize          9=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize          9=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       2=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         17=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         17=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       3=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         25=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         25=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       4=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         33=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         33=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        1=0A=
      bAlternateSetting       5=0A=
      bNumEndpoints           2=0A=
      bInterfaceClass       224 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      1 =0A=
      iInterface              0 =0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x03  EP 3 OUT=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         49=0A=
        bInterval               1=0A=
      Endpoint Descriptor:=0A=
        bLength                 7=0A=
        bDescriptorType         5=0A=
        bEndpointAddress     0x83  EP 3 IN=0A=
        bmAttributes            1=0A=
          Transfer Type            Isochronous=0A=
          Synch Type               none=0A=
        wMaxPacketSize         49=0A=
        bInterval               1=0A=
    Interface Descriptor:=0A=
      bLength                 9=0A=
      bDescriptorType         4=0A=
      bInterfaceNumber        2=0A=
      bAlternateSetting       0=0A=
      bNumEndpoints           0=0A=
      bInterfaceClass       254 =0A=
      bInterfaceSubClass      1 =0A=
      bInterfaceProtocol      0 =0A=
      iInterface              0 =0A=
  unknown descriptor type: 07 21 07 88 13 ff 03=0A=
  Language IDs: (length=3D4)=0A=
     0409 English(US)=0A=

------=_NextPart_000_0119_01C70B2B.BE055BF0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_NextPart_000_0119_01C70B2B.BE055BF0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_NextPart_000_0119_01C70B2B.BE055BF0--
