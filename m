Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BF008F71-1F11-49B1-ADFF-B883B0C19666@openremote.org>
References: <16972ECC-114B-4CA0-A2B1-1BE0FB115199@openremote.org>
	<1815811.8ZlaWYb6CG@leonov>
	<A1432115-C15B-4A07-BB90-E6A731C20B3B@openremote.org>
	<5181722.aJ0IxrIXHx@uw000953>
	<CABBYNZ+_kxPquUwh3AQedu+m70PBjC=jwz0X73G6bj8DvJyssQ@mail.gmail.com>
	<BF008F71-1F11-49B1-ADFF-B883B0C19666@openremote.org>
Date: Thu, 16 Apr 2015 12:36:38 +0300
Message-ID: <CABBYNZKtkTp2-VuP8oEiiKm7AV1n190bcXNXiGjggUWF7w4-Pw@mail.gmail.com>
Subject: Re: Device class not writeable via dbus
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcus Redeker <marcus@openremote.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcus,

On Thu, Apr 16, 2015 at 11:53 AM, Marcus Redeker <marcus@openremote.org> wrote:
>
>> On 16.04.2015, at 10:15, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Szymon, Marcus,
>>
>> On Thu, Apr 16, 2015 at 11:01 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>>> Hi Marcus,
>>>
>>> On Thursday 16 of April 2015 09:09:28 Marcus Redeker wrote:
>>>> True, but  I would like todo that through dbus and not manually and have to restart bluetoothd afterwards.
>>>> Any chance this can be done in the near future?
>>>> -Marcus
>>>>
>>>
>>> Class of Device is rather static configuration as those describe form factor
>>> and that usually doesn't change.
>>>
>>> Why do you need to change CoD on the fly?
>>
>> It is possible to change at runtime by using systemd hostname plugin
>> then change the org.freedesktop.hostname1.Chassis property, but Im not
>> sure how easy is to change that. Anyway the point is that this should
>> not changed by applications at will as it could break discovery
>> filtering, even thought filtering by class is probably broken by
>> design.
>>
>> --
>> Luiz Augusto von Dentz
>
> This would allow to change the name of the bluetooth adapter but not the device class.
> The name can already be changed using the read/write alias property which is no problem.

Looks like you know more than us how BlueZ works, perhaps you want to
tell me what is this code for:

http://fpaste.org/211586/76181142/

Btw, BLE don't really have a class it has appearance which is not
quite the same, we may actually have a different property for
appearance along with a main.conf entry to set it and also a
conversion from chassis to appearance.



-- 
Luiz Augusto von Dentz
