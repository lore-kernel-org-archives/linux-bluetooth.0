Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How to use GattProfile1
From: Krasi Georgiev <krasi.root@gmail.com>
In-Reply-To: <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com>
Date: Tue, 16 May 2017 23:31:26 +0300
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com> <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com>
To: Barry Byford <31baz66@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks=20
I already looked at these, but they don=E2=80=99t cover what I need and =
also a but high level with the dbus python package which hides most of =
the important details.

Anyway I think I got a better idea now. I think I need to register the   =
org.bluez.GattProfile1 interface in the dbus and then call =
org.bluez.ProfileManager1.RegisterProfile , will test it tomorrow and =
hopefully I will get it going.


> On 16 May 2017, at 22:08, Barry Byford <31baz66@gmail.com> wrote:
>=20
> Hello Krasi,
>=20
>=20
> On 16 May 2017 at 12:42, Krasi Georgiev <krasi.root@gmail.com> wrote:
>> Hi all
>>=20
>> Can you give me a quick example with a pseudo code (or using qdbus) =
for  workflow steps how to setup an
>> auto connect to a device that supports given UUID service =
(0000180f-0000-1000-8000-00805f9b34fb - Battery Service)
>=20
> The examples for BlueZ are in the test directory. The ones you might
> find useful are:
> =
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-discover=
y
> =
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-=
client
>=20
>=20
>=20
>>=20
>> =46rom what I understand all I need to do is send a call to the =
sytembus to register the hci0 adapter to auto connect
>>=20
>> org.bluez.ProfileManager1.RegisterProfile , /org/bluez/Test =
(ObjPath), "00001802-0000-1000-8000-00805f9b34fb=E2=80=9D (service UUID)
>>=20
>> and if the discovery finds a device with such service it should auto =
connect right ?
>>=20
>>=20
>> I am not sure what is the ObjPath parameter for and when i introspect =
I don=E2=80=99t even see the /org/bluez/GattProfile1
>>=20
>> I am using bluez Version 5.45 on a Raspberry Pi zero
>> Linux 4.4.50+   armv6l
>>=20
>>=20
>> I tried making the call using with gdbus, but couldn=E2=80=99t figure =
out how to structure the  osa{sv} paramters
>> also tried dbus-send , but the tool doesn=E2=80=99t seem to support =
this structures (no nesting)
>>=20
>>=20
>> I am using golang godbus bindings and the call gets executed without =
an error , but the bluetooth adapter doesn=E2=80=99t auto connect
>>=20
>>=20
>> here is the gist
>> =
https://gist.githubusercontent.com/krasi-georgiev/56f88cd18893578fa83c328f=
038479d6/raw/25f11f2fd7b55d82590732fa8f253febda623645/main.go
>>=20
>> go get github.com/godbus/dbus
>> wget =
https://gist.githubusercontent.com/krasi-georgiev/56f88cd18893578fa83c328f=
038479d6/raw/25f11f2fd7b55d82590732fa8f253febda623645/main.go
>> go run main.go
>>=20
>>=20
>> I would really appreciate some useful info.
>> Thanks--
>> To unsubscribe from this list: send the line "unsubscribe =
linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

