Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <db89df390607271105h5b11d1afj803c42ef42e3a70b@mail.gmail.com>
References: <db89df390607271105h5b11d1afj803c42ef42e3a70b@mail.gmail.com>
Date: Thu, 27 Jul 2006 20:38:27 +0200
Message-Id: <1154025507.9543.39.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez usb
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

Hi Henry,

> I am using HCI RAW socket to communicate with a bluetooth device. I
> was able to do cmd/event between the host and the device. I am able to
> receive ACL data from the raw socket too. However, I can not send ACL
> data. I looked into the hci_usb.c and found that after it submit the
> ACL data by
> usb_submit_urb using bulk mode, it never completed. Any hints?

simply don't try to send ACL data. Use the L2CAP layer instead.

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
