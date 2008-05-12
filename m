Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <AB09CD12E10BB34DB250D0085DF5A09118882A@BLR-SGM-MSG01.wipro.com>
References: <AB09CD12E10BB34DB250D0085DF5A09118882A@BLR-SGM-MSG01.wipro.com>
Date: Mon, 12 May 2008 15:42:28 +0200
Message-Id: <1210599748.16390.49.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] FW: dbus doubts
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Sundaram,

> I have following queries.
> 
> 1. why there is no response signals for periodic inquiry command(even
> if requested via hcitool pinq)

we issue a PeriodicDiscoveryStarted signal.

> 2. Can we set minor class for more that one type at one method call to
> dbus?
> (like set desktop,server together) 

not via D-Bus, but you can do this via hcid.conf. Setting desktop and
server at the same time is forbidden by the Bluetooth specification and
technically not possible.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
