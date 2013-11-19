Return-Path: <cyrus@holtmann.org>
Message-ID: <1384867785.2027.36.camel@nuvo>
Subject: Re: autopair corner cases
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: deymo@chromium.org, Scott James Remnant <scott@netsplit.com>
Date: Tue, 19 Nov 2013 14:29:45 +0100
In-Reply-To: <1384864264.2027.22.camel@nuvo>
References: <1384864264.2027.22.camel@nuvo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2013-11-19 at 13:31 +0100, Bastien Nocera wrote:
> Heya,
> 
> There's a bunch of corner cases that the autopair plugin doesn't handle
> and that we used to handle in gnome-bluetooth with BlueZ 4.x.
> 
> 1) First is the case of the PS3 BD Remote that will reject
> authentication when you try to pair to it. gnome-bluetooth knows not to
> pair with it.
> 
> >        <!-- Sony PlayStation 3 Remote Control -->
> >         <device oui="00:19:C1:" name="BD Remote Control" pin="NULL"/>
> >         <device oui="00:1E:3D:" name="BD Remote Control" pin="NULL"/>
> >         <device oui="00:06:F5:" name="BD Remote Control" pin="NULL"/>
> 
> Is there a way to say "we can't actually pair" when the client requested
> pairing already? Or is that considered a security problem?

I've left the handling in gnome-bluetooth for this one.

> 2) The second case is pairing this "funny" keyboard that's the iCade
> controller. In gnome-bluetooth, we had special code to generate only
> joystick movements for the pairing, rather than hard to determine
> buttons, so we'd end up with a 6-digit pin using only 1 through 4.
> 
> >         <!-- ION iCade Game Controller -->
> >         <device name="iCade" type="keyboard" pin="ICADE"/>

I've sent a patch for that one.

> 3) We have a whole list of GPS that don't use present themselves as
> anything special apart from the name. Most use "0000", but some use
> things like "NAVMAN" or "12345678"
> 
> >         <!-- http://bugzilla.gnome.org/show_bug.cgi?id=560315#c20 -->
> >         <device oui="00:02:5B:" name="Pharos iGPS-BT" pin="12345678"/>
> > 
> >         <!-- https://bugzilla.gnome.org/show_bug.cgi?id=613698 -->
> >         <device oui="00:0C:A5:" name="NAVMAN GPS ONE" pin="NAVMAN"/>

I will leave those in gnome-bluetooth as well, as autopair will not
handle those.

> 4) Audio devices will mostly already be supported by the autopair code
> (yay!), though we have a few stragglers, most notably this speaker that
> can use random pincode, as long as they're only 4 digits in length:
> 
> >         <!-- http://bugzilla.gnome.org/show_bug.cgi?id=583651 -->
> >         <device type="audio" oui="00:1A:80:" name="CMT-DH5BT" pin="max:4"/>

I will carry on handling this in gnome-bluetooth, as the pincodes aren't
displayed for audio devices. So it will try "0000" which will fail, and
bluetoothd should fall back to asking us for the pincode, which we'll
generate according to this rule.

> 5) Printers are missing from the list, that should be an easy fix.

Sent a patch for that.

There's one case left for me to handle.

6) I have a "TomTom Remote" that shows up as a keyboard and uses "0000"
as its PIN. The problem is that, as per the code in autopair.c we'll
first show a random pincode then quickly fall back to using "0000":
> /* For keyboards rejecting the first random code
>  * in less than 500ms, try a fixed code. */

How does ChromeOS present this? Does it wait half a second before
showing the pincode to enter? Because flashing an unusable pincode on
the screen before succeeding pairing is pretty rubbish in my opinion...

Cheers

