Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Qualification testing - rfcomm
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030722103927.09737068@unixmail.qualcomm.com>
References: <1058838934.3470.5.camel@localhost.localdomain>
	<001501c3457d$18b63a10$1a01010a@baked> <1057911516.1026.7.camel@pegasus>
	<1058838934.3470.5.camel@localhost.localdomain>
	<5.1.0.14.2.20030722103927.09737068@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1058901208.2755.36.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 22 Jul 2003 21:13:10 +0200

Hi Max,

> >diff -urN linux-2.4.22-pre7/net/bluetooth/rfcomm/core.c linux-2.4.22-pre7-mh/net/bluetooth/rfcomm/core.c
> >--- linux-2.4.22-pre7/net/bluetooth/rfcomm/core.c       Tue Jul 22 18:33:43 2003
> >+++ linux-2.4.22-pre7-mh/net/bluetooth/rfcomm/core.c    Tue Jul 22 18:37:59 2003
> >@@ -1540,6 +1598,9 @@
> >                        __rfcomm_dlc_close(d, ETIMEDOUT);
> >                        continue;
> >                }
> >+
> >+               if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
> >+                       continue;
> > 
> >                if ((d->state == BT_CONNECTED || d->state == BT_DISCONN) &&
> >                                d->mscex == RFCOMM_MSCEX_OK)
> >
> >I think that should do the job. If you agree I will push this change.
> 
> Yep. This one is ok.

you can pull it for 2.4 and 2.5

 net/bluetooth/rfcomm/core.c |   61 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+)

through these ChangeSets:

<marcel@holtmann.org> (03/07/22 1.1083)
   [Bluetooth] Add support for FCon and FCoff flow control commands
   
   This patch adds flow control support using FCon and FCoff commands
   to fulfil the requirements of the Bluetooth specification.





-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
