Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44BB3BFB.80104@free.fr>
References: <44B3F51E.1070009@free.fr> <1152644670.15028.42.camel@localhost>
	<44BB3BFB.80104@free.fr>
Date: Tue, 18 Jul 2006 19:12:03 +0200
Message-Id: <1153242723.21024.15.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Broadcom 2035 SCO question
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

Hi Fabien,

> >> I recently purchased a class 1 "sweex" bluetooth USB dongle.  It has a 
> >> broadcom bcm2035
> >> usb chip( idVendor = 0x0a5c, idProduct = 0x200a). It advertises SCO 
> >> mtu=16, sco packets = 0.
> >> I tryed to use it with SCO, no luck.(I wasn't surprised by that, given 
> >> sco packets = 0) Then i looked at hci usb driver and found it was in the 
> >> blacklist, with HCI_BROKEN_ISOC.
> >>
> >> I then removed it from this list, forced SCO mtu to 48 and packets 
> >> number to 8 by hacking hci_event.c... and guess what, it works !!
> >>
> >> So my question is: shouldn't this product marked as HCI_WRONG_SCO_MTU 
> >> mtu instead of HCI_BROKEN_ISOC?
> > 
> > is it enough to change HCI_BROKEN_ISOC into HCI_WRONG_SCO_MTU to make
> > this work. If yes, then I am happy to submit a patch.
> > 
> 
> Yes. It is not perfect (i have some noise sometimes at startup), but it
> is enough to make it work.
> 
> Please find attached one-line patch for this.

a patch for this is in my tree now.

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
