Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <103e3fa20712130429l1d80c136o4420e6f513c83228@mail.gmail.com>
References: <103e3fa20712130429l1d80c136o4420e6f513c83228@mail.gmail.com>
Date: Thu, 13 Dec 2007 17:04:50 +0100
Message-Id: <1197561890.5644.90.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Strange problem,
	hcitool scan returns nothing	even though it clearly should
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Torbjorn,

> I have a Linux computer using a Linksys USBBT100 (Broadcom chipset). I
> also have a bluetooth-enabled Samsung cellphone.
> 
> I've tested this USB adapter in advance on a Mac and also on a Windows
> machine, so I know it works fine.  It usually detects any cellphone in
> the vicinity, but when I tried it on my OpenSUSE 10.3 (2.6.22 kernel)
> machine running Bluez 3.18, the behavior I see is very strange...
> 
> Whenever I open up the clamshell on my phone, Bluez is able to see the
> phone. But whenever it's closed, then "hcitool scan" sees absolutely
> nothing.
> 
> It's definitely not supposed to be this way, as I've tested the same
> USB adapter on Mac and Windows, and they both see the phone whether
> the clamshell is open or not. As do all other phones.

I would be so sure about that. And in any case, it is not the fault of
BlueZ, because it only reports what the hardware tells it. The Windows
and Mac side maybe does some caching or something.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
