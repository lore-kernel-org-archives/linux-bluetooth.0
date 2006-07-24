Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20060724T115557-613@post.gmane.org>
References: <loom.20060724T115557-613@post.gmane.org>
Date: Mon, 24 Jul 2006 12:08:43 +0200
Message-Id: <1153735723.4366.4.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Database of MAC addresses
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

Hi Yuriy,

> Can anybody tell me if there is any database of mac addresses ( or some maskes),
> which can be used to determine name of firm manufacture of phone. For example,
> Sony erricson or Siemens. May be, Someone knows another way?

the first three byte of an address (the OUI part) are assigned by the
IEEE. If you provide /var/lib/misc/oui.txt a lot of BlueZ utilities
(including the new D-Bus API) will tell you the company name. However
this doesn't mean that you can easily identify the phone manufacturer.
It is simply not enough.

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
