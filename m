Return-Path: <cyrus@holtmann.org>
Message-ID: <4D832448.4030609@tieto.com>
Date: Fri, 18 Mar 2011 10:22:16 +0100
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Brian Gix <bgix@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
Subject: Re: [PATCH] Bluetooth: Add counter for not acked HCI commands
References: <1299003369-17901-1-git-send-email-andrzej.kaczmarek@tieto.com> <4D6D480E.7080908@codeaurora.org> <4D70DD01.2030003@tieto.com> <4D710F7D.6090905@codeaurora.org> <20110316213020.GC2339@joana> <4D813ECC.10806@codeaurora.org> <20110316232739.GD2339@joana>
In-Reply-To: <20110316232739.GD2339@joana>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 17.03.2011 00:27, Gustavo F. Padovan wrote:
>>> That's exactly how linux stack work, and I'm seeing where we could be doing
>>> wrong, so I believe your patch is fixing nothing. A best version of your
>>> patch is:
>>>
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index cebe7588..2d4d441 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -1771,7 +1771,7 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
>>>           if (ev->opcode != HCI_OP_NOP)
>>>                   del_timer(&hdev->cmd_timer);
>>>
>>> -       if (ev->ncmd) {
>>> +       if (ev->ncmd&&   ev->opcode != HCI_OP_NOP) {
>>>                   atomic_set(&hdev->cmd_cnt, 1);
>>>                   if (!skb_queue_empty(&hdev->cmd_q))
>>>                           tasklet_schedule(&hdev->cmd_task);
>>
>> I don't think that this is correct.
>
> Yes, this is wrong. It's just a simplified version of Andrzej's patch.

No, my patch does not break other scenarios, i.e. the one mentioned by 
Brian ;-)

I agree with him that we can make proper decision in every case only if 
we have both credit and unacked count separately due to asynchronous 
nature of HCI acks. And it's a good point that we do not have to count 
unacked commands but instead just store information whether last sent 
cmd is not yet acked.

I was going to send v2 patch with suggestions from Brian included but I 
didn't get answer whether cmd_cnt has to be atomic_t for some reason 
other than historical. Both acl_cnt and sco_cnt are simple integers, for 
example.

>> Second: How is cmd_cnt being used?  I see it being decremented when a
>> command is sent in hci_cmd_task, or being set to "1" when one of the two
>> events are received. It is also set to "1" for time-outs and channel
>> open/close/reset activities.
>>
>> It looks to me like the cmd_cnt is being misused.  It should in fact be
>> set to the value indicated by the event, and not just "1".  It also does
>> not address the original problem observed by Andrzej, which is that the
>> Asyncronous link between the Host and Baseband can cause them to be
>> momentarily out of sync with each other.
>
> We limit cmd_cnt to 1 in our stack, to be sure that one command a time will be
> sent, I don't for the reason for that but Marcel certainly has one.

Pretty good reason could be that last command sent is stored in hci_dev 
and then used in cc/cs events. I don't have problem with this kind of 
solution, I just think it's not enough here.

I also don't see point of making it a counter while it behaves like a 
weird flag: set to 1, but decrease instead of set to 0. A bit 
inconsistent in my opinion.

BR,
Andrzej
