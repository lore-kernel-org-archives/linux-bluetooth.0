Return-Path: <cyrus@holtmann.org>
Message-ID: <1325692928.6454.44.camel@aeonflux>
Subject: Re: How does other application know bt adapter discoverabletimeout ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Chanyeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	=?UTF-8?Q?=ED=8E=B8=EB=8F=84=ED=98=84?= <dh79.pyun@samsung.com>,
	=?UTF-8?Q?=EC=84=9C=ED=98=B8=EC=B2=A0?= <hocheol.seo@samsung.com>
Date: Wed, 04 Jan 2012 08:02:08 -0800
In-Reply-To: <4F044EC7.6000803@samsung.com>
References: <4F044EC7.6000803@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

> regarding bluetooth discoverable timeout, I have a question.
> 
> As far as I understand, if we set DiscoverableTimeout ,
>   setting application should count down DiscoverableTimeout in order to 
> display Timeout.
> 
> But in case of other application , how could they know exact remained 
> timeout?

they don't know and they also should not need know.

If you are designing a system where another application needs to know
the expired seconds of the discoverable timeout, then I would strongly
suggest to rethink the interaction design with the end user.

I would actually not even expose such a setting to the user if you are
building a phone. My current take on this is either you are always
discoverable by user choice or you are only switching on discoverability
when the user is in the Bluetooth settings menu.

The iPhone iOS for example got this part really figured. As soon as you
enter the Bluetooth settings menu, the device makes itself discoverable
and lets the user know that it did. As soon as you leave that menu or
switch to another application/home screen it goes invisible again. That
is pretty much a good design. No extra clutter or confusion for the end
user.

That said, it is not unreasonable to use the discoverable timeout, but
it should only be used from the same UI application. Doing this cross
applications is not going to work out.

Regards

Marcel


