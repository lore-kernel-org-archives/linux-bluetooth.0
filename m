Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Hp bluetooth headset a2dp
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050324183426.62431.qmail@web52801.mail.yahoo.com>
References: <20050324183426.62431.qmail@web52801.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1111705098.9195.11.camel@pegasus>
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
Date: Thu, 24 Mar 2005 23:58:18 +0100

Hi Shawn,

> I have a pair of these headphones too, at work.  (My job involves a
> cellphone media player application which depends on being able to
> stream A2DP.)  There are a lot of them on ebay, going for 83.99USD,
> just search for "ipaq headphones".

they are more expensive here in Germany. The cheapest I found was for
around 112 EUR.

>   My impression is that they did a
> pretty decent job of implementing A2DP on the headphones, but with the
> iPAQ drivers that they ship, the audio quality is not that great.  They
> sound much better when streaming audio to them from a PC that has the
> BlueSoleil Windows stack installed.  (So far the only A2DP
> implementation for Windows that I've been able to get my hands on.) 

The Impulsesoft BluePC should also work and AVM showed their A2DP plans
at CeBIT.

> I'd love to be able to stream to them from Linux.  :-)

Me too. And especially direct and transparent through ALSA.

> I also have the Aiptek and Bluetake ones.  I just noticed that so much
> activity with A2DP has been happening while I was not paying attention,
> so I will try to do some testing.

The Aiptek is not conforming to the specification. However the SBC over
RFCOMM is a nice feature.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
