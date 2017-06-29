Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f612968b-a3c5-c047-80c5-5f3b6ad711ac@gslab.com>
References: <f612968b-a3c5-c047-80c5-5f3b6ad711ac@gslab.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Jun 2017 15:51:21 +0300
Message-ID: <CABBYNZKwMAW91wv1SemxUxMYgQPr6-ymzryr5cACFSs6=Eny4g@mail.gmail.com>
Subject: Re: How to make GATT only accessible over LE connection
To: Ravi Minnikanti <ravi.minnikanti@gslab.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Thu, Jun 29, 2017 at 3:28 PM, Ravi Minnikanti
<ravi.minnikanti@gslab.com> wrote:
> Hello,
>
> I have a GATT service implemented with "encrypt-write" characteristic flags
> on a dual-mode chipset. It works well over a LE connection with AES-CCM
> encryption.
> But, my GATT characteristics are accessible over BR/EDR connection which
> uses a Link key encryption.

It shouldn't make any difference in terms of security, or you are
really referring to 'secure-write' that is the one that would require
the so called LE secure connections.

> Can someone please help me to know, Is there any way I can make my GATT only
> accessible over a LE connection ?

Im not sure having the GATT database behaving differently for the
bearers is a good idea, to start with this makes things like cross
pairing not very reliable since depending on what bearer the
connection comes in we would have to emit service changed cleaning or
restoring the range, those ranges may have CCC subscriptions which
afaik are not bearer specific.

Perhaps a better idea would be to disable GATT over BR/EDR? For that
we could arrange a config option.

> I understand that this cannot be done from bluez and should be done at
> kernel.
>
> Thanks,
>
> Ravi
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
