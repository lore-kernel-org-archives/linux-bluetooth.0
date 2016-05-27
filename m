Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGOkgYeJ7P03Jd3-VcSOHFdDBPo6k5zcUBBDYr0Z6A55wg@mail.gmail.com>
References: <CABBYNZ+_bjxAgk6r3xahXjfG4CuUdzipKksX5dwOARBMDZ5ykw@mail.gmail.com>
 <CAEZxfGOkgYeJ7P03Jd3-VcSOHFdDBPo6k5zcUBBDYr0Z6A55wg@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Fri, 27 May 2016 09:06:42 +0200
Message-ID: <CAEZxfGPnrS=W1+c5LyX8LSpM1erMiq2pCqp-48sqr=-C7+WxgA@mail.gmail.com>
Subject: Re: GATT service blacklist
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We now have a new Web Bluetooth sample which shows how to read all GAP
characteristics from a nearby Bluetooth device.
https://plus.google.com/+FrancoisBeaufort/posts/7pLosPyHd41

Hopefully, we'll get BlueZ to work.

On Wed, May 25, 2016 at 2:51 PM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> For info, the Web Bluetooth team is tracking this issue at
> https://bugs.chromium.org/p/chromium/issues/detail?id=611678
>
> We would really appreciate some consistency between Android, Mac OS
> and Linux platforms to query GAP service characteristics.
>
> Thanks in advance for considering this,
> Francois.
>
> On Fri, May 20, 2016 at 4:36 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi,
>>
>> In Web Bluetooth there is a list of blacklisted attributes that may
>> leak some important information:
>>
>> https://github.com/WebBluetoothCG/registries/blob/master/gatt_blacklist.txt
>>
>> Currently we don't support claiming attribute, which is what in the
>> end prevent a service to be exposed, so I would like to know the
>> opinion about having such a feature noting that this may lead to
>> conflicts such as plugins and application accessing the same
>> attributes which may or may not interfere.
>>
>> One of the service that web guys would like to access is GAP service
>> which is something BlueZ don't actually let them do since there is a
>> plugin accessing it, and given its name we can probably except changes
>> on every new Bluetooth release making me wary about exposing its
>> attributes over D-Bus.
>>
>>
>> --
>> Luiz Augusto von Dentz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
