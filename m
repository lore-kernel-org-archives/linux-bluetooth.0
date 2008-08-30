Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <a1c657a80808280257h681e02bdl6de2e132d9bafc5@mail.gmail.com>
References: <a1c657a80808280257h681e02bdl6de2e132d9bafc5@mail.gmail.com>
Date: Sat, 30 Aug 2008 11:08:46 +0200
Message-Id: <1220087326.7145.38.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] # hcid[246]: Disconnection failed: 0x0c
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

Hi,

> 
>     when i killed the hstest process , i get the "# hcid[246]:
> Disconnection failed: 0x0c" error,
> My platform :
> OMAP5912OSK 
> BT module :
> ST  bt module
> Linux kernel:
> 2.6.18
> 
> I might conclude that the error is from the Bluetooth HCI driver in
> the kernel. The 0x0C indicates that the ST module is in a state that
> can not close the connection, would you give me some comments ? Thank
> you very much !!!

hstest is so old and possibly broken. Actually even your kernel in
question is oo old. Don't use any of these anymore.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
