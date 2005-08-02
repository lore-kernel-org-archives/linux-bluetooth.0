Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: linux-usb-users@lists.sourceforge.net
Cc: Alan Stern <stern@rowland.harvard.edu>, bluez-users@lists.sourceforge.net
References: <Pine.LNX.4.44L0.0508012143540.14809-100000@netrider.rowland.org> <200508020944.06808.adq_dvb@lidskialf.net> <200508021136.08933.adq_dvb@lidskialf.net>
In-Reply-To: <200508021136.08933.adq_dvb@lidskialf.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508021216.52558.adq_dvb@lidskialf.net>
Subject: [Bluez-users] Re: [Linux-usb-users] Problem with bluetooth USB on Powerbook G4
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 2 Aug 2005 12:16:52 +0100

On Tuesday 02 Aug 2005 11:36, Andrew de Quincey wrote:
> On Tuesday 02 Aug 2005 09:44, Andrew de Quincey wrote:
> > On Tuesday 02 Aug 2005 02:54, Alan Stern wrote:
> > > On Mon, 1 Aug 2005, Andrew de Quincey wrote:
> > > > Hi, I'm having a problem with linux and the Powerbook G4's bluetooth
> > > > USB device. First of all though, versions:
> > > >
> > > > Kernel: 2.6.13-rc4
> > > > Powerbook: 15" G4 post Feb-2005
> > > >
> > > > On my machine, the bluetooth USB device is not detected. Now I know
> > > > that Johannes Berg has a page explaining how he got it to work, but
> > > > it doesn't work for me.
> > > >
> > > > On my machine, lsusb -t gives:
> > > > Bus#  4
> > > > `-Dev#   1 Vendor 0x0000 Product 0x0000
> > > > Bus#  3
> > > > `-Dev#   1 Vendor 0x0000 Product 0x0000
> > > > Bus#  2
> > > > `-Dev#   1 Vendor 0x0000 Product 0x0000
> > > > Bus#  1
> > > > `-Dev#   1 Vendor 0x0000 Product 0x0000
> > > >
> > > >   |-Dev#   5 Vendor 0x05ac Product 0x1000
> > > >
> > > >   `-Dev#   6 Vendor 0x05ac Product 0x020f
> > > >
> > > > On Johannes' machine (with working USB bluetooth), it gives:
> > > > Bus# =A04
> > > > `-Dev# =A0 1 Vendor 0x0000 Product 0x0000
> > > > Bus# =A03
> > > > `-Dev# =A0 1 Vendor 0x0000 Product 0x0000
> > > > Bus# =A02
> > > > `-Dev# =A0 1 Vendor 0x0000 Product 0x0000
> > > > Bus# =A01
> > > > `-Dev# =A0 1 Vendor 0x0000 Product 0x0000
> > > > =A0 |-Dev# =A0 7 Vendor 0x05ac Product 0x8205
> > > > =A0 `-Dev# =A0 6 Vendor 0x05ac Product 0x020e
> > > >
> > > > Oddity: Johannes' USB tree doesn't have a device#5, but mine does.
> > >
> > > The device numbers aren't particularly important.  They are assigned
> > > one by one as devices are found by the kernel and have nothing to do
> > > with the devices' inherent characteristics.  The significant thing is
> > > that you both show two devices, even though the product IDs differ.=20
> > > Your 0x020f may be the same kind of device as Johannes's 0x020e -- it=
's
> > > harder to tell what's going on with your 0x1000 and his 0x8205.  Maybe
> > > the Bluetooth device requires a firmware upload, which causes the ID =
to
> > > change.  If your system failed to carry out the upload, it would
> > > explain why the device doesn't work properly.
> > >
> > > > Mac OS X detects and uses the device perfectly. It's USB tree utili=
ty
> > > > shows that Bus#1 has two devices - the apple keyboard/trackpad
> > > > 0x5ac/0x20f and the USB bluetooth device, 0x5ac/0x8205 - no sign of
> > > > an 0x5ac/0x1000 device.
> > >
> > > That's consistent with the ID changing as a result of new firmware.
> > >
> > > > In my dmesg, I get:
> > >
> > > ...
> > >
> > > > usb 1-1: device descriptor read/64, error -71
> > > > usb 1-1: device descriptor read/64, error -71
> > > > usb 1-1: new full speed USB device using ohci_hcd and address 3
> > > > usb 1-1: device descriptor read/64, error -71
> > > > usb 1-1: device descriptor read/64, error -71
> > > > usb 1-1: new full speed USB device using ohci_hcd and address 4
> > > > usb 1-1: device descriptor read/8, error -71
> > > > usb 1-1: device descriptor read/8, error -71
> > > > usb 1-1: new full speed USB device using ohci_hcd and address 5
> > > > usb 1-2: new full speed USB device using ohci_hcd and address 6
> > > >
> > > > -- those -71 errors are fixed for Johannes by specifying
> > > > "use_both_schemes=3D1" as a module parameter to usbcore. However th=
is
> > > > doesn't  work for me. And in fact, in rc4, use_both_schemes is
> > > > defaulted to 1 anyway.
> > >
> > > Those errors probably are just transient, not fatal.  I think you can
> > > safely ignore them.  After all, the devices _are_ detected in the end.
> > >
> > > > I have compared Johannes' .config and mine - and there are (now) no
> > > > differences - yet still it isn't working.
> > > >
> > > > Oh - all other USB devices work fine.
> > > >
> > > > What can I try next?
> > >
> > > Try to find out if the Bluetooth driver does upload firmware to the
> > > device and if something goes wrong with the upload.  It would also be=
 a
> > > good idea to CC: the maintainer of the Bluetooth driver.
> >
> > Aha, great idea. I've been browsing about in the mac os file system, and
> > it does seem to support several bluetooth devices.. I'm specifically
> > interested in "BroadcomUSBBluetoothFirmwareDownload.kext" which sounds
> > likely. I'll find out the exact hardware used later.
> >
> > I see there _is_ a linux driver for a USB broadcom bluetooth adapter th=
at
> > uploads firmware. I'll try that one out in a bit - hopefully it is just=
 a
> > matter of adding the correct USB IDs.
> >
> > CCed to the bluetooth list in case anyone can throw light on this.
>
> Just noticed another weirdness - this mysterious 0x5ac/0x1000 device. Und=
er
> an lsusb -v it shows up as:
>
>
> Bus 001 Device 005: ID 05ac:1000 Apple Computer, Inc.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x05ac Apple Computer, Inc.
>   idProduct          0x1000
>   bcdDevice           17.92
>   iManufacturer           0
>   iProduct                0
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength        15104
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xe0
>       Self Powered
>       Remote Wakeup
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Devices
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      1 Keyboard
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.11
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      63
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0010  1x 16 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Devices
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      2 Mouse
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.11
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      61
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0010  1x 16 bytes
>         bInterval               1
>
>
> Weird eh? It says its subclass is a keyboard/mouse!

A friend has just pointed me to:

http://store.apple.com/1-800-MY-APPLE/WebObjects/AppleStore.woa/72101/wo/oT=
5zorkeg3cH25IQOn622ueI85D/1.0.0.11.1.0.6.9.5.19.0.1.0.1.1.2.1.0.15

Maybe my powerbook is booting up with the bluetooth device in a=20
'compatability' keyboard/mouse mode to support that bluetooth keyboard, and=
=20
it needs switched into 'normal' bluetooth mode somehow.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
