Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030611094056.0b771918@unixmail.qualcomm.com>
Date: Wed, 11 Jun 2003 10:11:23 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, Daryl Van Vorst <daryl@wideray.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: Qualification testing - rfcomm
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1055225608.3057.39.camel@pegasus>
References: <001b01c32ee1$6a949eb0$1a01010a@baked>
	<001b01c32ee1$6a949eb0$1a01010a@baked>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 11:13 PM 6/9/2003, Marcel Holtmann wrote:
>Hi Daryl,
>
>> > But the problem with
>> > 
>> >     Send failed. Resource temporarily unavailable(11)
>> > 
>> > is a problem in the rctest program, because we don't handle 
>> > correctly EAGAIN errors. We should go on and try sending data 
>> > and don't exit with an error message. Maybe it is a good idea 
>> > to put in a select and check for the time when it is safe to 
>> > send the first data packets.
>> 
>> Shouldn't send() block?
>
>yes it should block. I think this problem is introduced with the "wait
>for complete MSC exchange" patch and I am not quite sure where the
>problem is. But the EAGAIN comes from the function sock_alloc_send_skb()
>if I am right. Max, can you please look at it.

Yes, that error comes from sock_alloc_send_skb(). And yes you're right 
it probably has something to do with MSC stuff. However I don't think it's
our bug though. It looks like MSC exchange didn't complete within 30 secs
(ie default SO_SNDTIMEO).

Here is the relevant part of the trace 
> ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 01 00 01 00 
> ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
< ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 01 00 01 00 

See, that's what I meant by incomplete in my prev email. We now always send MSC after UA, 
I mean it's unconditional in the code
                 /* DLC was previously opened by PN request */
                         rfcomm_send_ua(s, dlci);

                        rfcomm_dlc_lock(d);
                        d->state = BT_CONNECTED;
                        d->state_change(d, 0);
                        rfcomm_dlc_unlock(d);

                        rfcomm_send_msc(s, 1, dlci, d->v24_sig);        
But there is no MSC in the trace.

Hold on! I think I found a bug here. We always send MSC when DLC was opened by PN
request but don't send it when DLC was opened by SABM. Ok that would explain it 
(trace doesn't have PN in it). They probably sit there and wait for MSC from us and 
in the mean time send() times out.
Should be fixed now, I'm pushing a one liner fix as we speak :)

Max
