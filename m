Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <412C5482.3010909@t-online.de>
From: detlef.grittner@t-online.de (Detlef Grittner)
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Pocket PC 2003 and Linux
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 25 Aug 2004 10:57:38 +0200

I have a working connection between a Linux box with SuSE 9.1 (Sitecom 
Bluetooth dongle) and a Pocket PC 2003 HP 5550.
Ping and so on is no problem.

But I found no way to transfer files from the Pocket PC to the Linux box.
The other way round works: I can send any file from my Linux box to the 
Pocket PC via OBEX push.
I have tried to start the obex demon with:
opd --mode OBEX --channel 10 --daemonize --path /tmp --sdp
Although the Pocket PC finds the Linux box, it says there are no known 
services on it.
I have tried kbluetoothd as well and now the Pocket PC claims there is a 
kbtserialchat service on my Linux box. But I have no idea what I can do 
with it on my Pocket PC.
I was able to establish a PAN network. But again, although the Pocket PC 
claims it is working, I have no idea how to use it.

What I want to do is a obex push from the Pocket PC to the Linux box.
Any ideas what am I missing?

Detlef


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
