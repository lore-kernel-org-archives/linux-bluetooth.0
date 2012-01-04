Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: rfcomm & encryption
Date: Wed, 4 Jan 2012 09:10:01 +0100
CC: Daniel Wagner <wagi@monom.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>
References: <4F0362F8.9000000@monom.org> <1325622857.6454.12.camel@aeonflux>
In-Reply-To: <1325622857.6454.12.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201201040910.02057.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> so we are establishing the connection with security level of SDP only
> hence no encryption required. Which is the only exception to run without
> encryption when using SSP.
> 
> Since we do not disconnected in between SDP and RFCOMM channels, we have
> to do a security level upgrade here. And for some reason that gets
> triggered, but does not force encryption to be switched on.
> 
> With SSP enabled you should always switch on encryption when getting
> authentication complete event. Actually generally speaking you should
> always switch on encryption after authentication. Otherwise the
> authentication is rather pointless anyway.
> 
> Look at commit d7556e20, then this code got re-ordered. It does not look
> correct to me anymore. We might need to redo the whole auth and encrypt
> callback handling.

Some time ago there was a patch from Peter Hurley that should fixed that issue.
I've just noticed that for some reason it was not merged upstream..
(we use it in our own branch for some time already)

[PATCH v3] Bluetooth: Fix l2cap conn failures for ssp devices
http://www.spinics.net/lists/linux-bluetooth/msg15312.html

-- 
BR
Szymon Janc
