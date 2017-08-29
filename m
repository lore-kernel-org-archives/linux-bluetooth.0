Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59A52C53.3020209@mail.zabtrans.ru>
References: <59A504D3.6070809@mail.zabtrans.ru> <59A52C53.3020209@mail.zabtrans.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Aug 2017 13:21:23 +0300
Message-ID: <CABBYNZK_oJCjO61zpfuExA5=zwAgoYvhNWuDwr9rH3-uMceAww@mail.gmail.com>
Subject: Re: Not set name from main.conf
To: ProklovAV@mail.zabtrans.ru
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 29, 2017 at 11:56 AM, =D0=9F=D1=80=D0=BE=D0=BA=D0=BB=D0=BE=D0=
=B2 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=92=D0=B0=D0=
=BB=D0=B5=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<ProklovAV@mail.zabtrans.ru> wrote:
>
>> You should probably disable the hostname plugin if you don't want it
>> to set the name and alias, alternatively, you can set a different
>> alias using the Alias property with bluetoothctl or your own tool.
>
>
>
> Why hostname plugin ignore main.conf options?

hostname plugin sets the name automatically based on the hostname of
the system while main.conf would work as a backup in case hostname
service cannot be found, or some other occurred. Botton like is if you
don't want BlueZ to use the hostname as name disable hostname plugin.

> how to disable this plugin? If it is disabled only when compiled bluez, t=
hen
> this is not the best way!

bluetoothd --help:
-P, --noplugin=3DNAME,...     Specify plugins not to load

> How can I set the name assigned without user action, I know of no other w=
ay
> than the main.conf
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
