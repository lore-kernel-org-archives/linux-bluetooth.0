Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Bearcat@feline-soul.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1171.216.47.50.125.1154031396.squirrel@webmail.feline-soul.net>
References: <44C8FB2F.9070403@kernelconcepts.de>
	<20060727185006.69823.qmail@web27915.mail.ukl.yahoo.com>
	<1171.216.47.50.125.1154031396.squirrel@webmail.feline-soul.net>
Date: Fri, 28 Jul 2006 03:22:05 +0200
Message-Id: <1154049725.7650.8.camel@localhost>
Mime-Version: 1.0
Cc: Nils Faerber <nils.faerber@kernelconcepts.de>
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Bearcat,

> No such luck for me yet. Strangly the hcitool does not allow the auth
> option for me. I had to do a hciconfig /dev/usb/hci0 auth to turn the auth
> on the hub. Auth is now on but the keyboard still doesn't connect. As
> usuall nothing is reported in the syslogs.
> 
> Do i need to turn on the auth for the keyboard too (is that even an option)?
> 
> I am never prompted for a pin and even if i was, i don't know what it
> would be. Is the pin connected to the keyboard, the hub (should i find out
> from logitech what their default is) or is it a pin kept by bluez?
> 
> Also, i don't have a program called hcidump. Is that part of the bluez
> package?

it is in bluez-hcidump and you should start using it. Otherwise you are
starting to speculate and this doesn't help.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
