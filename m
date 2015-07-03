Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Neil Martin' <neil@vnp.com>,
	'linux-bluetooth' <linux-bluetooth@vger.kernel.org>
References: <CABKPALrTMqgvxRgu7TmUw+1MrTCL10FAGGzyphb1oAAyFGOBNQ@mail.gmail.com>
In-reply-to: <CABKPALrTMqgvxRgu7TmUw+1MrTCL10FAGGzyphb1oAAyFGOBNQ@mail.gmail.com>
Subject: RE: Trying to run example-advertisement
Date: Fri, 03 Jul 2015 10:47:59 +0530
Message-id: <000901d0b54f$a89a9050$f9cfb0f0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Neil,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Neil Martin
> Sent: Friday, July 03, 2015 12:52 AM
> To: linux-bluetooth
> Subject: Trying to run example-advertisement
> 
> I was having trouble using the advertising api in my own code, so decided to
> run the example-advertisement python test to rule out errors in my code.
> This doesn't work either - I get the following error message:
> 
> LEAdvertisingManager1 interface not found
> 
> I know the advertising api is experimental.  My bluez was built with --enable-
> experimental  and I'm running bluetoothd with the -E flag.
> It seems like this is an environment issue, but I don't find any suggestions
> when I try googling for help.  Is there anything obvious that I'm missing?

I faced the similar issue and got resolved after updating the kernel to latest one.
Then it is able to successfully register.

> 
> Neil
> --

Regards,
Gowtham Anandha Babu

