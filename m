Return-Path: <cyrus@holtmann.org>
Message-ID: <48834E84.4040005@suse.de>
Date: Sun, 20 Jul 2008 16:41:08 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: Pawel Witas <nased0@aster.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez-utils-3.36 hidd daemon does not compile on Suse 11 x64
References: <4880ED2C.1020203@aster.pl>
In-Reply-To: <4880ED2C.1020203@aster.pl>
Content-Type: text/plain; charset=ISO-8859-2
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pawel Witas wrote:

> I'm using Gnome, not KDE and Gnome configurator could not start my MS
> Wireless Laser Mouse 8000.

You can still use kdebluetooth under gnome to configure input devices.
Anyway - if the gnome bluetooth applet does not work for you, then you should
file a bug report here.

> I have a Compal JFL-92 laptop with integrated BT and Suse 11 x64.
> I tried to configure my mouse manually according to some howto's found
> on the web, but the final step was starting the hidd daemon.
> When I compiled hidd (old version 2.25) and typed command:
>  hidd --connect 00:17:FA:8A:BD:0B
> and pressed a button at the bottom of my mouse
> the mouse started to move my cursor.

I still won't include hidd for openSUSE since it's obsoleted and will be gone
with 4.0 anyway.

> Just try to test Suse 11 x64 with Gnome on configuration similar to mine.
> I propose to include hidd daemon in Suse 11, to allow to configure BT
> manually (even if it is not needed by your configurators).

use the d-bus methods as described on
http://wiki.bluez.org/wiki/HOWTO/InputDevices if you don't want to use
kinputwizard or the bluez-gnome applet.

Have fun.
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
