Return-Path: <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: Qualification testing - rfcomm
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1057911516.1026.7.camel@pegasus>
References: <001501c3457d$18b63a10$1a01010a@baked>
	<1057911516.1026.7.camel@pegasus>
Content-Type: text/plain
Message-Id: <1058838934.3470.5.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 22 Jul 2003 09:23:23 -0700
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2003-07-11 at 01:18, Marcel Holtmann wrote:
> Hi Daryl,
> 
> > TP/RFC/BV-12-C:
> > "Verify that the IUT handles aggregate flow control correctly when the
> > Tester, acting as a device conforming to Bleutooth version 1.0B, controls
> > the data flow using the Flow Control on/off commands FCon and FCoff. The
> > IUT's device role is of no importance."
> > 
> > The command and console output:
> > 
> > root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> > rctest[362]: Connected
> > rctest[362]: Sending ...
> > rfcomm_recv_mcc: Unknown control type 0x18
> > rfcomm_recv_mcc: Unknown control type 0x28
> > 
> > The IUT does not respond to FCoff with FCoff, and continues sending data. It
> > also does not respond to FCon with FCon. 
> 
> we don't have support for flow control on the entire RFCOMM session. But
> it seems that the FCOFF and FCON should be supported. The attached patch
> implements support for it, but I am not quite sure if it is the right
> way to do this.
Is it mandatory ? I always thought it's optional.

> @@ -1533,6 +1591,9 @@
>  	struct list_head *p, *n;
> 
>  	BT_DBG("session %p state %ld", s, s->state);
> +
> +	if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
> +		return;
> 
>  	list_for_each_safe(p, n, &s->dlcs) {
>  		d = list_entry(p, struct rfcomm_dlc, list);
This part is not ok. We still have to check for timeout. Rest of patch is fine.

Max 
