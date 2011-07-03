Return-Path: <cyrus@holtmann.org>
Message-ID: <4E108D72.3010006@kernelconcepts.de>
Date: Sun, 03 Jul 2011 17:40:34 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Disable pnat-server
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!
I have developed a small app which registers its own RFCOMM based
service and service ID using libbluetooth and the SDP services. This
worked great until some recent Ubuntu update which upgraded the
Bluetooth services (I guess).
Now I get an error in syslog whenever my device tries to connect:

Jul  3 17:23:13 tlb bluetoothd[27590]: Unable to spawn pnatd: Failed to
execute child process "/usr/bin/phonet-at" (No such file or directory)

It took me quite some time to figure out that this is part of the (new?)
bluetoothd plugin system which is pitily not documented anywhere -
especially not which plugins there are, what they do and how they can be
en- or disabled.

After some more searching and reading sources I found that plugins can
theoretically be disabled in bluetoothd's config file main.conf. So I added

DisablePlugins = pnat-server

there but still bluetoothd tries to spawn pnatd upon incoming connection!?

This is pretty annoying.

Additionally I really wonder if this is a reasonable default for a PC?
Which PC has an AT command device that it would want to export over
Bluetooth? A mobile, yes, maybe, but on a PC?
And even then, there is no appropriate pnatd application coming with the
Bluetooth BlueZ package so this default does not even work. I would
therefor strongly suggest to disable pnatd by default and only enable it
where it is actually needed.

So, how can I get rid of this pnatd pseudo service so that my service
will work again?


PS: If you wonder what my service is about it is a small app for the
SonyEricsson LiveView mobile display device...

Cheers
  nils

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
