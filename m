Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EE22B99.10600@samsung.com>
References: <4EE22B99.10600@samsung.com>
Date: Fri, 9 Dec 2011 23:08:14 +0200
Message-ID: <CABBYNZLCP=g4uKwDDOGt4mWw2YJ8c5+nUbTkD7YDyQ-miK8oyw@mail.gmail.com>
Subject: Re: How about adding Dbus log in gdbus?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chanyeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org,
	=?UTF-8?B?7ISc7Zi47LKg?= <hocheol.seo@samsung.com>,
	=?UTF-8?B?7Y6464+E7ZiE?= <dh79.pyun@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

2011/12/9 Chanyeol Park <chanyeol.park@samsung.com>:
> Hello
>
> How about adding dbus log in gdbus when we get method call from the remote
> peer(application)?
>
> Personally It could be very useful for begginer.Based on it many people
> could understand
> call procedure easily. As far as I know this was removed when bluez 3.xx.
> but compared to the days,
> recently many dbus APIs have been introduced.
>
> But I know it is relatetd to many projects(bluez,obexd,connman,ofono).
> So we need to consider a few things such as dependency managing and user
> preference.
> because curren gdbus does not have dependency with log.c/log.h.
>
> Is there good idea about this?

Yes it is probably a good idea, but I would suggest we have some
environment e.g. GDBUS_DEBUG to enable/disable it. Also while talking
to Johan about this he suggested to have some function to register the
callback/handler to log, so the projects using gdbus can register
their own function.


-- 
Luiz Augusto von Dentz
