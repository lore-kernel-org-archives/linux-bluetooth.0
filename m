Return-Path: <cyrus@holtmann.org>
Message-ID: <4E10C989.9060909@kernelconcepts.de>
Date: Sun, 03 Jul 2011 21:56:57 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Disable pnat-server
References: <4E108D72.3010006@kernelconcepts.de> <20110703180444.GA19576@dell.ger.corp.intel.com> <4E10B97B.8060703@kernelconcepts.de> <20110703190615.GA20814@dell.ger.corp.intel.com>
In-Reply-To: <20110703190615.GA20814@dell.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 03.07.2011 21:06, schrieb Johan Hedberg:
> On Sun, Jul 03, 2011, Nils Faerber wrote:
>>> There should be absolutely no reason for Ubuntu have this plugin enabled
>>> or even compiled. You might wanna file a bug to them to disable it. The
>>> only place where it makes sense to be compiled is in Nokia's Maemo
>>> Harmattan platform. For everything else it should be disabled (as it is
>>> by default).
>>
>> Yes, indeed - I have not tried, what is the default when compiling the
>> BlueZ package, en- or disabled?
> 
> It's disabled (grep for pnat_enable in acinclude.m4).

OK, then it would indeed be Ubuntu's fault.

>>> Btw, if you have your own RFCOMM based service you should take a look at
>>> doc/assigned-numbers.txt to be sure not to conflict with any of those
>>> services. The range of possible RFCOMM channels (1-31) is so small that
>>> it's easy to get conflicts.
>>
>> I was not the one to choose that ;)
>> It is for the Sony Ericsson LiveView and I have to use what they did.
> 
> Hmm? So they don't use SDP do discover the RFCOMM channel but directly
> connect to channel 1?

Um...well I just checked that code.
What the device does it look for the service name on the host and on the
host side it is bound to channel 1 - I think. I borrowed that part of my
code from some old BlueZ code, forgot which.

>>>> After some more searching and reading sources I found that plugins can
>>>> theoretically be disabled in bluetoothd's config file main.conf. So I added
>>>>
>>>> DisablePlugins = pnat-server
>>>
>>> The plugin is called pnat, so that line should read DisablePlugins=pnat
>>
>> Sure?

Yes, you are ;)
Tried that and now my device works again - yippie!


Thanks for your quick help!

> Johan
Cheers
  nils

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
