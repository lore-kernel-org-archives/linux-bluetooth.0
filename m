Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Re: Re: hciattach problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <420BBA0B.5090405@web.de>
References: <420BBA0B.5090405@web.de>
Content-Type: text/plain
Message-Id: <1108065658.15974.126.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 10 Feb 2005 21:00:58 +0100

Hi Andreas,

> >please try 2.6.11-rc3-bk7 and what does "modinfo bluetooth" say?
> modinfo bluetooth:
> filename:       /lib/modules/2.6.10-mh3/kernel/net/bluetooth/bluetooth.ko
> author:         Maxim Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann 
> <marcel@holtmann.org>
> description:    Bluetooth Core ver 2.7
> version:        2.7
> license:        GPL
> alias:          net-pf-31
> vermagic:       2.6.10-mh3 PENTIUMIII REGPARM gcc-3.3
> depends:
> srcversion:     DAE2F0A0D8CBDE079A024DB
> 
> I will try 2.6.11-rc3-bk7.

so no SMP and no PREEMPT. This means that this can't be a deadlock and
there should be no problem, but you can try to disable the REGPARM.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
