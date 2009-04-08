Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Bastien Nocera <hadess@hadess.net>
Subject: Re: The link I had working quit.  Help
Date: Wed, 08 Apr 2009 00:26:13 -0400
Cc: Zygo Blaxell <zblaxell@feedme.hungrycats.org>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
References: <200904041636.25409.gene.heskett@verizon.net>
 <20090407200201.GA18671@hungrycats.org>
 <1239145518.20817.915.camel@cookie.hadess.net>
In-reply-to: <1239145518.20817.915.camel@cookie.hadess.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904080026.13738.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 07 April 2009, Bastien Nocera wrote:
>On Tue, 2009-04-07 at 16:02 -0400, Zygo Blaxell wrote:
>> On Tue, Apr 07, 2009 at 02:54:54PM -0400, Gene Heskett wrote:
>> > But nothing seems to enable the pairing, and everytime I do that
>>
>> that far in
>>
>> > the 'bluetooth-wizard' and it sees the eb101, it tells me to enter
>>
>> an
>>
>> > apparently randomly derived 4 digit pin number, but the wizard gives
>>
>> me no
>>
>> > place to enter it. Nor is there a 'proceed' button, and in 5 seconds
>>
>> or so it
>>
>> > clears that screen and reports pairing failed.
>>
>> bluez-gnome (where your bluetooth-wizard comes from?) has a really
>> stupid
>> UI design.  If bluetooth-wizard thinks you *can* enter a PIN into your
>> device, it will *require* you to enter a random one.  This idea
>> doesn't
>> work so well on devices that don't have keyboards or that have fixed
>> PINs,
>> and bluetooth-wizard knows only about broad categories of devices and
>> a
>> handful of exceptions.  The opposite problem occurs on devices where
>> bluez-gnome thinks it knows a fixed-PIN device's PIN, but it actually
>> doesn't.
>>
>> Also, bluez-gnome's discovery page won't show you discoverable devices
>> that
>> are already known, so it can't tell you if a known device is in range.
>> 'hcitool scan' will tell you about all devices in range, but it causes
>> some
>> problems for bluetoothd if both are running at the same time.
>>
>> If you can, use simple-agent instead of bluetooth-wizard.
>
>Or you can use gnome-bluetooth which has those problems fixed.

But, the F10 rpm has no executables in it, a long list of .png's and .mo's and 
some docs, but nothing in it goes in /bin, /sbin, /usr/bin or /usr/sbin.  Its 
all eye candy & no cattle.  I have it and its deps installed, so what is the 
cli incantation that is supposed to run it?

Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
It's hard to keep your shirt on when you're getting something off your chest.

