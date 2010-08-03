Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 3 Aug 2010 22:08:35 +0530
Message-ID: <AANLkTimK2eDOxJUo7jPdbvXczhcGgBa0sXZfiQL4n0KD@mail.gmail.com>
Subject: Multiple SPP connections, possible ? And, where are the docs ?
From: Banibrata Dutta <banibrata.dutta@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Quite new to BlueZ, but familiar with Bluetooth on Windows, and Linux
in general. Did try to go through some documentation around BlueZ I
found on the net including a HOWTO, but suprisingly a lot seems to
have changed in terms of how to configure BlueZ. Is there a man-page,
a newer HOWTO, or user's guide or README that may help me figure out,
how to configure BlueZ ?

What I intend to do is to connect my PC to 2 devices over SPP,
simultaneously. My PC is dual-boot (boots into Win-XP SP3, and also
Ubuntu 9.10 on x86 (32-bit plaf). My Win-XP SP3 runs WIDCOMM stack,
and I can communicate with both of the devices but one-at-a-time, so I
know that my BT transceiver and end-devices (mobile phones) are
working fine, and their configuration (atleast phone side) is okay.

What I would like to do on Ubuntu, is to use BlueZ to connect to the 2
phones, simultaneously (something that I am unable to achieve in
Windows-XP). I have managed to pair with both devices from within
Ubuntu, using the Gnome BT-Manager tool, and even succeeded in
browsing file-systems on both phones over OBEX, simultaneously.
However, I find no information on how to setup/configure SP Profile,
and how to achieve the simultaneous usage.

Any help / pointers to right set of docs would really help.

regards,
BD
