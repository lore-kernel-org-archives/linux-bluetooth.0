Return-Path: <cyrus@holtmann.org>
Message-ID: <4E10B97B.8060703@kernelconcepts.de>
Date: Sun, 03 Jul 2011 20:48:27 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Disable pnat-server
References: <4E108D72.3010006@kernelconcepts.de> <20110703180444.GA19576@dell.ger.corp.intel.com>
In-Reply-To: <20110703180444.GA19576@dell.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 03.07.2011 20:04, schrieb Johan Hedberg:
> Hi Nils,
Hi Johan!

> On Sun, Jul 03, 2011, Nils Faerber wrote:
>> I have developed a small app which registers its own RFCOMM based
>> service and service ID using libbluetooth and the SDP services. This
>> worked great until some recent Ubuntu update which upgraded the
>> Bluetooth services (I guess).
>> Now I get an error in syslog whenever my device tries to connect:
>>
>> Jul  3 17:23:13 tlb bluetoothd[27590]: Unable to spawn pnatd: Failed to
>> execute child process "/usr/bin/phonet-at" (No such file or directory)
>>
>> It took me quite some time to figure out that this is part of the (new?)
>> bluetoothd plugin system which is pitily not documented anywhere -
>> especially not which plugins there are, what they do and how they can be
>> en- or disabled.
> 
> There should be absolutely no reason for Ubuntu have this plugin enabled
> or even compiled. You might wanna file a bug to them to disable it. The
> only place where it makes sense to be compiled is in Nokia's Maemo
> Harmattan platform. For everything else it should be disabled (as it is
> by default).

Yes, indeed - I have not tried, what is the default when compiling the
BlueZ package, en- or disabled?

> Btw, if you have your own RFCOMM based service you should take a look at
> doc/assigned-numbers.txt to be sure not to conflict with any of those
> services. The range of possible RFCOMM channels (1-31) is so small that
> it's easy to get conflicts.

I was not the one to choose that ;)
It is for the Sony Ericsson LiveView and I have to use what they did.

>> After some more searching and reading sources I found that plugins can
>> theoretically be disabled in bluetoothd's config file main.conf. So I added
>>
>> DisablePlugins = pnat-server
> 
> The plugin is called pnat, so that line should read DisablePlugins=pnat

Sure?
The pnat.c source sais:

static struct btd_adapter_driver pnat_server = {
        .name   = "pnat-server",
        .probe  = pnat_probe,
        .remove = pnat_remove,
};

I'll retry with pnat again ;)

> Johan
Cheers
  nils

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
