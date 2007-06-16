Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1182011715.31424.346.camel@cookie.hadess.net>
References: <1181925876.31424.326.camel@cookie.hadess.net>
	<1181977540.6846.38.camel@aeonflux.inter-touch.com>
	<1182011715.31424.346.camel@cookie.hadess.net>
Date: Sat, 16 Jun 2007 21:35:31 +0200
Message-Id: <1182022535.30934.11.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HID initiated connections and input service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

> > > * Second device: Sixaxis PS3 Bluetooth joypad
> > > 
> > > Again, 2 connections modes. Firstly, there's no pairing, the joypad
> > > knows about the computer when one runs sixpair when the pad is connected
> > > via USB, as per:
> > > http://www.pabr.org/sixlinux/sixlinux.en.html
> > > (Marcel talked about integrating this with udev, which should be pretty
> > > straight forward)
> > > 
> > > Once disconnected from USB, and turned on, the device will try to
> > > connect to the computer. bluetooth-applet will request auth, and ask us
> > > whether we want to allow the connection. But as the device was never
> > > discovered/setup using CreateDevice, the get_store_device_info in
> > > input/server.c will fail.
> > > 
> > > You can't use CreateDevice with the device, as it's either connecting to
> > > our computer, or off, and connection requests will fail.
> > 
> > The sixpair.c tool needs to do some nasty tricks. It hast to get its own
> > Bluetooth address from the controller and then get its HID report
> > descriptor over USB. Then store them in /var/lib/bluetooth and also set
> > itself to trusted.
> > 
> > We might wanna integrate that into the input service, but to be honest I
> > currently don't know how. It also might make more sense to let a HAL
> > addon handle this kind of authentication instead of at udev level.
> 
> What we could do is:
> 1) have a HAL addon that will set the device's bdaddr in a property of
> the device when plugged into USB

I think a HAL addon that export the BD_ADDR of the controller as a
property is a good idea. We might also wanna add the current configured
host controller for that device and add a method to change that address.

> 2) have bluetooth-applet (or any other front-end) ask the user whether
> to set the device as trusted when it's plugged in (can be switched off
> with a config item)

Personally I think this should happen without any user-interaction once
you plugin the controller. However haven't thought about it that much.

> 3) Add a method to the input service (AddUSBDevice(string address,
> string usbdev) that will get the USB HID report descriptor, and set the
> device as trusted along with the rest of the info

No. I don't wanna have hardware specific methods in that API.

> I could work on that (it should be pretty straight-forward), except I
> don't have any code to get the bdaddr from the device and I don't know
> how to get the HID report descriptor from the device either. If you have
> some code that does that, feel free to pass it on, I can do the
> integration.

Check http://www.holtmann.org/papers/bluetooth/csw2007_slides.pdf and
you will see the report ids that will give you that information. I do
have code for that, but can't find it right now. Maybe it is on one of
my machines that I switched off.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
