Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201202071221.51920.szymon.janc@tieto.com>
References: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com>
	<201202070908.45952.szymon.janc@tieto.com>
	<CABBYNZ+4RzNn1Qi0_19Q=WxsdKkjZWsMmvyU-bMSosXuM8q3TQ@mail.gmail.com>
	<201202071221.51920.szymon.janc@tieto.com>
Date: Tue, 7 Feb 2012 09:27:24 -0200
Message-ID: <CAA37ikZSaELhgHmU53jYA==B-11PPiAxVnKxuEjHQMaQiddZCw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Feb 7, 2012 at 9:21 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi,
>
>> >> Hmm, maybe we can clear ack timer only once if we check nsent in the
>> >> end of l2cap_ertm_send() instead of potentially call it several times?
>> >> Not sure if it's worth it or not, though.
>> >
>> > This is what __l2cap_send_ack is doing  i.e. sends RR frame only if
>> > l2cap_ertm_send() returned 0 (or error). Would be good to have this consistent.
>> >
>> > So maybe just clear ack timer when incrementing nsent for the 1st time?
>> >
>> > if (!nsent++)
>> >        __clear_ack_timer(chan);
>> >
>>
>> But that means we would be clearing ack timer even for retransmit
>> frames which Im not sure can be account as an ack?
>
> Right, only pending I-frame(s) is an acknowledgement. But that means
> __l2cap_send_ack() is broken.

Yes, it is broken because it was relying on l2cap_ertm_send()
returning if it sent any i-frame with an ack. And that wasn't
documented anywhere AFAIK and it's very easy for someone else to add a
change that breaks this assumption.

> To fix that, I think l2cap_ertm_send should return number of pending I-frames
> transmitted, not a total number of I-frames sent.

Why? Have you checked if other part of the code relies on
l2cap_ertm_send() returning number of I-frames sent?

> I've quickly looked over the code and that change should be OK.
>
> What do you think?

I've already answered in my other e-mail. I'd like to see us tracking
what we already acked and then easily check if we need to send an ack
or not.

> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 09cd860..8dece4e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1448,17 +1448,19 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
>
>                chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
>
> -               if (bt_cb(skb)->retries == 1)
> +               if (bt_cb(skb)->retries == 1) {
>                        chan->unacked_frames++;
>
> +                       if (!nsent++)
> +                               __clear_ack_timer(chan);
> +               }
> +
>                chan->frames_sent++;
>
>                if (skb_queue_is_last(&chan->tx_q, skb))
>                        chan->tx_send_head = NULL;
>                else
>                        chan->tx_send_head = skb_queue_next(&chan->tx_q, skb);
> -
> -               nsent++;
>        }
>
>        return nsent;

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
