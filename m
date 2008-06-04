Return-Path: <cyrus@holtmann.org>
Message-ID: <1212566760.48464ce8b1a40@posta.studio.unibo.it>
Date: Wed,  4 Jun 2008 10:06:00 +0200
From: "alessandro.pernafini@studio.unibo.it" <alessandro.pernafini@studio.unibo.it>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] [Bluetooth]Demone pand
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

Hi, perhaps i made a mistake in sending my previous e-mail, so i repost it.

I got a problem i can't solve. When i try to set up a PAN network
with bluez everything goes fine. Now i have to destroy this network and build
another one, where a node PANU of the old network is going to be the NAP of the
new one. When i type
Code:

pand --master --role NAP -sdp --listen

on the old PANU node nothing seems to happen, in fact if i type
Code:

ps auwx | grep pand

it returns only
Code:

1000     31882  0.0  0.0   3004   768 pts/0    S+   12:06   0:00 grep pand

which means that the daemon was not started. Sorry for my awful english, i hope
you could understand and give me some help.





-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
