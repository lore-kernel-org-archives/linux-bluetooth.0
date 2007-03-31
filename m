Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200703302317.37908.andersin@freenet.de>
References: <200703302317.37908.andersin@freenet.de>
Date: Sat, 31 Mar 2007 15:36:18 +0200
Message-Id: <1175348178.5815.244.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Logitech diNovo Desktop: keyboard keys and
	Mouse	buttons
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

Hi Christoph,

> I have a logitech diNovo desktop and connect it directly to my bluetooth 
> adapter in my laptop. I noticed that the F11, F12 and the Refresh button do 
> not work and are not reported by xev. However, hciconfig shows an increase in 
> the RX bytes and acl counters. Does this mean that the keyboard transmits 
> data to the computer? I want to find out if the keyboard is transmitting a 
> keycode, can someone point me to some resources that tell me how to listen in 
> on the traffic.
> 
> I have a similar issue with the mouse buttons, i.e. that they report the same 
> buttons to xev and an evtest program. I want to figure out how to see what 
> the mouse is actually reporting.

when you call hidd and it shows boot-protocol, then this is no wonder.
You need a Linux kernel with HID report mode enabled HIDP module. You
might wanna try the latest 2.6.21-rc5 kernel.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
