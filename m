Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1009071040450.3317@linux-sea-02>
References: <1283519240-1235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<alpine.DEB.2.00.1009030837330.26179@linux-sea-02>
	<AANLkTi=bRRKPODUuoKepCRpH_SAJt3nSv=jWUBvDdJi0@mail.gmail.com>
	<AANLkTinZ6AYd1g0URdYxStfA-4-yd3-5ESagzYLpX4xR@mail.gmail.com>
	<alpine.DEB.2.00.1009071040450.3317@linux-sea-02>
Date: Wed, 8 Sep 2010 11:17:50 +0300
Message-ID: <AANLkTinwPnTzR+0bP4xw6zt9rxr88GZhd5FgczspKUjM@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: check L2CAP length in first ACL fragment
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Mat,

Thanks for good comments.

On Tue, Sep 7, 2010 at 10:12 PM, Mat Martineau <mathewm@codeaurora.org> wro=
te:
>>> On Fri, Sep 3, 2010 at 7:26 PM, Mat Martineau <mathewm@codeaurora.org>
>>> wrote:
>>>>> [ 1712.798492] swapper: page allocation failure. order:4, mode:0x4020
>>>>> [ 1712.804809] [<c0031870>] (unwind_backtrace+0x0/0xdc) from
>>>>> [<c00a1f70>]
>>>>> (__alloc_pages_nodemask+0x4)
>>>>> [ 1712.814666] [<c00a1f70>] (__alloc_pages_nodemask+0x47c/0x4d4) from
>>>>> [<c00a1fd8>] (__get_free_pages+)
>>>>> [ 1712.824645] [<c00a1fd8>] (__get_free_pages+0x10/0x3c) from
>>>>> [<c026eb5c>]
>>>>> (__alloc_skb+0x4c/0xfc)
>>>>> [ 1712.833465] [<c026eb5c>] (__alloc_skb+0x4c/0xfc) from [<bf28c738>]
>>>>> (l2cap_recv_acldata+0xf0/0x1f8 )
>>>>> [ 1712.843322] [<bf28c738>] (l2cap_recv_acldata+0xf0/0x1f8 [l2cap])
>>>>> from
>>>>> [<bf0094ac>] (hci_rx_task+0x)
>>>> What is logged right before this allocation failure? =A0There should b=
e a
>>>> "Start: total len %d, frag len %d" line. =A0Actually, all log messages
>>>> from
>>>> l2cap_recv_acldata leading up to the failure would be helpful.
>>>
>>> When I enable logs system behave differently because of huge traffic
>>> to syslog :-)
>
> Even more reason to suspect that the main bug is something different :)

The bug happens randomly after executing stress tests to BT
(Codenomicon test tools shall do the job). We cannot reproduce the bug
with the single test case.

I think the reason is that memory gets fragmented and kmalloc may fail
and this may be not a bug. There is even special option which suppress
page allocation warnings. For the reference check discussion below:
http://kerneltrap.org/mailarchive/linux-kernel/2008/4/1/1321084

>>>>> After applying patch dmesg looks like:
>>>>> ...
>>>>> l2cap_recv_acldata: Frame exceeding recv MTU (len 64182, MTU 1013)
>>>>> l2cap_recv_acldata: Unexpected continuation frame (len 34)
>>>>> ...
>>>>>
>>>>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>>>> ---
>>>>> net/bluetooth/l2cap.c | =A0 11 +++++++++++
>>>>> 1 files changed, 11 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>>>>> index 9fad312..21824d7 100644
>>>>> --- a/net/bluetooth/l2cap.c
>>>>> +++ b/net/bluetooth/l2cap.c
>>>>> @@ -4654,6 +4654,8 @@ static int l2cap_recv_acldata(struct hci_conn
>>>>> *hcon,
>>>>> struct sk_buff *skb, u16 fl
>>>>>
>>>>> =A0 =A0 =A0 =A0if (flags & ACL_START) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct l2cap_hdr *hdr;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sock *sk;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 cid;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int len;
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (conn->rx_len) {
>>>>> @@ -4672,6 +4674,7 @@ static int l2cap_recv_acldata(struct hci_conn
>>>>> *hcon,
>>>>> struct sk_buff *skb, u16 fl
>>>>> d
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hdr =3D (struct l2cap_hdr *) skb->data=
;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D __le16_to_cpu(hdr->len) + L2CA=
P_HDR_SIZE;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cid =3D __le16_to_cpu(hdr->cid);
>>>>
>>>> Some stress tools also send L2CAP data one byte at a time - the start
>>>> fragment may not have all four header bytes. =A0l2cap_recv_acldata()
>>>> currently
>>>> allows short start fragments with two or three bytes, which would not
>>>> contain a valid CID.
>>>
>>> Yes currently we allow 2 bytes in start fragment and check hdr->len.
>>> What about following change (require 4 bytes in start fragment)
>>>
>>> ---------------------------------------------
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (skb->len < 2) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (skb->len < L2CAP_HDR_SIZE) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BT_ERR("Frame is too sho=
rt (len %d)", skb->len);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_conn_unreliable(co=
nn, ECOMM);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto drop;
>>> ---------------------------------------------
>
> Yes, this check is critical to avoid crashing when receiving a short star=
t
> fragment. =A0I'm just not sure it's a good idea to reject all start fragm=
ents
> less than 4 bytes.
>
>> I have found in "BLUETOOTH SPECIFICATION Version 4.0 [Vol 3] page 36"
>>
>> "Note: Start Fragments always begin with the Basic L2CAP header of a
>> PDU." So the statement above is correct.
>
> I'm still not sure this language guarantees that start frames will contai=
n
> both the length and CID, it doesn't use the word "shall" or say it's a
> complete header. =A0This may be a theoretical point - basebands will not
> usually send such short start fragments,

I have never seen such a small fragments. This is theoretical _&&_
not-recommended case. Moreover I think "always" means all packet shall
have basic L2CAP header.

> but I've seen stress tools that do.

This is one more reason we shall drop such a small packets.

>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (len =3D=3D skb->len) { =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>>>>> Complete frame received */ @@ -4688,6 +4691,14 @@ static int
>>>>> l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto drop; =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0}
>>>>>
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk =3D l2cap_get_chan_by_scid(&conn->ch=
an_list, cid);
>>>>
>>>> There are several issues here.
>>>>
>>>> l2cap_get_chan_by_scid() might return NULL, which will definitely happ=
en
>>>> with signaling or connectionless data frames.
>>>>
>>>> l2cap_get_chan_by_scid() also calls bh_lock_sock() if a channel is
>>>> found,
>>>> and I don't see that you added a matching call to bh_unlock_sock() if
>>>> l2cap_get_chan_by_scid() returns a non-NULL value.
>>>
>>> My mistake here. What about following check:
>>>
>>> ---------------------------------------
>>> @@ -3916,6 +3919,19 @@ static int l2cap_recv_acldata(struct hci_conn
>>> *hcon, struct sk_buff *skb,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto drop;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk =3D l2cap_get_chan_by_scid(&conn->chan=
_list, cid);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!sk)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_pi(sk)->imtu < len) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("Frame exceeding r=
ecv MTU (len %d, MTU
>>> %d)",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 len, l2cap_pi(sk)->imtu);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->rx_len =3D 0; /* ne=
eded? */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bh_unlock_sock(sk);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bh_unlock_sock(sk);
>>> +
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Allocate skb for the complete frame (=
with header) */
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->rx_skb =3D bt_skb_alloc(len, GFP_A=
TOMIC);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!conn->rx_skb)
>>>
>>> --------------------------------------
>
> That fixes the locking issue, but sk is expected to be NULL for valid
> signaling or connectionless data frames and you don't want to drop those.

This is valid point, I have not tested those packet fragmented.

I will modify the patch so that NULL sk goes through and I am thinking
about adding
"l2cap_conn_unreliable(conn, ECOMM)" just before "goto drop"

>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_pi(sk)->imtu < len) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("Frame exceeding=
 recv MTU (len %d, MTU
>>>>> %d)",
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 len, l2cap_pi(sk)->imtu);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->rx_len =3D 0; /* =
needed? */
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>> +
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Allocate skb for the complete frame=
 (with header) */
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->rx_skb =3D bt_skb_alloc(len, GFP=
_ATOMIC);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!conn->rx_skb)
>>>>
>>>> In general, this approach adds an extra channel lookup and an extra
>>>> lock/unlock on every ACL start frame.
>>>
>>> Yes this adds extra lock/unlock but only if the frame is not complete.
>>> There shouldn't be many fragmented L2CAP packets.
>
> Fragmentation of incoming ACL data will be very dependent on the baseband
> firmware, the packet type used over the-air, and L2CAP MTU/MPS. =A0Lockin=
g is
> relatively expensive, so I still have reservations.

I think if we get L2CAP packets fragmented we are already screwed up
and one extra lock does not make a difference.

>>>> Even if the MTU is known to be exceeded on with the start frame, no mo=
re
>>>> than 64k is ever allocated (which shouldn't cause problems in itself).
>>>
>>> I think that for the mobile device this can be a problem since this
>>> shall be contiguous
>>> memory.
>
> But it's the same allocation and size constraint used for good L2CAP data=
.
> =A0There should be no problem if the allocated skb is reliably freed when=
 the
> bad frame is dropped.
>
>>>> The root of the problem may be heap corruption due to a buffer overrun=
,
>>>> which seems possible due to the crash deep in the memory allocator.

Regards,
Andrei
