Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: <bluez-devel@lists.sourceforge.net>
Subject: RE: Qualification testing - rfcomm
Date: Thu, 12 Jun 2003 10:30:11 -0700
Message-ID: <000501c33108$47499590$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
In-Reply-To: <5.1.0.14.2.20030611094056.0b771918@unixmail.qualcomm.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

Below is exactly why the tests were failing (well, incomplete) - the tester
was waiting for an MSC which we never sent. Thanks!

With a little luck there won't be more bugs found in those tests. :) I'll
let you know what the results are when we do another round of tests.

-Daryl.

> Here is the relevant part of the trace 
> > ACL data: handle 0x0001 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> < ACL data: handle 0x0001 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 01 00 01 00 
> > ACL data: handle 0x0001 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> < ACL data: handle 0x0001 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 01 00 01 00 
> 
> See, that's what I meant by incomplete in my prev email. We 
> now always send MSC after UA, 
> I mean it's unconditional in the code
>                  /* DLC was previously opened by PN request */
>                          rfcomm_send_ua(s, dlci);
> 
>                         rfcomm_dlc_lock(d);
>                         d->state = BT_CONNECTED;
>                         d->state_change(d, 0);
>                         rfcomm_dlc_unlock(d);
> 
>                         rfcomm_send_msc(s, 1, dlci, 
> d->v24_sig);        
> But there is no MSC in the trace.
> 
> Hold on! I think I found a bug here. We always send MSC when 
> DLC was opened by PN request but don't send it when DLC was 
> opened by SABM. Ok that would explain it 
> (trace doesn't have PN in it). They probably sit there and 
> wait for MSC from us and 
> in the mean time send() times out.
> Should be fixed now, I'm pushing a one liner fix as we speak :)
> 
> Max
> 
> 
