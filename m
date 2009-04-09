Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
Subject: Re: The link I had working quit.  Help
Date: Wed, 08 Apr 2009 22:40:11 -0400
Cc: Bastien Nocera <hadess@hadess.net>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904081535.05157.gene.heskett@verizon.net>
 <20090408193640.GF18671@hungrycats.org>
In-reply-to: <20090408193640.GF18671@hungrycats.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904082240.11543.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 08 April 2009, Zygo Blaxell wrote:
>On Wed, Apr 08, 2009 at 03:35:04PM -0400, Gene Heskett wrote:
>> This is slightly different:
>> [root@coyote test]# cu -l /dev/rfcomm0 -s 9600
>> cu: open (/dev/rfcomm0): No route to host
>> cu: /dev/rfcomm0: Line in use
>>
>> Line in use?
>
>"Line in use" means that cu couldn't lock the device or open it.
>It's not an OS-level error.

I had forgotten to bring the sw printoutof page 9 up so I could enter it here.  
There is no comm proggy I can run on the coco from a shell/terminal, so I 
can't just copy/paste, darnit.

Anyway the a7 eb101 responses are as follows:

get address local returns the correct bdaddr of that device.
get address remote	err 4
get connectable		on
get ecbonding		responder
get ecconnection	auto
get encryption		on
get esschar		+
get flow		hardware  (this changed to none after I did an 'rst factory'
get linktimeout		0
get name local		eb101
get name remote		err 4
get parity		none
get security		off
get sleep		off
get sniff		on
get status		false
get trustedlist		empty return
get txpower		10
get visible		11:11:11:11:11:11

And finally, a 'con 11:11:11:11:11:11' munches along for several seconds 
before returning an 'err 14'

Did anyone take a look at that tarball I sent yet?

Many Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
The PILLSBURY DOUGHBOY is CRYING for an END to BURT REYNOLDS movies!!

