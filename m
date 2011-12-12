Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Message-id: <4EE5FA32.7070807@samsung.com>
Date: Mon, 12 Dec 2011 21:57:22 +0900
From: Chanyeol Park <chanyeol.park@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	=?UTF-8?B?7ISc7Zi47LKg?= <hocheol.seo@samsung.com>,
	=?UTF-8?B?7Y6464+E7ZiE?= <dh79.pyun@samsung.com>
Subject: Re: How about adding Dbus log in gdbus?
References: <4EE22B99.10600@samsung.com>
 <CABBYNZLCP=g4uKwDDOGt4mWw2YJ8c5+nUbTkD7YDyQ-miK8oyw@mail.gmail.com>
In-reply-to: <CABBYNZLCP=g4uKwDDOGt4mWw2YJ8c5+nUbTkD7YDyQ-miK8oyw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
On 2011년 12월 10일 06:08, Luiz Augusto von Dentz wrote:
> Hi Chanyeol,
>
> 2011/12/9 Chanyeol Park<chanyeol.park@samsung.com>:
>> Hello
>>
>> How about adding dbus log in gdbus when we get method call from the remote
>> peer(application)?
>>
>> Personally It could be very useful for begginer.Based on it many people
>> could understand
>> call procedure easily. As far as I know this was removed when bluez 3.xx.
>> but compared to the days,
>> recently many dbus APIs have been introduced.
>>
>> But I know it is relatetd to many projects(bluez,obexd,connman,ofono).
>> So we need to consider a few things such as dependency managing and user
>> preference.
>> because curren gdbus does not have dependency with log.c/log.h.
>>
>> Is there good idea about this?
> Yes it is probably a good idea, but I would suggest we have some
> environment e.g. GDBUS_DEBUG to enable/disable it. Also while talking
> to Johan about this he suggested to have some function to register the
> callback/handler to log, so the projects using gdbus can register
> their own function.
Is it possible to relate this with bluez/obexd enable/disable debug feature?
Personally if we start to use environment variable(GDBUS_DEBUG), it 
would be difficult to use it.

Johan: Could you explain me what you think or suggest?

Thanks
Chanyeol Park

