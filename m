Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 Jul 2011 21:04:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Disable pnat-server
Message-ID: <20110703180444.GA19576@dell.ger.corp.intel.com>
References: <4E108D72.3010006@kernelconcepts.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E108D72.3010006@kernelconcepts.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nils,

On Sun, Jul 03, 2011, Nils Faerber wrote:
> I have developed a small app which registers its own RFCOMM based
> service and service ID using libbluetooth and the SDP services. This
> worked great until some recent Ubuntu update which upgraded the
> Bluetooth services (I guess).
> Now I get an error in syslog whenever my device tries to connect:
> 
> Jul  3 17:23:13 tlb bluetoothd[27590]: Unable to spawn pnatd: Failed to
> execute child process "/usr/bin/phonet-at" (No such file or directory)
> 
> It took me quite some time to figure out that this is part of the (new?)
> bluetoothd plugin system which is pitily not documented anywhere -
> especially not which plugins there are, what they do and how they can be
> en- or disabled.

There should be absolutely no reason for Ubuntu have this plugin enabled
or even compiled. You might wanna file a bug to them to disable it. The
only place where it makes sense to be compiled is in Nokia's Maemo
Harmattan platform. For everything else it should be disabled (as it is
by default).

Btw, if you have your own RFCOMM based service you should take a look at
doc/assigned-numbers.txt to be sure not to conflict with any of those
services. The range of possible RFCOMM channels (1-31) is so small that
it's easy to get conflicts.

> After some more searching and reading sources I found that plugins can
> theoretically be disabled in bluetoothd's config file main.conf. So I added
> 
> DisablePlugins = pnat-server

The plugin is called pnat, so that line should read DisablePlugins=pnat

Johan
