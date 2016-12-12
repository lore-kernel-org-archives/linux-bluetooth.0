Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: jose.bollo@iot.bzh
In-Reply-To: <CABBYNZL3uqU=FWvddOhHxjEZ=0bvhUoq6vYjm=79xHOfd=wFAA@mail.gmail.com>
References: <CA+LDafA2A4Jy8s4aYi8DiwZ=L6dNsQm5g6es5jXMu0pqB9fprA@mail.gmail.com>
 <CABBYNZL2gRTEfn2TsLYn8WoxnOH=cdoG8L8FeJMQKtNT89Nqtw@mail.gmail.com>
 <CA+LDafAX78wBWxJ4e4H7LJd6CzONyNuk3Tx2UvF-hGVjeooZ0w@mail.gmail.com> <CABBYNZL3uqU=FWvddOhHxjEZ=0bvhUoq6vYjm=79xHOfd=wFAA@mail.gmail.com>
From: =?UTF-8?Q?Jos=C3=A9_Bollo?= <jose.bollo@iot.bzh>
Date: Mon, 12 Dec 2016 14:35:50 +0100
Message-ID: <CA+LDafAxHJbaTLgAvyiWRovwc=_19yvtBBp_cUiDPevxZ6MG=Q@mail.gmail.com>
Subject: Re: How BLE services could be remembered?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?Q?jos=C3=A9_bollo?= <jose.bollo@iot.bzh>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Using the commit c64b4d9e8dc3e36672061f39a9dba19ad0fb1ef1, the issue
is sloved. Great! Thank you.

But my issue was also related to the fact that 'connected' was
received before availability of the attributes/services. The code was
disconnecting with the effect that not attributes/services coulded be
discovered.

Should I that the variable "ServicesResolved" is intended to reflect
the service resolution state? How long should I wait after being
connected for the ServiceResolved Status? Is there a way to know that
service resolution is in progress?

Best regards
Jos=C3=A9 Bollo
Jos=C3=A9 Bollo - Senior Software Engineer
www.iot.bzh



2016-12-09 14:15 GMT+01:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Jose,
>
> On Fri, Dec 9, 2016 at 1:14 PM, Jos=C3=A9 Bollo <jose.bollo@iot.bzh> wrot=
e:
>> Hi Luiz,
>>
>> 2016-12-09 10:43 GMT+01:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>=
:
>>> Hi Jose,
>>>
>>> On Thu, Dec 8, 2016 at 4:40 PM, Jos=C3=A9 Bollo <jose.bollo@iot.bzh> wr=
ote:
>>>> Hello,
>>>>
>>>> I observe a strange behaviour of bluez dbus interface.
>>>>
>>>> I'm using Cinolink BT 4.0 USB Adapter (CSR BC8510 chipset), Bluez 5.43
>>>> on debian and/or on fedora.
>>>>
>>>> When I first pair a BLE device, the services are correctly discovered
>>>> and the GATT endpoints are created (a lot).
>>>>
>>>> Then I can use it as expected and it is nice. But when I turn off the
>>>> computer and restart it, things become different.
>>>>
>>>> Because the devices are paired with LT key, they are still paired but
>>>> the GATT services are not availables. I can connect to the device but
>>>> it doesn't declares the GATT properties/attributes that I need. Also,
>>>> the service advertises itself without effect.
>>>
>>> The attributes should be saved in cache but they are only reloaded on
>>> demand once a connection happens. Also if the database changes the
>>> cache can be invalidated removing its attributes, this has been
>>> changed so premature disconnections don't cause that anymore but in
>>> case the database do actually change their attributes will be
>>> invalidated. So if your device is known to cause premature disconnects
>>> please try with upstream version.
>>
>> That is probably the case, the device disconnects itself after a
>> transaction. Its designer made it to improve battery life.
>>
>> The attribute stay available by DBUS until next restart.
>>
>> I'll try the upstream version and check whether attribute are
>> available after a restart.
>>
>> (snip)
>>
>>> ConnectService? You mean Connect/ConnectProfile, those can be used in
>>> case you want to force an active scanning + connect procedure,
>>> otherwise the device shall be reconnected using passive scanning.
>>
>> Yes I meant ConnectProfile.
>>
>> Is it preferable to use ConnectProfile instead of Connect when only
>> one profile is expected?
>> The device is always advertising. I think that I have to connect
>> explicitly because the connection is not automatic.
>
> Actually in this case it should just reconnect if the device is
> advertising, so you should need to use either ConnectProfile or
> Connect, actually ConnectProfile doesn't work for LE since the
> profiles need GATT to be connected first and anyway the way the LE
> works is that the peripheral would advertise so perhaps what is
> missing is that you register an application implementing GattProfile1
> interface that way bluetoothd can tell there is an application trying
> to use the profile see:
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/gatt-api.txt
>
> --
> Luiz Augusto von Dentz
