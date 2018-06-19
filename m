Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+A7VXVT3e832EEF4TQusdM_hsH-wVw_DZyfwC5xxEzC09Vquw@mail.gmail.com>
References: <20180618165739.13126-1-jprvita@endlessm.com> <259476D2-706B-4FA2-86DE-3A6BDCC6B7EC@holtmann.org>
 <CA+A7VXVT3e832EEF4TQusdM_hsH-wVw_DZyfwC5xxEzC09Vquw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Jun 2018 11:14:15 +0300
Message-ID: <CABBYNZLBRUsej-4GWuFSQ_HyvB3x43d9iiC7_5jsYTm=uKn5aQ@mail.gmail.com>
Subject: Re: [PATCH] monitor: Add option to disable SCO packets
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Linux Upstreaming Team <linux@endlessm.com>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Mon, Jun 18, 2018 at 9:57 PM, Jo=C3=A3o Paulo Rechi Vita
<jprvita@gmail.com> wrote:
> Hello Marcel, thanks for the quick reply.
>
> On Mon, Jun 18, 2018 at 10:50 AM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
>>
>> I am confused. I assumed I made SCO off by default.
>>
>
> Dumping the contents for SCO packets is OFF by default (enabled by
> -S), that is, the hex dump part on the output bellow:
>
>   SCO Data RX: Handle 257 flags 0x00 dlen 48
>
>                                                                #3537
> [hci0] 16.106123
>         23 00 2b 00 20 00 06 00 0f 00 21 00 15 00 05 00  #.+. .....!.....
>         1d 00 13 00 ff ff 15 00 1b 00 f8 ff f1 ff 0f 00  ................
>         0f 00 fc ff f3 ff f8 ff f8 ff fa ff 02 00 00 00  ................
>
> But without -S we still log the header / flags part for each packet:
>
>   SCO Data RX: Handle 258 flags 0x00 dlen 48
>
>                                                                #3541
> [hci0] 14.128754
>
>> Anyhow, I don=E2=80=99t want to see tons of independent options. Since n=
ext thing is you tell me that AVDTP media channel is also something you wan=
t to filter out. So then we better find a generic way to apply filters and =
also notifications about =E2=80=9Cdropped x packets due to filter=E2=80=9D =
kinda hints.
>>

We might look at doing this kind of filtering using BPF instead which
perhaps could be loaded from a file.

> My argument behind filtering out SCO is because AFAIU it is only data,
> not signaling. On a quick look I had assumed there was no easy way to
> separate AVDTP signaling from data, but on a second look is actually
> quite obvious, so you are right, that would be an obvious next step
> :-)
>
> Maybe we could hide the SCO and AVDTP media channels by default? In
> this case we could print a notification when the program starts that
> these channels are being suppressed, and / or every time the channel
> is established. That would be reflected on the package count printed
> with the timestamp, and I'm not sure if that would be a problem: is
> that number reflecting how many packets have been exchanged or
> printed?
>
> As much as I like the idea of a generic configurable filter, I can't
> look into that atm.

BPF already works with Bluetooth socket so perhaps we just need a way
to load the filter from file.

@Marcel: We never applied the patch below, are you okay with it:

https://www.spinics.net/lists/linux-bluetooth/msg71245.html

> Regards,
>
> --
> Jo=C3=A3o Paulo Rechi Vita
> http://about.me/jprvita
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
