Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <50287825.52691.1513592889715.JavaMail.zimbra@karlsbakk.net>
References: <50287825.52691.1513592889715.JavaMail.zimbra@karlsbakk.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Dec 2017 10:37:06 -0200
Message-ID: <CABBYNZKh_7MEVktwcEtRjm_+98FTfNJiM96R1dOuFCO3mg6KkA@mail.gmail.com>
Subject: Re: Setting a static pin to allow pairing
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Roy,

On Mon, Dec 18, 2017 at 8:28 AM, Roy Sigurd Karlsbakk <roy@karlsbakk.net> w=
rote:
> Hi all
>
> I'm trying to setup a raspberry pi as a bluetooth host allowing pairing f=
rom a phone, but with a predefined pincode, and I can't find any docs on ho=
w to do this. I find some on how to do this interactively, but then, this i=
sn't meant to be used like that, more like a "blackbox". I've tried to goog=
le this quite a bit and reading the docs, but I can't find much. Any idea h=
ow to do this?

With SSP, introduced in Bluetooth 2.1, there is no longer a need to
have predefined pincode. In case that you don't have any means to
confirm you should be able to use "NoInputNoOutput", you can check how
this is done in bluetoothctl:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/main.c#n1049

> Also, what I'm trying to end up with, is allowing the pi to place a call =
through the phone over bluetooth. I haven't managed to find much docs on th=
is either. Bluetooth on linux is quite a new experience (although I've used=
 Linux for >20 years), so thanks for any help

You will need a telephony stack such as oFono to do that:
https://github.com/intgr/ofono/blob/master/doc/hfp-overview.txt

In case you are using PulseAudio here is how to setup:
https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Blu=
etooth/#index5h2

>
> Vennlig hilsen
>
> roy
> --
> Roy Sigurd Karlsbakk
> (+47) 98013356
> http://blogg.karlsbakk.net/
> GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
> --
> Hi=C3=B0 g=C3=B3=C3=B0a skaltu =C3=AD stein h=C3=B6ggva, hi=C3=B0 illa =
=C3=AD snj=C3=B3 rita.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
