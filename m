Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42B8563E.9040008@xmission.com>
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>
	 <1119374946.26772.119.camel@pegasus>  <42B8563E.9040008@xmission.com>
Content-Type: text/plain
Message-Id: <1119378538.26772.127.camel@pegasus>
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
Date: Tue, 21 Jun 2005 20:28:58 +0200

Hi Brad,

> i was hoping to get the timing problem hammered by using setitimer. 
> unfortunately, there still seems to be some dependency on the cpu speed 
> which is surprising to me. there's a place in the code where the time 
> period reported by libsbc is multiplied by 87/100. that 87 has to be 
> tweaked for different cpus :(

this is because the encoding itself takes some time. For that we need to
encode up to 6 SBC frames in advance.

> > You need to encode the SBC frames in advance and then use a timer for
> > sending them. I am working on a ALSA plugin that will do exactly this,
> > but I think that won't help you on your embedded platform.
> 
> i'm very excited to see this part. go, Marcel! and hopefully you can let 
> us see what this work looks like soon :)

Don't expect any updates this month, because I am too busy with other
things. I will release bluez-utils-2.18 without an updated version of
the plugin. However my plan is to have a basic A2DP plugin and also a
headset plugin working before I am going to the OLS.

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
