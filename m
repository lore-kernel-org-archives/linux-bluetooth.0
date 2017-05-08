Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: BLE Advertisement frustrations with pydbus
Date: Mon, 8 May 2017 13:26:23 -0700
References: <8474DEA7-88A2-4AE7-953E-64AC24B1881F@gmail.com>
 <CABBYNZJm0ViS8PZmHRno4T_rOjcJzvQbMfDMmAZ9W5xf-d9Bkg@mail.gmail.com>
 <48520255-46C9-4696-8420-15DB4E8234B4@gmail.com>
 <CAPoQQ-1UJ45tM4pcKPmDin=J-Tf__52Gomt6xE9OwJDULY5rLg@mail.gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <CAPoQQ-1UJ45tM4pcKPmDin=J-Tf__52Gomt6xE9OwJDULY5rLg@mail.gmail.com>
Message-Id: <96FA26A5-2121-44F7-A9B2-9C2F48A03A8A@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On May 8, 2017, at 11:07 AM, Cody P Schafer <dev@codyps.com> wrote:
>=20
>> NAME                                TYPE      SIGNATURE RESULT/VALUE =
FLAGS
>> .GetAll                             method    s         a{sv}        =
-
>=20
>>=20
>> BUT=E2=80=A6 if I try to access as GetAll as you suggest:
>>=20
>> $ sudo busctl call :1.5 /nic/twigpilot =
org.freedesktop.DBus.Properties GetAll
>> No such interface 'org.freedesktop.DBus.Properties' on object at path =
/nic/twigpilot
>=20
> GetAll takes a string argument which is the interface name. Try:
>=20
> $ sudo busctl call :1.5 /nic/twigpilot org.freedesktop.DBus.Properties
> GetAll org.bluez.LEAdvertisement1

Argh (pun). I *thought* I had had that query working on Friday and was =
surprised when I was running it this morning to report that it =
wouldn=E2=80=99t work. So yes,

$ sudo busctl call :1.5 /nic/twigpilot org.freedesktop.DBus.Properties =
GetAll s org.bluez.LEAdvertisement1
a{sv} 6 "ServiceData" a{sv} 0 "ServiceUUIDs" as 0 "SolicitUUIDs" as 0 =
"Type" s "peripheral" "IncludeTxPower" b true "ManufacturerData" a{sv} 0

I *can* do the GetAll() query as Luis asked for. And resolves my =
intermediate question. But brings me back to the original question which =
behavior still persists.

As I said, dbus is a relatively new thing for me. I *think* naively that =
the problem lies somewhere around this call:

bus.register_object('/nic/twigpilot', self, None)

When I look at just simple `busctl` output, I see (amongst others):

$ busctl
NAME                             PID PROCESS         USER             =
CONNECTION    UNIT                      SESSION    DESCRIPTION       =20
...
:1.15                           1677 python3         root             =
:1.15         serial-getty@ttyS0.ser=E2=80=A6ce -          -             =
    =20
...
:1.4                            1385 bluetoothd      root             =
:1.4          bluetooth.service         -          -                 =20
org.bluez                       1385 bluetoothd      root             =
:1.4          bluetooth.service         -          -                 =20

In my naive understanding=E2=80=A6 my python3 has an unnamed connection =
to the system bus (i.e. :1.15). And the bluetoothd has an unnamed =
connection at :1.14. But bluetoothd has also set up a repeatably =
accessible service at org.bluez. My python program has registered an =
object that has the necessary interfaces at  the path /nic/twigpilot, =
but it hasn=E2=80=99t done anything to tie it in to the org.bluez =
service. And yet, when I look at the docs =
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-ap=
i.txt=E2=80=A6 It describes this object as belonging to the org.bluez =
service.

pydbus has an API higher up than register_object() called publish() =
(https://github.com/LEW21/pydbus/blob/master/doc/tutorial.rst#object-publi=
cation) which not only places the object at the given path, but also =
"binds the service to the given bus name=E2=80=9D. But if I use that api =
instead of register_object(), I get the following error=20

RuntimeError: name already exists on the bus

It could be that I=E2=80=99m barking up the completely wrong tree with =
this. I do find myself wishing BLE were exposed via a good old fashioned =
C library or some sort of pseudo file system thing like sysfs. But I=E2=80=
=99m trying to keep an open mind and hope the value-of-dbus light bulb =
will trigger soon.


