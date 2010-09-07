Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Sep 2010 12:12:48 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: check L2CAP length in first ACL fragment
In-Reply-To: <AANLkTinZ6AYd1g0URdYxStfA-4-yd3-5ESagzYLpX4xR@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1009071040450.3317@linux-sea-02>
References: <1283519240-1235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <alpine.DEB.2.00.1009030837330.26179@linux-sea-02> <AANLkTi=bRRKPODUuoKepCRpH_SAJt3nSv=jWUBvDdJi0@mail.gmail.com>
 <AANLkTinZ6AYd1g0URdYxStfA-4-yd3-5ESagzYLpX4xR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Mon, 6 Sep 2010, Andrei Emeltchenko wrote:

> Hi,
>
> On Mon, Sep 6, 2010 at 2:32 PM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
>> Hi,
>>
>> On Fri, Sep 3, 2010 at 7:26 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
>>>> Trace below is received when using stress tools sending big
>>>> fragmented L2CAP packets.
>>>> ...
>>>> [ 1712.798492] swapper: page allocation failure. order:4, mode:0x4020
>>>> [ 1712.804809] [<c0031870>] (unwind_backtrace+0x0/0xdc) from [<c00a1f70>]
>>>> (__alloc_pages_nodemask+0x4)
>>>> [ 1712.814666] [<c00a1f70>] (__alloc_pages_nodemask+0x47c/0x4d4) from
>>>> [<c00a1fd8>] (__get_free_pages+)
>>>> [ 1712.824645] [<c00a1fd8>] (__get_free_pages+0x10/0x3c) from [<c026eb5c>]
>>>> (__alloc_skb+0x4c/0xfc)
>>>> [ 1712.833465] [<c026eb5c>] (__alloc_skb+0x4c/0xfc) from [<bf28c738>]
>>>> (l2cap_recv_acldata+0xf0/0x1f8 )
>>>> [ 1712.843322] [<bf28c738>] (l2cap_recv_acldata+0xf0/0x1f8 [l2cap]) from
>>>> [<bf0094ac>] (hci_rx_task+0x)
>>>> ...
>>>
>>> What is logged right before this allocation failure?  There should be a
>>> "Start: total len %d, frag len %d" line.  Actually, all log messages from
>>> l2cap_recv_acldata leading up to the failure would be helpful.
>>
>> When I enable logs system behave differently because of huge traffic
>> to syslog :-)

Even more reason to suspect that the main bug is something different 
:)

>>>> After applying patch dmesg looks like:
>>>> ...
>>>> l2cap_recv_acldata: Frame exceeding recv MTU (len 64182, MTU 1013)
>>>> l2cap_recv_acldata: Unexpected continuation frame (len 34)
>>>> ...
>>>>
>>>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>>> ---
>>>> net/bluetooth/l2cap.c |   11 +++++++++++
>>>> 1 files changed, 11 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>>>> index 9fad312..21824d7 100644
>>>> --- a/net/bluetooth/l2cap.c
>>>> +++ b/net/bluetooth/l2cap.c
>>>> @@ -4654,6 +4654,8 @@ static int l2cap_recv_acldata(struct hci_conn *hcon,
>>>> struct sk_buff *skb, u16 fl
>>>>
>>>>        if (flags & ACL_START) {
>>>>                struct l2cap_hdr *hdr;
>>>> +               struct sock *sk;
>>>> +               u16 cid;
>>>>                int len;
>>>>
>>>>                if (conn->rx_len) {
>>>> @@ -4672,6 +4674,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon,
>>>> struct sk_buff *skb, u16 fl
>>>> d
>>>>                hdr = (struct l2cap_hdr *) skb->data;
>>>>                len = __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE;
>>>> +               cid = __le16_to_cpu(hdr->cid);
>>>
>>> Some stress tools also send L2CAP data one byte at a time - the start
>>> fragment may not have all four header bytes.  l2cap_recv_acldata() currently
>>> allows short start fragments with two or three bytes, which would not
>>> contain a valid CID.
>>
>> Yes currently we allow 2 bytes in start fragment and check hdr->len.
>> What about following change (require 4 bytes in start fragment)
>>
>> ---------------------------------------------
>> -               if (skb->len < 2) {
>> +               if (skb->len < L2CAP_HDR_SIZE) {
>>                        BT_ERR("Frame is too short (len %d)", skb->len);
>>                        l2cap_conn_unreliable(conn, ECOMM);
>>                        goto drop;
>> ---------------------------------------------

Yes, this check is critical to avoid crashing when receiving a short 
start fragment.  I'm just not sure it's a good idea to reject all 
start fragments less than 4 bytes.

> I have found in "BLUETOOTH SPECIFICATION Version 4.0 [Vol 3] page 36"
>
> "Note: Start Fragments always begin with the Basic L2CAP header of a
> PDU." So the statement above is correct.

I'm still not sure this language guarantees that start frames will 
contain both the length and CID, it doesn't use the word "shall" or 
say it's a complete header.  This may be a theoretical point - 
basebands will not usually send such short start fragments, but I've 
seen stress tools that do.

>>
>>>>                if (len == skb->len) {                        /* 
>>>> Complete frame received */ @@ -4688,6 +4691,14 @@ static int 
>>>> l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, 
>>>> u16 fl                        goto drop;                }
>>>>
>>>> +               sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
>>>
>>> There are several issues here.
>>>
>>> l2cap_get_chan_by_scid() might return NULL, which will definitely happen
>>> with signaling or connectionless data frames.
>>>
>>> l2cap_get_chan_by_scid() also calls bh_lock_sock() if a channel is found,
>>> and I don't see that you added a matching call to bh_unlock_sock() if
>>> l2cap_get_chan_by_scid() returns a non-NULL value.
>>
>> My mistake here. What about following check:
>>
>> ---------------------------------------
>> @@ -3916,6 +3919,19 @@ static int l2cap_recv_acldata(struct hci_conn
>> *hcon, struct sk_buff *skb,
>>                        goto drop;
>>                }
>>
>> +               sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
>> +               if (!sk)
>> +                       goto drop;
>> +
>> +               if (l2cap_pi(sk)->imtu < len) {
>> +                       BT_ERR("Frame exceeding recv MTU (len %d, MTU %d)",
>> +                                       len, l2cap_pi(sk)->imtu);
>> +                       conn->rx_len = 0; /* needed? */
>> +                       bh_unlock_sock(sk);
>> +                       goto drop;
>> +               } else
>> +                       bh_unlock_sock(sk);
>> +
>>                /* Allocate skb for the complete frame (with header) */
>>                conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
>>                if (!conn->rx_skb)
>>
>> --------------------------------------

That fixes the locking issue, but sk is expected to be NULL for valid 
signaling or connectionless data frames and you don't want to drop 
those.

>>
>>>
>>>> +               if (l2cap_pi(sk)->imtu < len) {
>>>> +                       BT_ERR("Frame exceeding recv MTU (len %d, MTU
>>>> %d)",
>>>> +                                       len, l2cap_pi(sk)->imtu);
>>>> +                       conn->rx_len = 0; /* needed? */
>>>> +                       goto drop;
>>>> +               }
>>>> +
>>>>                /* Allocate skb for the complete frame (with header) */
>>>>                conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
>>>>                if (!conn->rx_skb)
>>>
>>> In general, this approach adds an extra channel lookup and an extra
>>> lock/unlock on every ACL start frame.
>>
>> Yes this adds extra lock/unlock but only if the frame is not 
>> complete. There shouldn't be many fragmented L2CAP packets.

Fragmentation of incoming ACL data will be very dependent on the 
baseband firmware, the packet type used over the-air, and L2CAP 
MTU/MPS.  Locking is relatively expensive, so I still have 
reservations.

>>> Even if the MTU is known to be exceeded on with the start frame, 
>>> no more than 64k is ever allocated (which shouldn't cause problems 
>>> in itself).
>>
>> I think that for the mobile device this can be a problem since this
>> shall be contiguous
>> memory.

But it's the same allocation and size constraint used for good L2CAP 
data.  There should be no problem if the allocated skb is reliably 
freed when the bad frame is dropped.

>>> The root of the problem may be heap corruption due to a buffer 
>>> overrun, which seems possible due to the crash deep in the memory 
>>> allocator.


Hope this is helpful!

Regards,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


