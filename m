Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <423B1845.6090604@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] strange HP bluetooth headset
References: <20050318171309.GB25843@externe.net>
In-Reply-To: <20050318171309.GB25843@externe.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 18 Mar 2005 11:04:53 -0700

Guylhem

> I thought they would work with sbcenc/a2play - they don't. The audio
> is crackled, ie. I have approx 0.2 seconds with audio, 0.2 seconds
> without, and so on.

we found our headsets did not follow the standard very well. maybe the 
hp set doesn't either.

is there any way you can capture the bt stream going out of your 
pocketpc device?

> They don't work at all with rcplay - can't find a channel.

not surprising since your set doesn't offer an rfcomm service like the 
other two a2dp sets we've seen.

> This didn't really help:
> $ ./rcplay 00:0D:44:2A:09:00 test.sbc
> Can't get channel number - defaulting to 25: Success
> Channel : 25
> Can't open connection: Connection refused
> 
> However after that, using a2play I can play audio much better. It
> plays much too fast, without any distortion however. So I guess
> there's some capability settings I'm missing.

what else does a2play print out, like the capabilities, etc?

re: suggestions, you could try different numbers of frames in each 
packet... see:

while(psize + frame_len + sizeof(sbc_info) < mtu)

and maybe try change mtu to (mtu-1) or (mtu/2) etc...

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
