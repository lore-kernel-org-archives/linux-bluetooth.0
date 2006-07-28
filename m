Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44C9DB62.1000103@kernelconcepts.de>
Date: Fri, 28 Jul 2006 11:39:46 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: Bearcat@feline-soul.com
References: <44C8FB2F.9070403@kernelconcepts.de>
	<20060727185006.69823.qmail@web27915.mail.ukl.yahoo.com>
	<1171.216.47.50.125.1154031396.squirrel@webmail.feline-soul.net>
In-Reply-To: <1171.216.47.50.125.1154031396.squirrel@webmail.feline-soul.net>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
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

Bearcat M. Sandor schrieb:
> Wolfram, Nils,
Hi!

> No such luck for me yet. Strangly the hcitool does not allow the auth
> option for me. I had to do a hciconfig /dev/usb/hci0 auth to turn the auth
> on the hub. Auth is now on but the keyboard still doesn't connect. As
> usuall nothing is reported in the syslogs.
> 
> Do i need to turn on the auth for the keyboard too (is that even an option)?

No, the keyboard will require that automatically.

> I am never prompted for a pin and even if i was, i don't know what it
> would be. Is the pin connected to the keyboard, the hub (should i find out
> from logitech what their default is) or is it a pin kept by bluez?

The problem is that the keyboards I have seen so far require that you
input the PIN on the keyboard first and then you will be prompted to
second this on the desktop PC.
So what might happen at your side now is that the keyboard is waiting
for the PIN to be input.
Maybe try again and try to connect to the keyboard using hidd then type
in a PIN code on the keyboard and press ENTER. If you are lucky the
dialog the pops up.

> Also, i don't have a program called hcidump. Is that part of the bluez
> package?

In Debian it is a seperate package but it belongs to the BlueZ project.

> Thanks all,
> Bearcat
Cheers
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
--

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
