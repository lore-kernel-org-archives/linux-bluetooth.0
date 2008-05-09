Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <a7bd466f0804301759v37b6c732t59a85cf94998291c@mail.gmail.com>
References: <a7bd466f0804301759v37b6c732t59a85cf94998291c@mail.gmail.com>
Date: Fri, 09 May 2008 14:42:13 +0200
Message-Id: <1210336933.28002.35.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Usage of BondingCreated()
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

Hi Biranchi,

>      I am new to Bluez and dbus.I am trying to get the pairing status
> of a device.
>      I think I can use the Signals from the Dbus daemon when a pairing
> is done using
> BondingCreated().
>   But I am not sure how to connect to a dbus daemon and how to pass
> the
> BondingCreated() method to the daemon to get the status.

check the dbus.freedesktop.org or wiki.bluez.org for details on how to
use D-Bus.
 
>    If anyone has used BondingCreated() to find out the pairing status,
> please let 
> me know abou it. 

It is a signal. So you can call it. You have to us HasBonding() method.

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
