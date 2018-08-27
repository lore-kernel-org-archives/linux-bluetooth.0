Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5B833EBD.8050003@mail.zabtrans.ru>
References: <5B7F662D.5010903@mail.zabtrans.ru> <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
 <5B833EBD.8050003@mail.zabtrans.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Aug 2018 10:24:00 +0300
Message-ID: <CABBYNZKeotBdqAzsKkw-jN4tmcpBdYPC34C-71S4gzCkcdDM3g@mail.gmail.com>
Subject: Re: Problem with StopDiscovery() via dbus-send
To: ProklovAV@mail.zabtrans.ru
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 27, 2018 at 2:58 AM, =D0=9F=D1=80=D0=BE=D0=BA=D0=BB=D0=BE=D0=B2=
 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=92=D0=B0=D0=BB=
=D0=B5=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<ProklovAV@mail.zabtrans.ru> wrote:
> 24.08.2018 16:19, Luiz Augusto von Dentz =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
>>> May be possible to set a default pin code via /etc/bluetooth/main.conf
>>> if it is available, do not make a request for a pin from the command
>>> line? I
>>> think that then #bluetoothctl pair 11:22:33:44:55:66 will be able to wo=
rk
>>> fine.
>>
>>
>> That is something I had in mind, lets see if I can come up with somethin=
g.
>>
>
> Yes. Non-interactive mode needed.
> But I think in bluez 3 was main.conf parameter to specify the default PIN
> code.

Afaik that only works for legacy pairing, normally devices without any
input/output should rely on just works pairing which is what you would
usually see in headset, etc, though that are not always pairable so
you have to switch it on with a button or something like it.

--=20
Luiz Augusto von Dentz
