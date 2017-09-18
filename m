Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59BF3492.3080503@mail.zabtrans.ru>
References: <59BB4845.60808@mail.zabtrans.ru> <CABBYNZLAqZqsavif1mfWR6vM_u6i1Eo_P1ogK5=6APD56ey3jQ@mail.gmail.com>
 <59BB90DD.1040408@mail.zabtrans.ru> <CABBYNZJQRH75iaddKeNFJXqSwWqAxhRjLYHddAuMhxVq_T1V+A@mail.gmail.com>
 <59BF3492.3080503@mail.zabtrans.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Sep 2017 09:53:40 +0300
Message-ID: <CABBYNZLyL4r1b=Kv77uB7dND2M6MUzQ_H3sdDdi-daR1YtHyGw@mail.gmail.com>
Subject: Re: Problem with StopDiscovery() via dbus-send
To: ProklovAV@mail.zabtrans.ru
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 18, 2017 at 5:50 AM, =D0=9F=D1=80=D0=BE=D0=BA=D0=BB=D0=BE=D0=B2=
 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=92=D0=B0=D0=BB=
=D0=B5=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<ProklovAV@mail.zabtrans.ru> wrote:
> 15.09.2017 16:46, Luiz Augusto von Dentz =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> Ive just a set of patches adressing race condition with StartDiscovery
>> and StopDiscovery, please have a try. Also it is not a good idea to
>> mix usage of D-Bus with btmgmt, they might not play well together
>> especially when it comes to discovery.
>>
>
> Thank you, I add "patch v2 adapter: Refactor code around discovery" to
> source bluez-5.47 and compile it.
>
> My test results:
>
> 1. btmgmt after "find" command NOT set org.bluez.Adapter1 string:Discover=
ing
> =3D1 . But the Discovery process is already running, why he does not do i=
t?
> btmgmt not use dbus for managment?

btmgmt uses the kernel management interface not D-Bus, this is why I
said it may not play well with bluetoothd.

> 2. If i send method StartDiscovery via dbus-send command, i see
> org.bluez.Adapter1 string:Discovering =3D1 status. But I can not stop the
> process, method StopDiscovery - has no effect.

The StopDiscovery can only stop discovery started by the client, if
you use btmgmt to start then it can only be stopped by btmgmt.

> "btmgmt stop-find" - has no effect, in therminal i see:
> hci0 type 7 discovering off
> hci0 type 7 discovering on
> hci0 type 7 discovering off
> hci0 type 7 discovering on
> hci0 type 7 discovering off
> hci0 type 7 discovering on
>
> after btmgmt power off and btmgmt power on
> org.bluez.Adapter1 string:Discovering =3D0
>
> I assume that the method StopDiscovery must completely terminate the proc=
ess
> StartDiscovery, regardless of the way the scan was started (btmgmt,
> dbus-send, hcitool, bluetoothctl or more other).

Only if StartDiscovery was initiated by the same D-Bus
connection/process, and in case you are wondering there is proper
support for discovery in bluetoothctl which does use D-Bus to control
the discovery.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
