Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6e0e8b33-84cc-dafd-cf43-dfbe2fc13109@64b.de>
References: <6e0e8b33-84cc-dafd-cf43-dfbe2fc13109@64b.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 4 Aug 2018 08:00:29 +0300
Message-ID: <CABBYNZKHdAYT6nG5BjSRfPiFPn8K_31JhzL+7np18H2NFPY_xg@mail.gmail.com>
Subject: Re: Bug in D-BUS bluez agent API (potentially)
To: =?UTF-8?Q?Bj=C3=B6rn_Hauffe?= <bjoern@64b.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bjorn,

On Fri, Aug 3, 2018 at 5:15 PM, Bj=C3=B6rn Hauffe <bjoern@64b.de> wrote:
> Hello Folks,
>
> i hope this is the right place to report this bug. If i try to pair a
> Bluetooth 4.0 Keyboard with the bluez daemon and the first try wasn't
> successful, the successful try after that won't displayed by the register=
ed
> bluetooth Agent (e.g. GUI). The Pin is still displayed by the Bluetooth t=
ool
> forever. I think the problem is, that the registered reply method is neve=
r
> called by the bluez daemon (over  D-Bus).

I guess you are talking about the method call not reply here, do you
have the daemon logs when that happens? Perhaps you are saying the the
daemon never calls Cancel so the agent stay in DisplayPasskey forever?

> Tested with Bluetooth GUI tool from Ubuntu 18.04.1 and Fedora 28 (Bluez
> 5.49). Also tested with a self written D-Bus based pairing agent.
>
> My hardware for testing: Logitech K850, Microsoft Designer Keyboard
>
>
> Steps to reproduce:
>
> 1. made a pairing try with a bluetooth 4.0 Keyboard, but let it fail (wro=
ng
> pin for example)
>
> 2. the second pin will displayed by the bluetooth tool
>
> 3. enter the new displayed pin correct to successful finish the pairing
> process
>
> 4. you can't see that the pairing process is finish, because the GUI will
> not show any feedback.

What feedback do you expect here, that Paired is set to true?

> 5. open bluetoothctl and check that the keyboard is paired.

Does the keyboard pairs or not?

>
> If i miss something, please let me know.
>
>
> Best regards
>
> Bj=C3=B6rn
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
