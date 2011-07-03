Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 Jul 2011 22:06:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Disable pnat-server
Message-ID: <20110703190615.GA20814@dell.ger.corp.intel.com>
References: <4E108D72.3010006@kernelconcepts.de>
 <20110703180444.GA19576@dell.ger.corp.intel.com>
 <4E10B97B.8060703@kernelconcepts.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E10B97B.8060703@kernelconcepts.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jul 03, 2011, Nils Faerber wrote:
> > There should be absolutely no reason for Ubuntu have this plugin enabled
> > or even compiled. You might wanna file a bug to them to disable it. The
> > only place where it makes sense to be compiled is in Nokia's Maemo
> > Harmattan platform. For everything else it should be disabled (as it is
> > by default).
> 
> Yes, indeed - I have not tried, what is the default when compiling the
> BlueZ package, en- or disabled?

It's disabled (grep for pnat_enable in acinclude.m4).

> > Btw, if you have your own RFCOMM based service you should take a look at
> > doc/assigned-numbers.txt to be sure not to conflict with any of those
> > services. The range of possible RFCOMM channels (1-31) is so small that
> > it's easy to get conflicts.
> 
> I was not the one to choose that ;)
> It is for the Sony Ericsson LiveView and I have to use what they did.

Hmm? So they don't use SDP do discover the RFCOMM channel but directly
connect to channel 1?

> >> After some more searching and reading sources I found that plugins can
> >> theoretically be disabled in bluetoothd's config file main.conf. So I added
> >>
> >> DisablePlugins = pnat-server
> > 
> > The plugin is called pnat, so that line should read DisablePlugins=pnat
> 
> Sure?
> The pnat.c source sais:
> 
> static struct btd_adapter_driver pnat_server = {
>         .name   = "pnat-server",
>         .probe  = pnat_probe,
>         .remove = pnat_remove,
> };

That's the adapter driver name. I think the plugin name is still just
"pnat".

Johan
