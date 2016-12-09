Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: jose.bollo@iot.bzh
In-Reply-To: <CABBYNZL2gRTEfn2TsLYn8WoxnOH=cdoG8L8FeJMQKtNT89Nqtw@mail.gmail.com>
References: <CA+LDafA2A4Jy8s4aYi8DiwZ=L6dNsQm5g6es5jXMu0pqB9fprA@mail.gmail.com>
 <CABBYNZL2gRTEfn2TsLYn8WoxnOH=cdoG8L8FeJMQKtNT89Nqtw@mail.gmail.com>
From: =?UTF-8?Q?Jos=C3=A9_Bollo?= <jose.bollo@iot.bzh>
Date: Fri, 9 Dec 2016 12:14:57 +0100
Message-ID: <CA+LDafAX78wBWxJ4e4H7LJd6CzONyNuk3Tx2UvF-hGVjeooZ0w@mail.gmail.com>
Subject: Re: How BLE services could be remembered?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?Q?jos=C3=A9_bollo?= <jose.bollo@iot.bzh>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

2016-12-09 10:43 GMT+01:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Jose,
>
> On Thu, Dec 8, 2016 at 4:40 PM, Jos=C3=A9 Bollo <jose.bollo@iot.bzh> wrot=
e:
>> Hello,
>>
>> I observe a strange behaviour of bluez dbus interface.
>>
>> I'm using Cinolink BT 4.0 USB Adapter (CSR BC8510 chipset), Bluez 5.43
>> on debian and/or on fedora.
>>
>> When I first pair a BLE device, the services are correctly discovered
>> and the GATT endpoints are created (a lot).
>>
>> Then I can use it as expected and it is nice. But when I turn off the
>> computer and restart it, things become different.
>>
>> Because the devices are paired with LT key, they are still paired but
>> the GATT services are not availables. I can connect to the device but
>> it doesn't declares the GATT properties/attributes that I need. Also,
>> the service advertises itself without effect.
>
> The attributes should be saved in cache but they are only reloaded on
> demand once a connection happens. Also if the database changes the
> cache can be invalidated removing its attributes, this has been
> changed so premature disconnections don't cause that anymore but in
> case the database do actually change their attributes will be
> invalidated. So if your device is known to cause premature disconnects
> please try with upstream version.

That is probably the case, the device disconnects itself after a
transaction. Its designer made it to improve battery life.

The attribute stay available by DBUS until next restart.

I'll try the upstream version and check whether attribute are
available after a restart.

(snip)

> ConnectService? You mean Connect/ConnectProfile, those can be used in
> case you want to force an active scanning + connect procedure,
> otherwise the device shall be reconnected using passive scanning.

Yes I meant ConnectProfile.

Is it preferable to use ConnectProfile instead of Connect when only
one profile is expected?
The device is always advertising. I think that I have to connect
explicitly because the connection is not automatic.

> Luiz Augusto von Dentz

Best regards
Jos=C3=A9
