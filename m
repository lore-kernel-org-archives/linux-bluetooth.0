Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Soft lockup
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060224110357.GT19185@null.research.nokia.com>
References: <20060222091231.GM19185@null.research.nokia.com>
	 <1140607245.4519.7.camel@localhost>
	 <20060222125425.GQ19185@null.research.nokia.com>
	 <20060224110357.GT19185@null.research.nokia.com>
Content-Type: text/plain
Message-Id: <1141188501.29216.1.camel@localhost>
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
Date: Wed, 01 Mar 2006 05:48:21 +0100

Hi Ville,

> Now I have more information about this problem.
> 
> I had debuggin enabled in net/bluetooth/rfcomm/core.c and I noticed that
> for some reson rfcomm_dlc_clear_timer() is called for allready freed
> dlc and lock_timer_base() gets stuck because it's trying to use invalid
> timer pointer. I also tried to reproduce bug in i386 without success.
> Also then debugging is on the bug much harder to reproduse. To me this
> looks like dlc locking doens't work as it should work.
> 
> And other notice. rfcomm_dlc_clear_timeri() uses timer_pending()
> together with del_timer() which allready calls timer_pending(). So
> timer_pending() is useless in rfcomm_dlc_clear_timer().

this all looks like we are missing a memory barrier somewhere. This
could also be the reason why it only gets triggered on OMAP systems. Any
further ideas?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
