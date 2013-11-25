Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384864264.2027.22.camel@nuvo>
References: <1384864264.2027.22.camel@nuvo>
Date: Mon, 25 Nov 2013 13:37:30 -0800
Message-ID: <CAHZ1yC=Ub3Jark=kKuduuEJ2oNbxUruVHL0tEy9t4_jh1K-phw@mail.gmail.com>
Subject: Re: autopair corner cases
From: Scott James Remnant <keybuk@google.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 19, 2013 at 4:31 AM, Bastien Nocera <hadess@hadess.net> wrote:

> 1) First is the case of the PS3 BD Remote that will reject
> authentication when you try to pair to it. gnome-bluetooth knows not to
> pair with it.
>
>>        <!-- Sony PlayStation 3 Remote Control -->
>>         <device oui="00:19:C1:" name="BD Remote Control" pin="NULL"/>
>>         <device oui="00:1E:3D:" name="BD Remote Control" pin="NULL"/>
>>         <device oui="00:06:F5:" name="BD Remote Control" pin="NULL"/>
>
> Is there a way to say "we can't actually pair" when the client requested
> pairing already? Or is that considered a security problem?
>

It's perfectly valid for Bluetooth devices to not support pairing, and
return a "Pairing Not Supported" or "Authentication Not Supported"
error when attempted. When I tested a PS3 controller here, it seemed
to do that according to spec.

This is especially true for LE devices, the majority I have don't
support pairing.

While it's a "nice to have" for a UI to know in advance, maintaining
that list of devices would be quite an undertaking, it didn't seem
worth special casing the PS3 Controller. Also that should take the
form of a device property the UI can examine to decide whether or not
to offer pairing. Having the plugin fail pairing with the same error
the device would give anyway didn't seem like a "fix".

> 2) The second case is pairing this "funny" keyboard that's the iCade
> controller. In gnome-bluetooth, we had special code to generate only
> joystick movements for the pairing, rather than hard to determine
> buttons, so we'd end up with a 6-digit pin using only 1 through 4.
>
>>         <!-- ION iCade Game Controller -->
>>         <device name="iCade" type="keyboard" pin="ICADE"/>
>

Having a BlueZ-UI API just for this one device seems like overkill?
This can be just blacklisted in the autopair plugin, or handled by a
higher priority plugin, so the UI can use its special code, no?

> 3) We have a whole list of GPS that don't use present themselves as
> anything special apart from the name. Most use "0000", but some use
> things like "NAVMAN" or "12345678"
>
>>         <!-- http://bugzilla.gnome.org/show_bug.cgi?id=560315#c20 -->
>>         <device oui="00:02:5B:" name="Pharos iGPS-BT" pin="12345678"/>
>>
>>         <!-- https://bugzilla.gnome.org/show_bug.cgi?id=613698 -->
>>         <device oui="00:0C:A5:" name="NAVMAN GPS ONE" pin="NAVMAN"/>
>

These could be handled by extending the plugin, or a higher priority
plugin, - right now I don't think the plugin would deal with them at
all?

> 4) Audio devices will mostly already be supported by the autopair code
> (yay!), though we have a few stragglers, most notably this speaker that
> can use random pincode, as long as they're only 4 digits in length:
>
>>         <!-- http://bugzilla.gnome.org/show_bug.cgi?id=583651 -->
>>         <device type="audio" oui="00:1A:80:" name="CMT-DH5BT" pin="max:4"/>
>

I'm confused by this one - the device accepts any four-digit PIN?
wouldn't 0000 work? :)

> 5) Printers are missing from the list, that should be an easy fix.
>

Unsurprising, since Chromium OS doesn't support printers ;-)


Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
