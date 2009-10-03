Return-Path: <cyrus@holtmann.org>
Subject: Re: So very close, but so frustrating...
From: Dan Williams <dcbw@redhat.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	networkmanager-list@gnome.org
In-Reply-To: <1254534287.11531.41.camel@localhost.localdomain>
References: <4AC3EFD9.1020602@shic.co.uk>
	 <7cd7fc040909301718r3e441c53x767084b0b01f4a7c@mail.gmail.com>
	 <1254433173.9657.155.camel@localhost.localdomain>
	 <1254439169.22191.317.camel@localhost.localdomain>
	 <1254534287.11531.41.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 03 Oct 2009 01:08:05 -0700
Message-Id: <1254557285.8653.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-10-02 at 18:44 -0700, Dan Williams wrote:
> On Fri, 2009-10-02 at 00:19 +0100, Bastien Nocera wrote:
> > On Thu, 2009-10-01 at 14:39 -0700, Dan Williams wrote:
> > > On Wed, 2009-09-30 at 20:18 -0400, Darren Albers wrote:
> > <snip>
> > > > At this time Network Manager does not support Bluetooth modems.   I
> > > > think 0.8 supports phones if they use Bluetooth PAN but not Bluetooth
> > > > DUN.
> > > 
> > > Correct; I may just get bored enough today triaging bugs to go implement
> > > DUN in 0.8.  That opens up a huge number of cellphones, which will
> > > inevitably lead to even more bugs since there's much more phone
> > > variation than in the relatively small data card space.  Oh well; it
> > > would help a lot of people out.
> > 
> > 1. Add ability for MM to identify Bluetooth modems
> 
> I believe that would mostly work automatically after NM tells bluez to
> create the port and connect, right?  Basically, after the BT parts come
> up and the serial port is active, MM should get the add even from udev
> and probe the port like any other port.
> 
> What I'm not clear about is when the serial port actually shows up in
> sysfs and when udev sends the event; does that only happen when the BT
> connection between computer and phone is up and the port can actually be
> used?  Or does the port appear immediately before the phone/host have
> connected to each other?

To answer some of these questions... the port shows up when connection
is possible.  I fixed a few bugs causing MM to fail to detect the rfcomm
ports:

e5441115a2dda5d81de2e9a336fc34e23d20b309
ed059286c5361bf4dfa849088ee16c04cd075e51
aa78b5f5e5319e04f5b57f928bfab69dd4b93d88

> Next, we need to see if the probing actually works on these phones, and
> figure out the bugs.  We'll get assloads of bugs about this I'm sure,
> but we just have to suck that up and quirk all the stupid phones out
> there.
> 
> > 2. Add plugin in bluez to poke at the modem with MM if it doesn't know
> > the type of device, cache the result, the bluez plugin exports the
> > information through a service
> 
> Why not just do this from the gnome-bluetooth plugin?  The plugin would
> probably just ask bluez to connect to the phone via DUN, let MM discover
> the port via the normal mechanisms, and then query MM for the modem
> type, then create the right connection in GConf.  That should be pretty
> straightforward when (1) is done.
> 
> I dont' really see why we'd need something bluez itself to do this.

See the 'btdun' branch of nm-applet, where I've added DUN support to the
gnome-bluetooth plugin.  There's nothing in the applet or NM side yet,
both will need further fixes.  But the gnome-bt plugin seems to work OK
at the moment.  Bastien, can you sanity check it?  There's a lot of
async dbus calls going on there between the plugin, Bluez, and MM.
Needs another set of eyes.

8b0ae181efd1e3856851e6a44e16bd51d440d0ce
c1c13b9dff6772bf13ab6217a2eecb986bd67687

> > 3. Add DUN gnome-bluetooth plugin to nm-applet which would poke the
> > bluez service
> 
> See above.
> 
> > 4. Add native support in NM to do the connection through bluetoothd
> 
> That's mostly already there; we wrote it but didn't connect it up to
> ModemManager.  This gets a bit interesting, because now we have the
> NMBTDevice object, but by default we'll also get a Modem subclass when
> ModemManager announces it ahs the device.  We need to intercept that in
> NM and just attach the modem to the NMBtDevice.

Haven't looked into this yet; getting all the corner cases right in the
gnome-bluetooth plugin was hard enough for one night.

Dan

> > After 3., if the box is ticked, the device should appear like an
> > unconfigured WWAN modem to the user. The service configuration can then
> > be done through nm-applet.
> 
> I thought we were going to be doing the service configuration through
> the gnome-bluetooth plugin?  Basically, when you tick the box for "use
> my phone for dial-up networking" in the plugin, it would throw up a
> spinner and say "Detecting phone type...", tell bluez to fire up the
> rfcomm port, let MM find the rfcomm port, then ask MM for the type, and
> then launch the mobile broadband config wizard to get the rest of the
> settings.  When that's done, it stores the config in GConf just like the
> PAN stuff.  No?
> 
> > I can certainly take care of 2. and 3. if you do 1. and the left-overs
> > of 4 :)
> 
> Yeah, I'm the best for 1 & 4.  I'll try to take a look tonight.
> 
> Dan
> 
> 
> _______________________________________________
> NetworkManager-list mailing list
> NetworkManager-list@gnome.org
> http://mail.gnome.org/mailman/listinfo/networkmanager-list

