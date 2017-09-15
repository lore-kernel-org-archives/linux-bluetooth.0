Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59BB4845.60808@mail.zabtrans.ru>
References: <59BB4845.60808@mail.zabtrans.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Sep 2017 09:27:33 +0300
Message-ID: <CABBYNZLAqZqsavif1mfWR6vM_u6i1Eo_P1ogK5=6APD56ey3jQ@mail.gmail.com>
Subject: Re: Problem with StopDiscovery() via dbus-send
To: ProklovAV@mail.zabtrans.ru
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aleksandr,

On Fri, Sep 15, 2017 at 6:25 AM, =D0=9F=D1=80=D0=BE=D0=BA=D0=BB=D0=BE=D0=B2=
 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=92=D0=B0=D0=BB=
=D0=B5=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<ProklovAV@mail.zabtrans.ru> wrote:
>  Hello All,
>
> Maybe it's a bug?
>
> I'm trying to manage Bluetooth using dbus-send command,
> I send command for start discovery:
> dbus-send --system --reply-timeout=3D5000 --type=3Dmethod_call --dest=3Do=
rg.bluez
> /org/bluez/hci0 org.bluez.Adapter1.StartDiscovery

dbus-send disconnects from the bus so the discovery is stopped because
there is no client to report the devices found.

>
> Discovery process NOT stop!!! in btmgmt i see:
> hci0 type 7 discovering off
> hci0 type 7 discovering on
> hci0 type 7 discovering off
> hci0 type 7 discovering on
> hci0 type 7 discovering off
> hci0 type 7 discovering on
>
> and it goes on continuously!
> How can I stop the search process? "StopDiscovery" not work from dbus-sen=
d
> command.
>
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
