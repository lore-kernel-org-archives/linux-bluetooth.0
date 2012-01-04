Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201201040910.02057.szymon.janc@tieto.com>
References: <4F0362F8.9000000@monom.org>
	<1325622857.6454.12.camel@aeonflux>
	<201201040910.02057.szymon.janc@tieto.com>
Date: Wed, 4 Jan 2012 12:29:52 +0200
Message-ID: <CABBYNZK0CDF1QRDF+6LNqFW2+ymOu56z2bDgmo6Zh9DDYXpXbA@mail.gmail.com>
Subject: Re: rfcomm & encryption
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Daniel Wagner <wagi@monom.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jan 4, 2012 at 10:10 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi,
>
>> so we are establishing the connection with security level of SDP only
>> hence no encryption required. Which is the only exception to run without
>> encryption when using SSP.
>>
>> Since we do not disconnected in between SDP and RFCOMM channels, we have
>> to do a security level upgrade here. And for some reason that gets
>> triggered, but does not force encryption to be switched on.
>>
>> With SSP enabled you should always switch on encryption when getting
>> authentication complete event. Actually generally speaking you should
>> always switch on encryption after authentication. Otherwise the
>> authentication is rather pointless anyway.
>>
>> Look at commit d7556e20, then this code got re-ordered. It does not look
>> correct to me anymore. We might need to redo the whole auth and encrypt
>> callback handling.
>
> Some time ago there was a patch from Peter Hurley that should fixed that issue.
> I've just noticed that for some reason it was not merged upstream..
> (we use it in our own branch for some time already)
>
> [PATCH v3] Bluetooth: Fix l2cap conn failures for ssp devices
> http://www.spinics.net/lists/linux-bluetooth/msg15312.html

Indeed it seems to fix the problem, but I wonder why the
test_and_set_bit was removed in the first place, the commit messages
of the patch which introduces the regression only says that under some
situation it can cause connection timeouts but I fail to see why. Also
we should be more careful which such changes, at least there should be
more details about what it is fixing and a bit more testing since this
regression is very easy to reproduce I don't think it was tested with
ssp.

-- 
Luiz Augusto von Dentz
