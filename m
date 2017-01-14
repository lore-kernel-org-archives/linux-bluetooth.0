Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Scheib <scheib@google.com>
Date: Fri, 13 Jan 2017 20:38:21 -0800
Message-ID: <CAK-EfX=FkO9JSiQhE4WXeTTr3sw9WHDPVNr6pJmOXP1PgE0L5Q@mail.gmail.com>
Subject: Re: GATT service blacklist
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I just ran into this issue again (being blocked from accessing a standard
GATT service) when using bluez. I had an application accessing GATT
objects, and also the generic_access service. It's very odd that GATT
operations to any service would be blocked unless there was a security
reason to prevent them. Reading and writing the device name should just
work. It doesn't make sense to write different code with a different API
when the GATT API is already designed to provide access to this service.

Is there a reason bluez can't allow access?

Re: http://marc.info/?l=3Dlinux-bluetooth&m=3D146433282020607
> We now have a new Web Bluetooth sample which shows how to read all GAP
> characteristics from a nearby Bluetooth device.
> https://plus.google.com/+FrancoisBeaufort/posts/7pLosPyHd41
>
> Hopefully, we'll get BlueZ to work.
>
> On Wed, May 25, 2016 at 2:51 PM, Fran=C3=A7ois Beaufort
> <beaufort.francois@gmail.com> wrote:
>> For info, the Web Bluetooth team is tracking this issue at
>> https://bugs.chromium.org/p/chromium/issues/detail?id=3D611678
>>
>> We would really appreciate some consistency between Android, Mac OS
>> and Linux platforms to query GAP service characteristics.
>>
>> Thanks in advance for considering this,
>> Francois.
>>
>> On Fri, May 20, 2016 at 4:36 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi,
>>>
>>> In Web Bluetooth there is a list of blacklisted attributes that may
>>> leak some important information:
>>>
>>>
https://github.com/WebBluetoothCG/registries/blob/master/gatt_blacklist.txt
>>>
>>> Currently we don't support claiming attribute, which is what in the
>>> end prevent a service to be exposed, so I would like to know the
>>> opinion about having such a feature noting that this may lead to
>>> conflicts such as plugins and application accessing the same
>>> attributes which may or may not interfere.
>>>
>>> One of the service that web guys would like to access is GAP service
