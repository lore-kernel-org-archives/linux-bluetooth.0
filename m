Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: jjbrucker@free.fr
In-Reply-To: <1158570541.450e622da6e80@imp6-g19.free.fr>
References: <1158570541.450e622da6e80@imp6-g19.free.fr>
Date: Mon, 18 Sep 2006 11:53:59 +0200
Message-Id: <1158573239.5645.26.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] re : re specific keyboard in hidd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jean-Jacques,

> > the actual keyboard layout maybe needs a re-thinking. I leave this to
> > actual users of it.
> >
> Yes, maybe. But i really think we don't have to loose a key in hidd "driver" on
> this small keyboard. This kind of keyboard is made to machines who didn't have
> an other keyboard (like pda, phones ...). So we can load a "Smart keyboard"
> specific keymap file for this machine. The only challenge is to make the same
> layout for all this kind of tiny bluetooth keyboard. (Have the other one at
> less an escape button ?).

I have no idea. The EPoX device is a presenter that acts like a mouse.

> > >  At the end my patch suggested an architecture to manage different
> > > peripherals. The code in is actual state will become a big mess if the
> > > number of differents peripheral to manage increase.
> >
> > No it wasn't an architecture. It still was a hack. The decoding routine
> > for the keyboard was still named epox_decode(). A clean architecture
> > would have used a callback table or something similar. You can't design
> > an architecture if you don't have enough facts about the devices you are
> > trying to cover. Everything that is based on the Serial Port Profile and
> > which uses a proprietary protocol on top of RFCOMM is a problem and all
> > of them are basically unique.
> 
> You're right about that.
> I didn't exactly know why this function was called epox_decode (i didn't know
> about an epox device even if I supposed it comes from it)and that is was i
> don't have rename it. Yes I prefer to use a callback table as well, and I don't
> have enough facts about the devices to cover.

Even the full HID ones are problematic, but the RFCOMM based suck. I
actually convinced EPoX to move to a full HID design and it is now hard
to actually get the old presenter.

> > I prefer the less intrusive approach and this was to use the class of
> > device and/or service name for detecting the (at the moment) two
> > different devices. I would pick the OUI part of the BD_ADDR only if I
> > have no other choice and trusting the remote name is also not a good
> > idea, because some input devices allow to change it.
> >
> Trusting the remote name is really the worst idea, but (that was the first I
> have and)we will maybe have no choice...
>  I hope the class and service name will be enough to detect 2 different devices.
> But we don't know what futur bt device will be and comparing the bd_addr to a
> (small, smallest) database of devices ranges is the most reliable method.

We will do this when we go along. At the moment it is enough to not make
it more complex than it already is.

> > And besides the Laserkey keyboard, I don't expect any other kind of
> > Bluetooth input device. The HID is a standard and if you buy a CSR chip,
> > you basically get the HID support for free. They did all the work for
> > running HID on the chip.
> >
> I don't expect too any other kind of Bluetooth device, but we are not behind all
> bluetooth device manufacter to teach them how to run HID on the chip and not
> making specific (windows) drivers ...

You will always have stupid manufacturers, but the HID solution is a lot
easier and cheaper than a RFCOMM solution. The price is important for a
product launch and so I don't really expect any new RFCOMM keyboard in
the future.

> I am not offensed you don t have use the devices.h in the CVS, I just want that
> we already have (good) ideas and some lines about how to do IF we will have to
> manage more specifics devices.
> But today we don't know too much specifics devices...

The hidd source code has been grown over the last years and the support
for the EPoX presenter and the J-Three keyboard don't really fit into
it. However I am lazy and I didn't wanna have a second application to
detect the EPoX device (HID and non-HID version) and so I included that
support there.

As I mentioned, it needs D-Bus support and maybe a rewrite. I will think
about that once I have more free time.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
