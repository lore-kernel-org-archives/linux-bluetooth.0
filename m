Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with AnyCom CF-300 on ARM920
	Integrator/AP
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1127914574.2662.22.camel@hexa0xfb>
References: <1127914574.2662.22.camel@hexa0xfb>
Content-Type: text/plain
Message-Id: <1128012252.30743.23.camel@localhost.localdomain>
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
Date: Thu, 29 Sep 2005 18:44:12 +0200

Hi Itzhak,

> I'm having a very hard time trying to make bluetooth work on the ARM
> Integrator/AP platform.
> 
> Initially, I had a problem with pccard that was not recognized by pcmcia
> yenta_socket. Then, Russell King (ARM Linux Maintainer) provided my a
> patch that solved this problem.
> 
> Then, now pccard bus works properly. PCMCIA system recognizes my card:
> Socket 0:
>   product info: "BTCFCARD", "LSE139"
>   manfid: 0x0264, 0x000b
>   function: 6 (network)
> 
> However, bluecard_cs fails to allocate IO regions.
> 
> Has anybody same similar problems on ARM? Is there anyone working with
> AnyCom CF-300 card?
> 
> I'd appreciate any hint/help that could help me solve this problem.

I saw you discussing this on LKML and this is the right place for
dealing with it, because I don't have ARM experince. Once you got it
working, please report it back here and if there is a patch then send it
to me to merge it mainline.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
