Return-Path: <linux-usb-users-admin@lists.sourceforge.net>
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Problem with bluetooth USB on Powerbook G4
Cc: Alan Stern <stern@rowland.harvard.edu>, bluez-users@lists.sourceforge.net
References: <Pine.LNX.4.44L0.0508012143540.14809-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0508012143540.14809-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508020944.06808.adq_dvb@lidskialf.net>
Sender: linux-usb-users-admin@lists.sourceforge.net
Errors-To: linux-usb-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-users>,
	<mailto:linux-usb-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-users@lists.sourceforge.net>
List-Help: <mailto:linux-usb-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-users>,
	<mailto:linux-usb-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-users>
Date: Tue, 2 Aug 2005 09:44:06 +0100
List-ID: <bluez-users.lists.sourceforge.net>

On Tuesday 02 Aug 2005 02:54, Alan Stern wrote:
> On Mon, 1 Aug 2005, Andrew de Quincey wrote:
> > Hi, I'm having a problem with linux and the Powerbook G4's bluetooth USB
> > device. First of all though, versions:
> >
> > Kernel: 2.6.13-rc4
> > Powerbook: 15" G4 post Feb-2005
> >
> > On my machine, the bluetooth USB device is not detected. Now I know that
> > Johannes Berg has a page explaining how he got it to work, but it doesn=
't
> > work for me.
> >
> > On my machine, lsusb -t gives:
> > Bus#  4
> > `-Dev#   1 Vendor 0x0000 Product 0x0000
> > Bus#  3
> > `-Dev#   1 Vendor 0x0000 Product 0x0000
> > Bus#  2
> > `-Dev#   1 Vendor 0x0000 Product 0x0000
> > Bus#  1
> > `-Dev#   1 Vendor 0x0000 Product 0x0000
> >
> >   |-Dev#   5 Vendor 0x05ac Product 0x1000
> >
> >   `-Dev#   6 Vendor 0x05ac Product 0x020f
> >
> > On Johannes' machine (with working USB bluetooth), it gives:
> > Bus# =A04
> > `-Dev# =A0 1 Vendor 0x0000 Product 0x0000
> > Bus# =A03
> > `-Dev# =A0 1 Vendor 0x0000 Product 0x0000
> > Bus# =A02
> > `-Dev# =A0 1 Vendor 0x0000 Product 0x0000
> > Bus# =A01
> > `-Dev# =A0 1 Vendor 0x0000 Product 0x0000
> > =A0 |-Dev# =A0 7 Vendor 0x05ac Product 0x8205
> > =A0 `-Dev# =A0 6 Vendor 0x05ac Product 0x020e
> >
> > Oddity: Johannes' USB tree doesn't have a device#5, but mine does.
>
> The device numbers aren't particularly important.  They are assigned one
> by one as devices are found by the kernel and have nothing to do with the
> devices' inherent characteristics.  The significant thing is that you both
> show two devices, even though the product IDs differ.  Your 0x020f may be
> the same kind of device as Johannes's 0x020e -- it's harder to tell what's
> going on with your 0x1000 and his 0x8205.  Maybe the Bluetooth device
> requires a firmware upload, which causes the ID to change.  If your system
> failed to carry out the upload, it would explain why the device doesn't
> work properly.
>
> > Mac OS X detects and uses the device perfectly. It's USB tree utility
> > shows that Bus#1 has two devices - the apple keyboard/trackpad
> > 0x5ac/0x20f and the USB bluetooth device, 0x5ac/0x8205 - no sign of an
> > 0x5ac/0x1000 device.
>
> That's consistent with the ID changing as a result of new firmware.
>
> > In my dmesg, I get:
>
> ...
>
> > usb 1-1: device descriptor read/64, error -71
> > usb 1-1: device descriptor read/64, error -71
> > usb 1-1: new full speed USB device using ohci_hcd and address 3
> > usb 1-1: device descriptor read/64, error -71
> > usb 1-1: device descriptor read/64, error -71
> > usb 1-1: new full speed USB device using ohci_hcd and address 4
> > usb 1-1: device descriptor read/8, error -71
> > usb 1-1: device descriptor read/8, error -71
> > usb 1-1: new full speed USB device using ohci_hcd and address 5
> > usb 1-2: new full speed USB device using ohci_hcd and address 6
> >
> > -- those -71 errors are fixed for Johannes by specifying
> > "use_both_schemes=3D1" as a module parameter to usbcore. However this
> > doesn't  work for me. And in fact, in rc4, use_both_schemes is defaulted
> > to 1 anyway.
>
> Those errors probably are just transient, not fatal.  I think you can
> safely ignore them.  After all, the devices _are_ detected in the end.
>
> > I have compared Johannes' .config and mine - and there are (now) no
> > differences - yet still it isn't working.
> >
> > Oh - all other USB devices work fine.
> >
> > What can I try next?
>
> Try to find out if the Bluetooth driver does upload firmware to the device
> and if something goes wrong with the upload.  It would also be a good idea
> to CC: the maintainer of the Bluetooth driver.

Aha, great idea. I've been browsing about in the mac os file system, and it=
=20
does seem to support several bluetooth devices.. I'm specifically intereste=
d=20
in "BroadcomUSBBluetoothFirmwareDownload.kext" which sounds likely. I'll fi=
nd=20
out the exact hardware used later.

I see there _is_ a linux driver for a USB broadcom bluetooth adapter that=20
uploads firmware. I'll try that one out in a bit - hopefully it is just a=20
matter of adding the correct USB IDs.

CCed to the bluetooth list in case anyone can throw light on this.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Linux-usb-users@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-users
