Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <78338BC4EB35DC488A56F870C94161F1331DF6@si-cmn1.coind.dom>
References: <78338BC4EB35DC488A56F870C94161F1331DF6@si-cmn1.coind.dom>
Date: Wed, 26 Jul 2006 13:34:44 +0200
Message-Id: <1153913684.746.40.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] R:  ARM-linux and multiple USB dongles
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

Hi Francesco,

> I have switched to 2.6 and the dongles now are working. I have been able to plug up to 8 BT dongles on the system using two usb hubs.
> 
> Sometimes, though, we have the same problem. It seems related to the order in which we install the dongles. Maybe there's something wrong with the usb driver...

if you don't need the SCO support then you can load hci_usb with isoc=0
to disable the ISOC transfers.

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
