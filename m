Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <597938D3.1070902@mail.zabtrans.ru>
References: <5977D982.5070808@mail.zabtrans.ru> <CABBYNZ+GSc0_QvmOLdknYpv-Y6Gvcb6oEQf2AFUc_ZHWqZBZjw@mail.gmail.com>
 <597938D3.1070902@mail.zabtrans.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Jul 2017 14:33:06 +0300
Message-ID: <CABBYNZKqH2zvfW=77ZouuR_AHqdq9md3OGqAxuancrL1XtBPNQ@mail.gmail.com>
Subject: Re: Problem with StopDiscovery() via dbus-send
To: ProklovAV@mail.zabtrans.ru
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 27, 2017 at 3:50 AM, =D0=9F=D1=80=D0=BE=D0=BA=D0=BB=D0=BE=D0=B2=
 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=92=D0=B0=D0=BB=
=D0=B5=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<ProklovAV@mail.zabtrans.ru> wrote:
> 26.07.2017 16:05, Luiz Augusto von Dentz wrote:
>
>> It probably has been stopped already since the connection used for
>> StartDiscovery has been terminated. Btw, there are better tools to
>> test this, for instance bluetoothctl> scan [on/off]
>>
>
> If the process "StartDiscovery" is stopped, why status "Discovering" not
> changed to "false"?

It may take some time until it has been stopped completely, but the
sessions is already released, and even if you could in fact leave it
running the next time you call dbus-sent it would create a new
connection so calling StopDiscovery will fail nevertheless.

> I need to start and stop scanning from the Bash script, bluetoothctl has =
the
> ability to manage from Bash scripts?

Currently it only runs in interactive mode, but it would have the same
result since the D-Bus connection would be lost in between runs of
bluetoothctl.

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
