Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4510A272.6000402@vasmac.com>
References: <4510A272.6000402@vasmac.com>
Date: Mon, 25 Sep 2006 23:51:51 +0200
Message-Id: <1159221111.20997.28.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SCO flow control patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jose,

> Last May, Fabien Chevalier posted some SCO flow control patches
> (now included in bluetooth-alsa). I've tried these in Ubuntu 6.06
> (based on kernel 2.6.15.7) without much luck. My problem is that
> packets are sent every 50ms. Anyone else tried these?
> 
> I do agree that it should be the responsibility of the driver to take
> care of any timing issues. But it's not clear to me why this is not
> done in the hci_usb driver.

he never sent any updated versions of them. Feel free to pick them up
and send me new patches.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
