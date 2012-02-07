Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+4RzNn1Qi0_19Q=WxsdKkjZWsMmvyU-bMSosXuM8q3TQ@mail.gmail.com>
References: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com>
	<CAA37ikb_RZixK2dYZa2YED=Z942Uu6=W92_xivNEjPAq+w7cqA@mail.gmail.com>
	<201202070908.45952.szymon.janc@tieto.com>
	<CABBYNZ+4RzNn1Qi0_19Q=WxsdKkjZWsMmvyU-bMSosXuM8q3TQ@mail.gmail.com>
Date: Tue, 7 Feb 2012 09:19:30 -0200
Message-ID: <CAA37ikYOfHfU2U4kgZbijQBF-vEPEZKZ2-qUfn-BB82eNctO0Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 7, 2012 at 8:21 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Szymon,
>
> On Tue, Feb 7, 2012 at 10:08 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>>>
>>> Hmm, maybe we can clear ack timer only once if we check nsent in the
>>> end of l2cap_ertm_send() instead of potentially call it several times?
>>> Not sure if it's worth it or not, though.
>>
>> This is what __l2cap_send_ack is doing  i.e. sends RR frame only if
>> l2cap_ertm_send() returned 0 (or error). Would be good to have this consistent.
>>
>> So maybe just clear ack timer when incrementing nsent for the 1st time?
>>
>> if (!nsent++)
>>        __clear_ack_timer(chan);
>>
>
> But that means we would be clearing ack timer even for retransmit
> frames which Im not sure can be account as an ack?

That's a good point. The retransmitted frames might have an ack, I
think, but only ckecking nsent we won't know that for sure. Thus I do
think the patch from Luiz is better but it's not the right fix IMO.
We'd need to track the last ack sent and then we can check if we have
pending acks.

Seriously, I was wrong suggesting to Luiz that maybe a simple change
in l2cap_ertm_send() to clear ack timer would solve the problem. This
is not true and shows that our code is somewhat messy right now. Let's
try to be more explicit and not rely on implicit conditions or
behavior, please.

Szymon, I've seen you sent patches to handle this before so if you (or
Luiz) could send a patch to introduce tracking of last ack sent it'd
be good. Then we can compute correctly if we have pending acks or not.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
