Return-Path: <cyrus@holtmann.org>
Message-ID: <4F482993.4030104@codeaurora.org>
Date: Fri, 24 Feb 2012 16:21:39 -0800
From: Mat Martineau <mathewm@codeaurora.org>
MIME-Version: 1.0
To: Ulisses Furquim <ulisses@profusion.mobi>,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
CC: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org, luiz.dentz@gmail.com
Subject: Re: [RFC 1/2] Bluetooth: Header changes for ERTM state machine replacement
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org> <1330029469-8565-2-git-send-email-mathewm@codeaurora.org> <20120224094842.GA4013@aemeltch-MOBL1> <CAA37ikYYGoYcOg5PD98QZt04NjzUWhi6AQVgh2eGYy94vWPQ=g@mail.gmail.com>
In-Reply-To: <CAA37ikYYGoYcOg5PD98QZt04NjzUWhi6AQVgh2eGYy94vWPQ=g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Andrei and Ulisses -

On 2/24/2012 9:42 AM, Ulisses Furquim wrote:
> Hi Andrei,
>
> On Fri, Feb 24, 2012 at 7:48 AM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com>  wrote:
>> Hi Mat,
>>
>> It is better to have normal patches for a better review.

I would have preferred to have more "normal" patches, but I didn't want 
to keep you guys waiting another week.

>> I think that we can minimize amount of changes by redefining defines
>> when they cannot be used.

Do you mean that it would be better to modify existing macros rather 
than remove them?

>>
>> I also think think that patches shall be logically split like:
>> - change control field handling
>> - working with FCS, etc which do not affect state machine
>> - adding states

Sounds like a good way to divide things up.

>>
>> Also check some comments below: (I copied some code from the link you sent)
>>
>> On Thu, Feb 23, 2012 at 12:37:48PM -0800, Mat Martineau wrote:
>>> This change affects data structures storing ERTM state and control
>>> fields, and adds new definitions for states and events.  An
>>> l2cap_seq_list structure is added for tracking ERTM sequence numbers
>>> without repeated memory allocations.  Control fields are carried in
>>> the bt_skb_cb struct rather than constantly doing shift and mask
>>> operations.
>>>
>>> Signed-off-by: Mat Martineau<mathewm@codeaurora.org>
>>> ---
>>>   include/net/bluetooth/bluetooth.h |   14 ++-
>>>   include/net/bluetooth/l2cap.h     |  260 +++++++++----------------------------
>>>   2 files changed, 73 insertions(+), 201 deletions(-)
>>
>> ...
>>
>>> -static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
>>> -{
>>> -     int sub;
>>> -
>>> -     sub = (ch->next_tx_seq - ch->expected_ack_seq) % 64;
>>> -
>>> -     if (sub<  0)
>>> -             sub += 64;
>>> -
>>> -     return sub == ch->remote_tx_win;
>>> -}
>>
>> BTW: was it already changed? What is the status with Luiz's patch?

I'm not sure about the patch status - but I do know this function isn't 
needed with the new ERTM code.

>>
>> ...
>>
>>> -static inline __u32 __get_control(struct l2cap_chan *chan, void *p)
>>> -{
>>> -     if (test_bit(FLAG_EXT_CTRL,&chan->flags))
>>> -             return get_unaligned_le32(p);
>>> -     else
>>> -             return get_unaligned_le16(p);
>>> -}
>>
>> Cannot it still be used?

It's not needed.  The control header is only parsed in one place now at 
the beginning of l2cap_ertm_data_rcv(), and this macro isn't a good fit 
for the code there.

>>
>> +       if (test_bit(FLAG_EXT_CTRL,&chan->flags)) {
>> +               __get_extended_control(get_unaligned_le32(skb->data),
>> +                                      control);
>> +               skb_pull(skb, L2CAP_EXT_CTRL_SIZE);
>> +       } else {
>> +               __get_enhanced_control(get_unaligned_le16(skb->data),
>> +                                      control);
>> +               skb_pull(skb, L2CAP_ENH_CTRL_SIZE);
>> +       }
>>
>> -       control = __get_control(chan, skb->data);
>> -       skb_pull(skb, __ctrl_size(chan));
>>
>> ...
>>
>>> -static inline void __put_control(struct l2cap_chan *chan, __u32 control,
>>> -                                                             void *p)
>>> -{
>>> -     if (test_bit(FLAG_EXT_CTRL,&chan->flags))
>>> -             return put_unaligned_le32(control, p);
>>> -     else
>>> -             return put_unaligned_le16(control, p);
>>> -}
>>
>> Can it be used in the code below:
>>
>> +               if (test_bit(FLAG_EXT_CTRL,&chan->flags)) {
>> +                       put_unaligned_le32(__pack_extended_control(control),
>> +                                       skb->data + L2CAP_HDR_SIZE);
>> +               } else {
>> +                       put_unaligned_le16(__pack_enhanced_control(control),
>> +                                       skb->data + L2CAP_HDR_SIZE);
>> +               }
>>

Since the __pack function differs based on the extended/enhanced header 
type, it doesn't seem worthwhile to check FLAG_EXT_CTRL twice.

The code I'm porting in predates the __put_control macro, so I didn't 
make an effort to remove it.  In order to avoid breaking things, I'm 
trying to only change the ported code where required.  I'm open to 
making this code better, though!

>> and for example here:
>>
>> -       __put_control(chan, control, skb_put(skb, __ctrl_size(chan)));
>> +       /* Control header is populated later */
>> +       if (test_bit(FLAG_EXT_CTRL,&chan->flags))
>> +               put_unaligned_le32(0, skb_put(skb, 4));
>> +       else
>> +               put_unaligned_le16(0, skb_put(skb, 2));

This is the only place the macro would drop in cleanly - but it seems 
like a macro should be used in more than one place unless it's hiding 
some really distracting syntax.  In this case, I think it's clearer to 
see what's going on.

And - I forgot to fix some magic numbers in those skb_puts.

>>
>>> -
>>> -static inline __u8 __ctrl_size(struct l2cap_chan *chan)
>>> -{
>>> -     if (test_bit(FLAG_EXT_CTRL,&chan->flags))
>>> -             return L2CAP_EXT_HDR_SIZE - L2CAP_HDR_SIZE;
>>> -     else
>>> -             return L2CAP_ENH_HDR_SIZE - L2CAP_HDR_SIZE;
>>> -}
>
> Do we have that many places with this test in Mat's code? If not, then
> we might not need to bother having all of these helpers, I think. And
> if we add them, I do think it makes sense to add them to l2cap_core.c
> than in l2cap.h, right?

Not too many places with the FLAG_EXT_CTRL test, with use of struct 
bt_control in most of the code.  I would rather have helpers in 
l2cap_core.c if they're needed.


Thanks for the reviews!

-- 
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
