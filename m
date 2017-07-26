Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5977D982.5070808@mail.zabtrans.ru>
References: <5977D982.5070808@mail.zabtrans.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 26 Jul 2017 11:05:19 +0300
Message-ID: <CABBYNZ+GSc0_QvmOLdknYpv-Y6Gvcb6oEQf2AFUc_ZHWqZBZjw@mail.gmail.com>
Subject: Re: Problem with StopDiscovery() via dbus-send
To: ProklovAV@mail.zabtrans.ru
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aleksandr,

On Wed, Jul 26, 2017 at 2:51 AM, =D0=9F=D1=80=D0=BE=D0=BA=D0=BB=D0=BE=D0=B2=
 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=92=D0=B0=D0=BB=
=D0=B5=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<ProklovAV@mail.zabtrans.ru> wrote:
>  Hello All,
>
> I'm trying to manage Bluetooth using dbus-send command,
>
> I send command for start discovery:
> dbus-send --system --reply-timeout=3D5000 --type=3Dmethod_call --dest=3Do=
rg.bluez
> /org/bluez/hci0 org.bluez.Adapter1.StartDiscovery

dbus-send exists so that would stop the discovery is there is no other
process discovering.

> I see that the scan started, the status is true:
> dbus-send --system --print-reply --dest=3Dorg.bluez --type=3Dmethod_call
> /org/bluez/hci0 org.freedesktop.DBus.Properties.Get
> string:org.bluez.Adapter1 string:Discovering
>
> But I can not stop scanning by a command:
> dbus-send --system --reply-timeout=3D5000 --type=3Dmethod_call --dest=3Do=
rg.bluez
> /org/bluez/hci0 org.bluez.Adapter1.StopDiscovery

It probably has been stopped already since the connection used for
StartDiscovery has been terminated. Btw, there are better tools to
test this, for instance bluetoothctl> scan [on/off]

> "Discovering" status true.
>
> Bluez version 5.45
>
> ---------------------
> Best regards,
> Aleksandr Proklov
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
