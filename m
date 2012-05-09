Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 May 2012 13:20:09 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Fix skb length calculation
In-Reply-To: <20120509184828.GH2362@joana>
Message-ID: <alpine.DEB.2.02.1205091248570.2090@mathewm-linux>
References: <1336569159-4710-1-git-send-email-gustavo@padovan.org> <1336569159-4710-2-git-send-email-gustavo@padovan.org> <alpine.DEB.2.02.1205090754190.2090@mathewm-linux> <20120509184828.GH2362@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Wed, 9 May 2012, Gustavo Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2012-05-09 09:27:18 -0700]:
>
>>
>> Hi Gustavo -
>>
>> On Wed, 9 May 2012, Gustavo Padovan wrote:
>>
>>> When we add a fragment to a skb, len, data_len and truesize fields needs
>>> to be updated.
>>>
>>> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
>>> ---
>>> net/bluetooth/l2cap_core.c |    4 ++++
>>> 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>> index 66a1a55..8d7c6ba 100644
>>> --- a/net/bluetooth/l2cap_core.c
>>> +++ b/net/bluetooth/l2cap_core.c
>>> @@ -1851,6 +1851,10 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
>>> 		sent += count;
>>> 		len  -= count;
>>>
>>> +		skb->len += (*frag)->len;
>>> +		skb->data_len += (*frag)->len;
>>> +		skb->truesize += (*frag)->truesize;
>>> +
>>> 		frag = &(*frag)->next;
>>> 	}
>>>
>>> --
>>> 1.7.10.1
>>
>> Good to hear that MSG_MORE support is in progress!  Is this change
>> necessary to support MSG_MORE, or is it only something you noticed
>> while working on that feature?
>
> Yes, it is needed for MSG_MORE, I need to do proper accounting of 
> the total skb size(skb->len) and its framents(skb->data_len)

Right - so you can check the outgoing MTU size with skb->len while you 
incrementally build the SDU.

>>
>> I think this patch breaks SO_SNDBUF accounting, which uses
>> skb->truesize in the sock_wfree() destructor.
>
> If set truesize here is problem when we call the destructor I can 
> get ride of the truesize calculation here, only len and data_len is 
> enough for me.

It seems like that would work, and also is better in error cases where 
the skb is freed before it gets to hci_queue_acl().

>>
>> For outgoing packets, L2CAP and HCI currently use skb fragments in a
>> non-standard way.  The &skb_shinfo(skb)->frag_list and skb->next
>> pointers are used to group HCI fragments so they are placed in the
>> HCI send queue all at once.  But they are *not* intended to
>> represent a "normal" fragmented skb.
>
> Yes and I don't have this intention, I just want to report the 
> proper skb length to controller and acl headers.
>
>>
>> Once the list of skbs is passed to hci_send_acl(), hci_queue_acl()
>> separates all of the linked skbs before being placing them in the
>> HCI chan->data_q.  Since the driver sees packets coming out of
>> chan->data_q, it only sees unfragmented skbs.  If you change
>> skb->truesize on the first HCI fragment, sk->sk_wmem_alloc will be
>> adjusted for the bytes used by that first fragment plus the bytes
>> used by all of the continuation fragments.  However, all of the
>> later continuation fragments will adjust sk->sk_wmem_alloc too!
>>
>>
>> There are other problems due to the non-standard use of skb
>> fragments by HCI and L2CAP.  One is that it is confusing, and makes
>> changes that *should* work (like this one) instead cause breakage.
>>
>> The big problem is that the skb->next pointer is used for both skb
>> queuing and skb fragment lists.  On top of that, skb clones share
>> the &skb_shinfo(skb)->frag_list pointer - so the continuation
>> fragments and their 'next' pointers are also shared between clones!
>> When hci_queue_acl() puts each fragment in the chan->data_q, the
>> skb->next pointers of the fragments are overwritten.  If there is a
>> clone of the head skb in another queue (like the ERTM tx queue), its
>> fragments get corrupted.  This is why ERTM PDUs must fit in a single
>> HCI fragment, so that no fragment lists are included in the ERTM tx
>> queue.  Some devices (especially USB) have very short HCI MTUs,
>> which makes ERTM much less efficient on those devices.
>>
>>
>> I see these options:
>>
>>  * Add comments to explain non-standard use of skb fragments
>>
>>  * Keep your change above, but also modify hci_queue_acl() to
>> rewrite the len, data_len, and truesize values of the head skb
>> before queueing it.
>
> I think len and data_len is enough, we don't need to touch truesize 
> here. Then on hci_queue_acl() we just set skb->len to skb_headlen() 
> and skb->data_len to 0. That fixes everything and no modification on 
> drivers will be needed.

Ok.  A few comments where skb->len and skb->data_len are adjusted 
would also be great so we don't all forget what is going on!

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

