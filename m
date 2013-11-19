Return-Path: <cyrus@holtmann.org>
Message-ID: <1384864264.2027.22.camel@nuvo>
Subject: autopair corner cases
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 19 Nov 2013 13:31:04 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

There's a bunch of corner cases that the autopair plugin doesn't handle
and that we used to handle in gnome-bluetooth with BlueZ 4.x.

1) First is the case of the PS3 BD Remote that will reject
authentication when you try to pair to it. gnome-bluetooth knows not to
pair with it.

>        <!-- Sony PlayStation 3 Remote Control -->
>         <device oui="00:19:C1:" name="BD Remote Control" pin="NULL"/>
>         <device oui="00:1E:3D:" name="BD Remote Control" pin="NULL"/>
>         <device oui="00:06:F5:" name="BD Remote Control" pin="NULL"/>

Is there a way to say "we can't actually pair" when the client requested
pairing already? Or is that considered a security problem?

2) The second case is pairing this "funny" keyboard that's the iCade
controller. In gnome-bluetooth, we had special code to generate only
joystick movements for the pairing, rather than hard to determine
buttons, so we'd end up with a 6-digit pin using only 1 through 4.

>         <!-- ION iCade Game Controller -->
>         <device name="iCade" type="keyboard" pin="ICADE"/>

3) We have a whole list of GPS that don't use present themselves as
anything special apart from the name. Most use "0000", but some use
things like "NAVMAN" or "12345678"

>         <!-- http://bugzilla.gnome.org/show_bug.cgi?id=560315#c20 -->
>         <device oui="00:02:5B:" name="Pharos iGPS-BT" pin="12345678"/>
> 
>         <!-- https://bugzilla.gnome.org/show_bug.cgi?id=613698 -->
>         <device oui="00:0C:A5:" name="NAVMAN GPS ONE" pin="NAVMAN"/>

4) Audio devices will mostly already be supported by the autopair code
(yay!), though we have a few stragglers, most notably this speaker that
can use random pincode, as long as they're only 4 digits in length:

>         <!-- http://bugzilla.gnome.org/show_bug.cgi?id=583651 -->
>         <device type="audio" oui="00:1A:80:" name="CMT-DH5BT" pin="max:4"/>

5) Printers are missing from the list, that should be an easy fix.

I'll try and send patches for cases 2 through 4, using a static table in
the autopair plugin. If that's not acceptable, I'll create a new
higher-priority plugin that handles those corner cases.

Cheers

