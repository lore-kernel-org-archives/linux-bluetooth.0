Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412774247.1629.4.camel@linux-0dmf.site>
References: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
	<1412598268.1132.15.camel@linux-0dmf.site>
	<CAG0bkv+nKt-TgONDLENNUncz9NScdJGcYR+J2Z6b=wg2grvqhg@mail.gmail.com>
	<1412600108.28177.0.camel@linux-0dmf.site>
	<CAG0bkvK=fumhJNzuSgx=HFHiVP08V+QH2wLajdffx+f5ugoQPQ@mail.gmail.com>
	<1412602169.28177.2.camel@linux-0dmf.site>
	<CAG0bkv+d9SxToWpk49s=C-w_aA4zbP_RvV_8kcgV254rsvHR0A@mail.gmail.com>
	<1412607050.1743.1.camel@linux-0dmf.site>
	<CAG0bkvKJZMhurNNpc_2wgaACRzhyEikb0G0YSY7QnxqBe1rnjw@mail.gmail.com>
	<CAG0bkv+_t8CqM9w5N1hKJtT=_mQmtWWCPe-9jSHuOkNZCL3B9A@mail.gmail.com>
	<1412676071.1926.1.camel@linux-0dmf.site>
	<CAG0bkvKYT5+ZBZwdvG71g98CqZR03er6rN4y5RRfq6UUL5KnCw@mail.gmail.com>
	<CAG0bkv+YK6_wP+cnZEmfRZnLXa=7N1CMyYqVAbao22gf74dhbw@mail.gmail.com>
	<1412759368.21709.15.camel@linux-0dmf.site>
	<CAG0bkvKugdQSDm+GKRbLGLzrURth5ty9KU-8d3ED-a9sgdDkMg@mail.gmail.com>
	<1412765090.21709.18.camel@linux-0dmf.site>
	<CAG0bkvLy9YNdD-0hYNygT0cVEHAZebobxwJKdsuUcXsLmq9BfQ@mail.gmail.com>
	<1412774247.1629.4.camel@linux-0dmf.site>
Date: Wed, 8 Oct 2014 19:40:06 +0530
Message-ID: <CAG0bkvJhpHLKV3Uk4ns9W3Kafz84oCETTgy2AeufRfuUuHs=ZQ@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> This points to a problem in the USB HC driver.
> Can you enable debugging in that driver.



Is it enabling dynamic debugging?

Could you please point me the steps to enable debugging in USB HC driver?



Thanks,

Naveen

On Wed, Oct 8, 2014 at 6:47 PM, Oliver Neukum <oneukum@suse.de> wrote:
> On Wed, 2014-10-08 at 18:31 +0530, Naveen Kumar Parna wrote:
>> Later connected third device(hci2) and after 2mins observed –EPIPE for
>> hci2(hci2 urb ffff880124f11cc0 status -32 count 0)
>
> This points to a problem in the USB HC driver.
> Can you enable debugging in that driver.
>
>         Regards
>                 Oliver
>
>
