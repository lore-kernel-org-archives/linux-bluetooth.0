Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <561C94B7.2080405@canonical.com>
References: <CAPcThSFEfLyb09r_AuyabEuP31Y1+WNjzpDHHcXANWt+4ovPog@mail.gmail.com>
	<CAPcThSF-Segu_1iz5+4qa78pm9yYV-7fE3N5C4oSO66jyatTaA@mail.gmail.com>
	<561C94B7.2080405@canonical.com>
Date: Tue, 13 Oct 2015 15:43:36 +1000
Message-ID: <CAPcThSE54nohiao5NnpP2UcrMLfBGRFHLx4c5AjWKCxM4tiAng@mail.gmail.com>
Subject: Re: Device class 0 read from Microsoft Designer Mouse (Bluetooth 4.0)
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: Simon Fels <simon.fels@canonical.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Simon for your timely information I really appreciate that!

I will upgrade Ubuntu to have bluez5 to test this mouse.

Cheers,
Harry

On Tue, Oct 13, 2015 at 3:20 PM, Simon Fels <simon.fels@canonical.com> wrote:
> Hey Harry,
>
>>> Recently I got a Microsoft Designer Mouse which supports bluetooth 4.0
>>> but it doesn't work on Ubuntu 15.04 with bluez4-4.101-0ubuntu25.
>>> Although I can pair with it, I can't connect with it.
>>>
>>> I've noticed that the Class value read in relevant DeviceFound message
>>> is 0 (full message in the bottom), and to my surprise there is no
>>> "org.bluez.Input" interface exposed on relevant object created after
>>> pairing therefore I can't invoke the Connect() method on such
>>> interface.
>
>
> The problem here seems to be that the mouse doesn't support HID but HOGP
> (see [1]). BlueZ 4.x doesn't support HOGP. Ubuntu 15.10 already has BlueZ
> 5.35 which has all needed things to support HOGP but I don't know for sure
> if it already works today. Someone else can give you more details here but
> you should definetely update to Ubuntu 15.10 to get the newer required BlueZ
> version.
>
> regards,
> Simon
>
> [1]: https://developer.bluetooth.org/TechnologyOverview/Pages/HOGP.aspx
>
