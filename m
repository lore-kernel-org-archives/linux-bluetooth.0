Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1503519698.24498.33.camel@hadess.net>
Subject: Re: [RFC][PATCH BlueZ] sixaxis: Differing device name between usb
 and bluetooth connection
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@codecoup.pl>,
        Nicolas Werner <nicolas.werner@gmx.net>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Date: Wed, 23 Aug 2017 22:21:38 +0200
In-Reply-To: <CAAEJBhJ-ho-uvEw0QACzNY6qKkb1EbtTpsRfVhx8jqevFZ8+8A@mail.gmail.com>
References: <2299304.XBxEXHNB4J@gentooasus> <11841060.dynqo2U1Dt@gentooasus>
         <CAAEJBhJ-ho-uvEw0QACzNY6qKkb1EbtTpsRfVhx8jqevFZ8+8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2017-08-07 at 08:56 +0200, Szymon Janc wrote:
> Hi Nicolas,
> 
> On 4 August 2017 at 22:29, Nicolas Werner <nicolas.werner@gmx.net>
> wrote:
> > Am Samstag, 4. Februar 2017, 19:16:28 CEST schrieben Sie:
> > > BlueZ sets the device name of Dual Shock 3 controller to
> > > "PLAYSTATION(R)3
> > > Controller". When you connect the same controller via USB it is
> > > set to "Sony
> > > PLAYSTATION(R)3 Controller".
> > > 
> > > It seems that at least some games fail to recognize the
> > > controller as a Dual
> > > Shock 3/sixaxis controller and don't load the default mapping for
> > > PlayStation controllers, if the name doesn't contain the Sony
> > > part. Also I
> > > don't see a reason to use a different name, when connecting via
> > > Bluetooth.
> > > 
> > > I noticed this with "The Binding of Isaac: Rebirth" and it seems,
> > > that Steam
> > > also recognizes the controller better after the patch, although
> > > I'm not
> > > confident, if I can parse the controller configuration dialog
> > > correctly. I
> > > don't know, if this breaks anything, because it depends on the
> > > current
> > > name.
> > > 
> > > The attached patch changes the device name set when pairing to
> > > match the
> > > device name, when connected via USB.
> > > 
> > > Nicolas Werner
> > > 
> > > --- a/plugins/sixaxis.c
> > > +++ b/plugins/sixaxis.c
> > > @@ -56,7 +56,7 @@
> > >         uint16_t version;
> > >  } devices[] = {
> > >         {
> > > -               .name = "PLAYSTATION(R)3 Controller",
> > > +               .name = "Sony PLAYSTATION(R)3 Controller",
> > >                 .source = 0x0002,
> > >                 .vid = 0x054c,
> > >                 .pid = 0x0268,
> > 
> > It seems I'm not the only one with this issue as I recently found
> > this issue
> > (https://bugzilla.kernel.org/show_bug.cgi?id=195225) in the kernel
> > bug
> > tracker. It looks like dual shock 4 controllers have a similar
> > issue.
> > 
> > I asked on IRC and someone recommended to ping this message. Again,
> > I would
> > appreciate some comments on this issue and it would be great if
> > this issue
> > could be fixed.
> 
> I'm not sure where I took original name from (probably this is how
> DS3
> presents itself over BT).

You took it from commit 7d3d42ac10a6482057101667afd603ce1e79b866

As far as I remember, that was the name used by the device when
connecting via Bluetooth and doing reverse SDP.

> Anyway, if this fix the problem I'm fine with changing the name (and
> patch looks OK). Could you send a proper patch created with 'git
> format-patch'?

Changing the name is fine, as it won't be visible when doing scans
anyway, it'll only appear when the device is already paired.

> As for DS4 this is a bit more trickier since that name is the name
> device use over BT and we would probably have to spoof it...

There's a thread about adding cable-pairing for those. Look for "Add
new DS4 controller PID into special case handler".

Trying the PS button+Share button trick to make it visible over
Bluetooth fails on my system, I'm pretty sure it's a trick to re-pair
if one of the sides gets out of sync.

I'll probably try to clean that up tomorrow so we can merge it, and
send my old "cable pairing" agent code again.

Cheers
