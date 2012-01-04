Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F044EC7.6000803@samsung.com>
References: <4F044EC7.6000803@samsung.com>
Date: Wed, 4 Jan 2012 16:47:40 +0200
Message-ID: <CABBYNZKA4BMG0uk5MXRT96WvJ16GdFpnw9Kcj4xJT5Y5rsn8mA@mail.gmail.com>
Subject: Re: How does other application know bt adapter discoverabletimeout ?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chanyeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	=?UTF-8?B?7Y6464+E7ZiE?= <dh79.pyun@samsung.com>,
	=?UTF-8?B?7ISc7Zi47LKg?= <hocheol.seo@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

2012/1/4 Chanyeol Park <chanyeol.park@samsung.com>:
> Hello
>
> regarding bluetooth discoverable timeout, I have a question.
>
> As far as I understand, if we set DiscoverableTimeout ,
>  setting application should count down DiscoverableTimeout in order to
> display Timeout.
>
> But in case of other application , how could they know exact remained
> timeout?

Currently we don't emit the count down and you have to be more
specific about such use case, because I don't see much of a point for
e.g. a phone or IVI system to have such behavior, DiscoverableTimeout
is useful for system where you dont want to set discoverable property
persistently e.g. no display/ui systems such as headset or routers
then you basically press some buttons and it will be discoverable for
some fixed amount of time.

-- 
Luiz Augusto von Dentz
