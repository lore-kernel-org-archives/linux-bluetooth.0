Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How to use GattProfile1
From: Krasi Georgiev <krasi.root@gmail.com>
In-Reply-To: <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com>
Date: Thu, 18 May 2017 20:00:33 +0300
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <F1876BDF-4DC0-4CB0-A20F-2E64E24A3B92@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com> <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com> <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com> <969738CC-B335-4E2F-BF3C-441110279871@gmail.com> <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com>
To: Barry Byford <31baz66@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks

I watched this video 3 times, but he talks about profile registration =
and the auto connect very briefly so I tried everything that comes to =
mind, but can=E2=80=99t make it to work

If you have done it can you post some pseudo code for the code execution =
?

I am sure it is not very complicated , just still too new to the whole =
concept.


> On 18 May 2017, at 18:41, Barry Byford <31baz66@gmail.com> wrote:
>=20
> Szymon Janc talks through using BlueZ for BLE on this video:
> https://youtu.be/VMDyebKT5c4
> Slides at:
> =
http://events.linuxfoundation.org/sites/events/files/slides/Doing%20Blueto=
oth%20Low%20Energy%20on%20Linux.pdf
>=20
> Should be helpful for you to understand the logic.
>=20
>=20
> On 17 May 2017 at 11:35, Krasi Georgiev <krasi.root@gmail.com> wrote:
>> 3 hours later and still no luck :(
>>=20
>> I am reading all api documents over and over again and can=E2=80=99t =
understand the logic.
>>=20
>> I think I need to register an object that implements the =
org.bluez.GattProfile1 interface, but what should be the bus name and =
object path for this object I am completely unsure...
>>=20
>> Desperate for any useful info so thanks in advance :)
>>=20
>>> On 16 May 2017, at 23:31, Krasi Georgiev <krasi.root@gmail.com> =
wrote:
>>>=20
>>> Thanks
>>> I already looked at these, but they don=E2=80=99t cover what I need =
and also a but high level with the dbus python package which hides most =
of the important details.
>>>=20
>>> Anyway I think I got a better idea now. I think I need to register =
the   org.bluez.GattProfile1 interface in the dbus and then call =
org.bluez.ProfileManager1.RegisterProfile , will test it tomorrow and =
hopefully I will get it going.
>>>=20
>>>=20
>>>> On 16 May 2017, at 22:08, Barry Byford <31baz66@gmail.com> wrote:
>>>>=20
>>>> Hello Krasi,
>>>>=20
>>>>=20
>>>> On 16 May 2017 at 12:42, Krasi Georgiev <krasi.root@gmail.com> =
wrote:
>>>>> Hi all
>>>>>=20
>>>>> Can you give me a quick example with a pseudo code (or using =
qdbus) for  workflow steps how to setup an
>>>>> auto connect to a device that supports given UUID service =
(0000180f-0000-1000-8000-00805f9b34fb - Battery Service)
>>>>=20
>>>> The examples for BlueZ are in the test directory. The ones you =
might
>>>> find useful are:
>>>> =
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-discover=
y
>>>> =
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-=
client
>>>>=20
>>>>=20
>>>>=20
>>>>>=20
>>>>> =46rom what I understand all I need to do is send a call to the =
sytembus to register the hci0 adapter to auto connect
>>>>>=20
>>>>> org.bluez.ProfileManager1.RegisterProfile , /org/bluez/Test =
(ObjPath), "00001802-0000-1000-8000-00805f9b34fb=E2=80=9D (service UUID)
>>>>>=20
>>>>> and if the discovery finds a device with such service it should =
auto connect right ?
>>>>>=20
>>>>>=20
>>>>> I am not sure what is the ObjPath parameter for and when i =
introspect I don=E2=80=99t even see the /org/bluez/GattProfile1
>>>>>=20
>>>>> I am using bluez Version 5.45 on a Raspberry Pi zero
>>>>> Linux 4.4.50+   armv6l
>>>>>=20
>>>>>=20
>>>>> I tried making the call using with gdbus, but couldn=E2=80=99t =
figure out how to structure the  osa{sv} paramters
>>>>> also tried dbus-send , but the tool doesn=E2=80=99t seem to =
support this structures (no nesting)
>>>>>=20
>>>>>=20
>>>>> I am using golang godbus bindings and the call gets executed =
without an error , but the bluetooth adapter doesn=E2=80=99t auto =
connect
>>>>>=20
>>>>>=20
>>>>> here is the gist
>>>>> =
https://gist.githubusercontent.com/krasi-georgiev/56f88cd18893578fa83c328f=
038479d6/raw/25f11f2fd7b55d82590732fa8f253febda623645/main.go
>>>>>=20
>>>>> go get github.com/godbus/dbus
>>>>> wget =
https://gist.githubusercontent.com/krasi-georgiev/56f88cd18893578fa83c328f=
038479d6/raw/25f11f2fd7b55d82590732fa8f253febda623645/main.go
>>>>> go run main.go
>>>>>=20
>>>>>=20
>>>>> I would really appreciate some useful info.
>>>>> Thanks--
>>>>> To unsubscribe from this list: send the line "unsubscribe =
linux-bluetooth" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>=20
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe =
linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

