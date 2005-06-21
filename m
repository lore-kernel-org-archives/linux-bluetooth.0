Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B8563E.9040008@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local> <1119374946.26772.119.camel@pegasus>
In-Reply-To: <1119374946.26772.119.camel@pegasus>
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
Date: Tue, 21 Jun 2005 12:02:38 -0600

Guys,

>>I've tried recently to run a2play on arm (@~380), well no surprise here,
>>it looks like there is not enough cpu to deal with fp emulation. Later
>>I've modified a2play so it can play pre-encoded sbc (sbcend output) to
>>skip encoding part, but it still far from what I get when run it on PC.

the irony is we just overwrote an old a2play that required a preencoded 
stream to be piped in :(

>>I think there is a synchronization problem somewhere there, hear a lot
>>of clicks, drops and repetitions. I've tried it with 2 different pairs
>>of headphones, on Bluewalker and on HP's (iPAQ gadget), and while the
>>former sound not extremelly bad, the latter sound very crappy (there are
>>periods when they sound ok, but mostly they are out of sync?). So it
>>looks like it somehow connected with how the headphone handle timing?

i was hoping to get the timing problem hammered by using setitimer. 
unfortunately, there still seems to be some dependency on the cpu speed 
which is surprising to me. there's a place in the code where the time 
period reported by libsbc is multiplied by 87/100. that 87 has to be 
tweaked for different cpus :(

i came by the 87 by using my 1.4ghz pentium-M with the hp headset.

the iphono and itech headsets are very forgiving with timing. they also 
seem to have the worst problems with audio delay.

>>1) Is there anyone buse with sbc fixed point convertion?
> 
> We need an integer only implementation of SBC. I may repeat myself, but
> I am not going to code this. This must be done by someone else.

i started trying to do this with a library (gnu mp). the library is 
really meant for arbitrary-sized numbers, and not so great with short 
floats. if i had a reference implementation of soft floating point in C, 
i could dig into this again. i might try it without but i would have to 
reinvent the normalizing floats after multiply/divides.

>>2) Is there anyone with similar problems (out-of-synch sound) and knows
>>how to solve it (or is it just about tuning the timer?)?

yes, we found out pretty soon that the hp headset insists on that "87" 
to be tuned for different cpus. maybe there is something wrong with how 
i did the timer or maybe itimer is not a great route to go.

i also have an arm board that i am trying to use with this stuff. it can 
*receive* audio if the encoder settings are turned way down but can't 
transmit a2dp. see

  http://bluetooth-alsa.sourceforge.net/embed.html

> You need to encode the SBC frames in advance and then use a timer for
> sending them. I am working on a ALSA plugin that will do exactly this,
> but I think that won't help you on your embedded platform.

i'm very excited to see this part. go, Marcel! and hopefully you can let 
us see what this work looks like soon :)

Brad


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
