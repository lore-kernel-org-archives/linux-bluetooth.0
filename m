Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand + socket filtering on zaurus
From: Marcel Holtmann <marcel@holtmann.org>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: "'Bluez-devel@lists.sourceforge.net'" <Bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB7919047093972@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB7919047093972@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1085500110.9779.144.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 25 May 2004 17:48:30 +0200

Hi Matthias,

> I am running bluez / bnep / pan on a zaurus; it works fine.
>  
> But thenI needed to change my kernel (zImage) to get some other
> software running: 
> I had to build in the Socket Filtering    (make menuconfig: Networking
> Options -> Socket Filtering).
> This was the only change I did to the kernel.
>  
> With the new kernel, pand has some problems: I can "pand -s" ( remote
> station does "pand -c <MAC>").
> They can ping. but when the connection is terminated ("pand -K"), no
> matter from which station,
> the zaurus gets frozen. I have to reboot the zaurus.
> Also, I cannot "pand -c <MAC>" from the zaurus side, which works fine
> without the "Socket Filtering" .
>  
> This problem occurs only on zaurus. On my desktop the Socket Filtering
> doesnt interfere with pand.
> But there, I have a completely different kernel (2.4.19) than on
> zaurus (2.4.6), with a different set of 
> kernel build-ins
> Does anybody know, whether "Socket Filtering" requires or forbids some
> other kernel build-ins, 
> in order to work with pand ?

you now that we are already at Linux kernel 2.6.6 ;) The 2.4.6 is so old
that I can't even tell you, if there are problems with your combination.
I stopped testing BNEP with 2.4.18 and you should take an iPAQ with
2.4.19 to check if your combination is there working, too. Maybe it is
an ARM related problem.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
