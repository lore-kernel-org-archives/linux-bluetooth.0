Return-Path: <cyrus@holtmann.org>
Message-ID: <4BFBB5FA.6000200@greffrath.com>
Date: Tue, 25 May 2010 13:35:22 +0200
From: Fabian Greffrath <fabian@greffrath.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: WRT non-UTF-8 device names
References: <1274432516.4068.29.camel@vfrodo>
In-Reply-To: <1274432516.4068.29.camel@vfrodo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Bluez developers,

Am 21.05.2010 11:01, schrieb Fabian Greffrath:
> Long story short: If the bluetooth adapter's device name contains
> non-UTF-8 characters (which my dongle does by default), it requires a
> manual device name change and a restart of the daemon (!) to bring the
> device back to life. I have previously posted a patch to this list which
> fixes this issue by instantly converting faulty device names to UTF-8
> and writing them back to the device during the device configuration
> phase:
>
> <http://marc.info/?l=linux-bluetooth&m=127315737929319&w=2>
>
> However, I have been told that my "patch might be just working around
> the real issue instead of fixing it" and that "It sounds like there's
> something else wrong in the initialization process which makes the
> initialzation fail if the adapter contains some invalid default name".
>
> So, please, try the steps I presented above yourself and tell me what is
> wrong so I can attempt to fix the root of the problem. I am really
> itching to get this issue fixed in the short term.

this is a real issue (it bites me each and every time I plug in my USB 
Bluetooth dongle) and it is easily reproducible following the simple 
steps I have posted earlier. Please give me a hint how to track down 
this bug and fix it.

Thanks,
Fabian
