Return-Path: <cyrus@holtmann.org>
Message-ID: <4E10D0E5.8090408@kernelconcepts.de>
Date: Sun, 03 Jul 2011 22:28:21 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Disable pnat-server
References: <4E108D72.3010006@kernelconcepts.de> <20110703180444.GA19576@dell.ger.corp.intel.com> <4E10B97B.8060703@kernelconcepts.de> <20110703190615.GA20814@dell.ger.corp.intel.com> <4E10C989.9060909@kernelconcepts.de> <20110703201356.GA14128@dell.ger.corp.intel.com>
In-Reply-To: <20110703201356.GA14128@dell.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 03.07.2011 22:13, schrieb Johan Hedberg:
> On Sun, Jul 03, 2011, Nils Faerber wrote:
>>> Hmm? So they don't use SDP do discover the RFCOMM channel but directly
>>> connect to channel 1?
>>
>> Um...well I just checked that code.
>> What the device does it look for the service name on the host and on the
>> host side it is bound to channel 1 - I think. I borrowed that part of my
>> code from some old BlueZ code, forgot which.
> 
> So, the SDP service record is there so profiles can look up e.g. the
> RFCOMM channel based on the profile UUID. If that's what the remote
> device is doing you should be able to change the channel to something
> else than 1 in the service record and then bind your server socket to
> this new channel. However, if the remote side has a hard-coded channel
> value of 1 and doesn't care what SDP says then there's really nothing
> you can do (except make sure you don't have any other service on that
> channel, like you now did).

Looks like it is hardcoded, I just tried a different one and it fails.

>> Tried that and now my device works again - yippie!
> Good to hear! :)

At least I can now continue playing with it... eventually I'll release
my code once it reached a halfway usable state. Currently I still
struggle a little with the protocol implementation which would need a
state machine and I am still reluctant to implement one and wait for
another inspiration instead ;) But it seems it is not coming...

Thanks again!

> Johan
Cheers
  nils

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
