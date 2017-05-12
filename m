Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <23EE3325-275B-437E-9A1E-2AE5B4ADEA4B@sense.com>
References: <23EE3325-275B-437E-9A1E-2AE5B4ADEA4B@sense.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 May 2017 16:40:23 +0300
Message-ID: <CABBYNZJo_prVvPqrNGnDYE1JFwggE94=021=Ov-V-wzowccsFg@mail.gmail.com>
Subject: Re: Detecting GATT connections over bus
To: Jonah Petri <jonah@sense.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Thu, May 11, 2017 at 10:13 PM, Jonah Petri <jonah@sense.com> wrote:
> Hello,
>
> I am writing a BTLE GATT peripheral using Bluez5 5.45 on Linux 4.1.15 and=
 a bcm43xx chip.  I=E2=80=99m trying to use the DBus GATT and LEAdvertising=
 interfaces.  I need to detect LE host connection and disconnection.
>
> I tried registering a dbus message match for PropertiesChanged on org.blu=
ez.Device1, and watching Connected switch on and off, but that is not relia=
ble, and seems to only happen when bluetoothd wants to resolve services on =
the connecting host.  In particular, I definitely see cases where:
>
> 1) Initially, all devices listed in ManagedObjects are =E2=80=9CConnected=
" =3D=3D false
> 2) btmon reveals a subsequent "LE Connection Complete=E2=80=9D event
> 3) GATT transactions are initiated by the remote host and received by my =
application via DBus
> 4) No "Connected =3D true=E2=80=9D PropertiesChanged message is ever rece=
ived by my application
>
> This leads me to believe that the =E2=80=9CConnected =3D true=E2=80=9D tr=
ansition occurs on some other event.  I do see it sometimes, but it doesn=
=E2=80=99t seems to correlate to a LE connection.
>
> What can I do to tell when a new host connects to my GATT peripheral?

Just check what bluetoothctl does, it does in fact use Connected
property as you can see bellow it should tell you when there is a
device connected:

[CHG] Device F3:43:74:BF:86:24 Connected: yes

--=20
Luiz Augusto von Dentz
