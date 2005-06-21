Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>
Content-Type: text/plain
Message-Id: <1119374946.26772.119.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 21 Jun 2005 19:29:06 +0200

Hi Victor,

> I've tried recently to run a2play on arm (@~380), well no surprise here,
> it looks like there is not enough cpu to deal with fp emulation. Later
> I've modified a2play so it can play pre-encoded sbc (sbcend output) to
> skip encoding part, but it still far from what I get when run it on PC.
> I think there is a synchronization problem somewhere there, hear a lot
> of clicks, drops and repetitions. I've tried it with 2 different pairs
> of headphones, on Bluewalker and on HP's (iPAQ gadget), and while the
> former sound not extremelly bad, the latter sound very crappy (there are
> periods when they sound ok, but mostly they are out of sync?). So it
> looks like it somehow connected with how the headphone handle timing?

the Bluewalker is a GCT based headphone and quite easy to satisfy. You
can also stream SBC directly over RFCOMM with rcplay. The HP is Zeevo
based and you really need to get the timing right to hear good sound.
The same applies for the CSR based headphones.

> I have a couple of questions:
> 
> 1) Is there anyone buse with sbc fixed point convertion?

We need an integer only implementation of SBC. I may repeat myself, but
I am not going to code this. This must be done by someone else.

> 2) Is there anyone with similar problems (out-of-synch sound) and knows
> how to solve it (or is it just about tuning the timer?)?

You need to encode the SBC frames in advance and then use a timer for
sending them. I am working on a ALSA plugin that will do exactly this,
but I think that won't help you on your embedded platform.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
