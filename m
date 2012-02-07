Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201202070908.45952.szymon.janc@tieto.com>
References: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com>
	<CAA37ikb_RZixK2dYZa2YED=Z942Uu6=W92_xivNEjPAq+w7cqA@mail.gmail.com>
	<201202070908.45952.szymon.janc@tieto.com>
Date: Tue, 7 Feb 2012 12:21:30 +0200
Message-ID: <CABBYNZ+4RzNn1Qi0_19Q=WxsdKkjZWsMmvyU-bMSosXuM8q3TQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Ulisses Furquim <ulisses@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Feb 7, 2012 at 10:08 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>>
>> Hmm, maybe we can clear ack timer only once if we check nsent in the
>> end of l2cap_ertm_send() instead of potentially call it several times?
>> Not sure if it's worth it or not, though.
>
> This is what __l2cap_send_ack is doing  i.e. sends RR frame only if
> l2cap_ertm_send() returned 0 (or error). Would be good to have this consistent.
>
> So maybe just clear ack timer when incrementing nsent for the 1st time?
>
> if (!nsent++)
>        __clear_ack_timer(chan);
>

But that means we would be clearing ack timer even for retransmit
frames which Im not sure can be account as an ack?

-- 
Luiz Augusto von Dentz
