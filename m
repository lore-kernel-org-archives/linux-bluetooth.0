Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <969738CC-B335-4E2F-BF3C-441110279871@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com>
 <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com>
 <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com> <969738CC-B335-4E2F-BF3C-441110279871@gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Thu, 18 May 2017 16:41:53 +0100
Message-ID: <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com>
Subject: Re: How to use GattProfile1
To: Krasi Georgiev <krasi.root@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Szymon Janc talks through using BlueZ for BLE on this video:
https://youtu.be/VMDyebKT5c4
Slides at:
http://events.linuxfoundation.org/sites/events/files/slides/Doing%20Bluetoo=
th%20Low%20Energy%20on%20Linux.pdf

Should be helpful for you to understand the logic.


On 17 May 2017 at 11:35, Krasi Georgiev <krasi.root@gmail.com> wrote:
> 3 hours later and still no luck :(
>
> I am reading all api documents over and over again and can=E2=80=99t unde=
rstand the logic.
>
> I think I need to register an object that implements the org.bluez.GattPr=
ofile1 interface, but what should be the bus name and object path for this =
object I am completely unsure...
>
> Desperate for any useful info so thanks in advance :)
>
>> On 16 May 2017, at 23:31, Krasi Georgiev <krasi.root@gmail.com> wrote:
>>
>> Thanks
>> I already looked at these, but they don=E2=80=99t cover what I need and =
also a but high level with the dbus python package which hides most of the =
important details.
>>
>> Anyway I think I got a better idea now. I think I need to register the  =
 org.bluez.GattProfile1 interface in the dbus and then call org.bluez.Profi=
leManager1.RegisterProfile , will test it tomorrow and hopefully I will get=
 it going.
>>
>>
>>> On 16 May 2017, at 22:08, Barry Byford <31baz66@gmail.com> wrote:
>>>
>>> Hello Krasi,
>>>
>>>
>>> On 16 May 2017 at 12:42, Krasi Georgiev <krasi.root@gmail.com> wrote:
>>>> Hi all
>>>>
>>>> Can you give me a quick example with a pseudo code (or using qdbus) fo=
r  workflow steps how to setup an
>>>> auto connect to a device that supports given UUID service (0000180f-00=
00-1000-8000-00805f9b34fb - Battery Service)
>>>
>>> The examples for BlueZ are in the test directory. The ones you might
>>> find useful are:
>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-disco=
very
>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-ga=
tt-client
>>>
>>>
>>>
>>>>
>>>> From what I understand all I need to do is send a call to the sytembus=
 to register the hci0 adapter to auto connect
>>>>
>>>> org.bluez.ProfileManager1.RegisterProfile , /org/bluez/Test (ObjPath),=
 "00001802-0000-1000-8000-00805f9b34fb=E2=80=9D (service UUID)
>>>>
>>>> and if the discovery finds a device with such service it should auto c=
onnect right ?
>>>>
>>>>
>>>> I am not sure what is the ObjPath parameter for and when i introspect =
I don=E2=80=99t even see the /org/bluez/GattProfile1
>>>>
>>>> I am using bluez Version 5.45 on a Raspberry Pi zero
>>>> Linux 4.4.50+   armv6l
>>>>
>>>>
>>>> I tried making the call using with gdbus, but couldn=E2=80=99t figure =
out how to structure the  osa{sv} paramters
>>>> also tried dbus-send , but the tool doesn=E2=80=99t seem to support th=
is structures (no nesting)
>>>>
>>>>
>>>> I am using golang godbus bindings and the call gets executed without a=
n error , but the bluetooth adapter doesn=E2=80=99t auto connect
>>>>
>>>>
>>>> here is the gist
>>>> https://gist.githubusercontent.com/krasi-georgiev/56f88cd18893578fa83c=
328f038479d6/raw/25f11f2fd7b55d82590732fa8f253febda623645/main.go
>>>>
>>>> go get github.com/godbus/dbus
>>>> wget https://gist.githubusercontent.com/krasi-georgiev/56f88cd18893578=
fa83c328f038479d6/raw/25f11f2fd7b55d82590732fa8f253febda623645/main.go
>>>> go run main.go
>>>>
>>>>
>>>> I would really appreciate some useful info.
>>>> Thanks--
>>>> To unsubscribe from this list: send the line "unsubscribe linux-blueto=
oth" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
