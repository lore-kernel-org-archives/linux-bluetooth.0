Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-gnome wizard deficiencies make it mostly useless
From: Bastien Nocera <hadess@hadess.net>
To: Sebastian Spaeth <Sebastian@SSpaeth.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <491AB358.9000209@SSpaeth.de>
References: <491AB358.9000209@SSpaeth.de>
Content-Type: text/plain
Date: Wed, 12 Nov 2008 20:29:57 +0100
Message-Id: <1226518197.15397.11.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2008-11-12 at 11:43 +0100, Sebastian Spaeth wrote:
<snip>
> I caused quite a ruckus in this gnome bug yesterday:
> http://bugzilla.gnome.org/show_bug.cgi?id=560315

You didn't cause a ruckus, people that don't actually read the comments
did.

> Currently the bluez-gnome connection wizard fails invariably for all BT
> devices that don't have a keyboard and are not special cased in source code.

Mice, tablets, keyboards, headsets, hands-free, phones work. Only GPS
devices and mice, and headsets that don't use '0000' as the PIN codes
don't work.

That's not very many, and I managed to pair every single one of my
devices without a problem (and I have quite a lot of them).

> In my case this happens:
> I select the "setup new device" from the bluetooth-applet. Select
> "eGPS-397" which is my BT GPS device. Next, the "connecting" page comes
> up with a brief flash of some "type in random PIN" or something. It
> dissappears within a fraction of a second without giving me the chance
> to interact at all, leading to the page "pairing failed". This makes the
> wizard useless for all BT devices that cannot enter PINs and that are
> not special cased.

We know about that problem. I have a patch in my tree for your
particular GPS device, I'm still waiting for you to file a bug with the
details spelled out.

> Bastien Nocera thinks it would be a bad idea to allow users to enter a
> fixed pin (as a second choice to a default random PIN) via dialog and
> asked to enter a new bug for each device to add it as another special
> case. This is the wrong approach IMHO. Tracking all the devices out
> there and their PINs will be a losing battle and bloat the code. With a
> GPS device product lifecycle of a year, those devices will be outdated
> until the code ships in a Linux distribution.

I didn't say it was a bad idea to allow users to enter a fixed PIN, I
said it would be a bad idea to replace random PINs altogether with
user-provided PINs.

> I see 2 solutions and I would like input in what bluez-gnome devs think:
> 1) Try to pair with random PIN if that fails try "0000", "1234", "1111".
> This would at least cover about 90% of all devices and only special case
> the rest.

That wouldn't work, a lot of devices will get out of pairing mode after
an unsuccesful pairing.

> 2) Prepopulate a Random PIN in a field but allow the user to override
> that PIN. After all he should know best what PIN to use.

That's as bad as making the user enter the PIN themselves.

My solution would be to have a button at the bottom of the device
selection page called "PIN options" (or similar). The button would popup
a dialogue with options:
[X] Automatic PIN selection

[ ] Force a random PIN number

[ ] Use fixed PIN code:
        [X] '0000' (most headsets, mice and GPS devices)
        [ ] '1111'
        [ ] '1234'
        [ ] Custom: ___________

Wording is obviously up for discussion. The code is probably an
afternoon's work for somebody comfortable with GTK+, maybe a bit longer
to get Marcel happy with it ;)

Cheers

