Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Zygo Blaxell <zblaxell@faye.furryterror.org>
Subject: Re: The link I had working quit.  Help
Date: Thu, 09 Apr 2009 14:28:33 -0400
Cc: Zygo Blaxell <zblaxell@feedme.hungrycats.org>,
	Bastien Nocera <hadess@hadess.net>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904082240.11543.gene.heskett@verizon.net>
 <20090409145506.GB22527@faye.furryterror.org>
In-reply-to: <20090409145506.GB22527@faye.furryterror.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904091428.33629.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 09 April 2009, Zygo Blaxell wrote:
>On Wed, Apr 08, 2009 at 10:40:11PM -0400, Gene Heskett wrote:
>> Anyway the a7 eb101 responses are as follows:
>>
>> get address local returns the correct bdaddr of that device.
>> get address remote	err 4
>> get connectable		on
>
>connectable is good...
>
>> get ecbonding		responder
>> get ecconnection	auto
>> get encryption		on
>> get esschar		+
>> get flow		hardware  (this changed to none after I did an 'rst factory'
>> get linktimeout		0
>> get name local		eb101
>> get name remote		err 4
>> get parity		none
>> get security		off
>
>security off is interesting, given encryption is on...you might want
>to try the other three combinations of those flags.
>
>> get sleep		off
>> get sniff		on
>> get status		false
>> get trustedlist		empty return
>
>Now that's a problem.  You should have the address of the USB dongle here
>if you've paired with it.  That suggests that pairing maybe isn't working
>on the eb101?  Or maybe you have to use 'set trustedlist'?
>
>> get txpower		10
>> get visible		11:11:11:11:11:11
>>
>> And finally, a 'con 11:11:11:11:11:11' munches along for several seconds
>> before returning an 'err 14'
>
>That makes sense...you haven't set up a serial port service on the Linux
>machine for the eb101 to connect to.
>
>> Did anyone take a look at that tarball I sent yet?
>
>Not yet, although from eyeballing quickly it looks like bluetoothd has
>done service discovery and picked up service records.  I'll decode it
>the next time I have the tarball, the Bluetooth spec, and some time all
>together in one place.

Thank you very much Zygo.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
The reader this message encounters not failing to understand is cursed.

