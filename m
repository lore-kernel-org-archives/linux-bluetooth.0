Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Qualification testing - rfcomm
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1058838934.3470.5.camel@localhost.localdomain>
References: <001501c3457d$18b63a10$1a01010a@baked>
	<1057911516.1026.7.camel@pegasus>
	<1058838934.3470.5.camel@localhost.localdomain>
Message-Id: <1058892413.2854.22.camel@pegasus>
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
Date: 22 Jul 2003 18:46:47 +0200
Content-Type: text/plain

Hi Max,

> > > TP/RFC/BV-12-C:
> > > "Verify that the IUT handles aggregate flow control correctly when the
> > > Tester, acting as a device conforming to Bleutooth version 1.0B, controls
> > > the data flow using the Flow Control on/off commands FCon and FCoff. The
> > > IUT's device role is of no importance."
> > > 
> > > The command and console output:
> > > 
> > > root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> > > rctest[362]: Connected
> > > rctest[362]: Sending ...
> > > rfcomm_recv_mcc: Unknown control type 0x18
> > > rfcomm_recv_mcc: Unknown control type 0x28
> > > 
> > > The IUT does not respond to FCoff with FCoff, and continues sending data. It
> > > also does not respond to FCon with FCon. 
> > 
> > we don't have support for flow control on the entire RFCOMM session. But
> > it seems that the FCOFF and FCON should be supported. The attached patch
> > implements support for it, but I am not quite sure if it is the right
> > way to do this.
> Is it mandatory ? I always thought it's optional.

and I stopped asking this questions ;)

> > @@ -1533,6 +1591,9 @@
> >  	struct list_head *p, *n;
> > 
> >  	BT_DBG("session %p state %ld", s, s->state);
> > +
> > +	if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
> > +		return;
> > 
> >  	list_for_each_safe(p, n, &s->dlcs) {
> >  		d = list_entry(p, struct rfcomm_dlc, list);
> This part is not ok. We still have to check for timeout. Rest of patch is fine.

good point.

diff -urN linux-2.4.22-pre7/net/bluetooth/rfcomm/core.c linux-2.4.22-pre7-mh/net/bluetooth/rfcomm/core.c
--- linux-2.4.22-pre7/net/bluetooth/rfcomm/core.c       Tue Jul 22 18:33:43 2003
+++ linux-2.4.22-pre7-mh/net/bluetooth/rfcomm/core.c    Tue Jul 22 18:37:59 2003
@@ -1540,6 +1598,9 @@
                        __rfcomm_dlc_close(d, ETIMEDOUT);
                        continue;
                }
+
+               if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
+                       continue;
 
                if ((d->state == BT_CONNECTED || d->state == BT_DISCONN) &&
                                d->mscex == RFCOMM_MSCEX_OK)

I think that should do the job. If you agree I will push this change.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
