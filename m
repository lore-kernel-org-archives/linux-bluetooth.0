Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B99440.3030501@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
References: <C70061B183DE09419568AB2060C52A9570322F@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A9570322F@arion.intra.local>
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
Date: Wed, 22 Jun 2005 10:39:28 -0600

Victor,

I am going to have a whack at adding fixed point tables and making the 
decoder optionally use fixed point. I will let you know.

Brad

Victor Shcherbatyuk wrote:
> Hello all,
> 
> Today I was playing with the timeout. None of the values I've tried
> gives good results for HP headphones. Bigger values as I undestand lead
> to a buffer underrun in the headphones (same sound as I get with fp
> emulation on), while smaller values  lead to frame(sample?) drops on the
> headphone side (it kind of sounds faster, but I thing it just drops the
> samples)? The only thing that is stable are breaks in the music I have
> now and then. From another side, with Bluewalker, with the magic "87" it
> sounds almost the same as with HP headphones (so still break now and
> then), but if I reduce timeout by changing e.g. 87 -> 40 it becomes good
> and there is no difference from the PC. That makes me think that there
> is something to do with the buffering model used for these headphones. I
> still want to chek it.
> 
> The next step is the fixed point. As I understood Brad is already
> looking in to it? Cause I also wanted to look into it somewhere in short
> time...
> 
> Regards,
>        Victor.
> 
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
> Midgley
> Sent: Tuesday, June 21, 2005 20:03 PM
> To: bluez-devel@lists.sourceforge.net
> Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
> 
> i was hoping to get the timing problem hammered by using setitimer. 
> unfortunately, there still seems to be some dependency on the cpu speed
> which is surprising to me. there's a place in the code where the time
> period reported by libsbc is multiplied by 87/100. that 87 has to be
> tweaked for different cpus :(
> 
> i came by the 87 by using my 1.4ghz pentium-M with the hp headset.
> 
> the iphono and itech headsets are very forgiving with timing. they also
> seem to have the worst problems with audio delay.
> 
> 
>>>1) Is there anyone buse with sbc fixed point convertion?
>>
>>We need an integer only implementation of SBC. I may repeat myself, 
>>but I am not going to code this. This must be done by someone else.
> 
> 
> i started trying to do this with a library (gnu mp). the library is
> really meant for arbitrary-sized numbers, and not so great with short
> floats. if i had a reference implementation of soft floating point in C,
> i could dig into this again. i might try it without but i would have to
> reinvent the normalizing floats after multiply/divides.
> 
> 
>>>2) Is there anyone with similar problems (out-of-synch sound) and 
>>>knows how to solve it (or is it just about tuning the timer?)?
> 
> 
> yes, we found out pretty soon that the hp headset insists on that "87" 
> to be tuned for different cpus. maybe there is something wrong with how
> i did the timer or maybe itimer is not a great route to go.
> 
> i also have an arm board that i am trying to use with this stuff. it can
> *receive* audio if the encoder settings are turned way down but can't
> transmit a2dp. see
> 
>   http://bluetooth-alsa.sourceforge.net/embed.html
> 
> 
>>You need to encode the SBC frames in advance and then use a timer for 
>>sending them. I am working on a ALSA plugin that will do exactly this,
> 
> 
>>but I think that won't help you on your embedded platform.
> 
> 
> i'm very excited to see this part. go, Marcel! and hopefully you can let
> us see what this work looks like soon :)
> 
> Brad
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> This e-mail message contains information which is confidential and may be privileged. It is intended for use by the addressee only. If you are not the intended addressee, we request that you notify the sender immediately and delete or destroy this e-mail message and any attachment(s), without copying, saving, forwarding, disclosing or using its contents in any other way. TomTom N.V., TomTom International BV or any other company belonging to the TomTom group of companies will not be liable for damage relating to the communication by e-mail of data, documents or any other information.
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
