Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030722103927.09737068@unixmail.qualcomm.com>
Date: Tue, 22 Jul 2003 10:40:57 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: Qualification testing - rfcomm
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1058892413.2854.22.camel@pegasus>
References: <1058838934.3470.5.camel@localhost.localdomain>
	<001501c3457d$18b63a10$1a01010a@baked> <1057911516.1026.7.camel@pegasus>
	<1058838934.3470.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 09:46 AM 7/22/2003, Marcel Holtmann wrote:
>> > @@ -1533,6 +1591,9 @@
>> >     struct list_head *p, *n;
>> > 
>> >     BT_DBG("session %p state %ld", s, s->state);
>> > +
>> > +   if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
>> > +           return;
>> > 
>> >     list_for_each_safe(p, n, &s->dlcs) {
>> >             d = list_entry(p, struct rfcomm_dlc, list);
>> This part is not ok. We still have to check for timeout. Rest of patch is fine.
>
>good point.
>
>diff -urN linux-2.4.22-pre7/net/bluetooth/rfcomm/core.c linux-2.4.22-pre7-mh/net/bluetooth/rfcomm/core.c
>--- linux-2.4.22-pre7/net/bluetooth/rfcomm/core.c       Tue Jul 22 18:33:43 2003
>+++ linux-2.4.22-pre7-mh/net/bluetooth/rfcomm/core.c    Tue Jul 22 18:37:59 2003
>@@ -1540,6 +1598,9 @@
>                        __rfcomm_dlc_close(d, ETIMEDOUT);
>                        continue;
>                }
>+
>+               if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
>+                       continue;
> 
>                if ((d->state == BT_CONNECTED || d->state == BT_DISCONN) &&
>                                d->mscex == RFCOMM_MSCEX_OK)
>
>I think that should do the job. If you agree I will push this change.

Yep. This one is ok.

Max
