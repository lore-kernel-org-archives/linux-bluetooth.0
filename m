Return-Path: <cyrus@holtmann.org>
Message-ID: <1412765090.21709.18.camel@linux-0dmf.site>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Oliver Neukum <oneukum@suse.de>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Date: Wed, 08 Oct 2014 12:44:50 +0200
In-Reply-To: <CAG0bkvKugdQSDm+GKRbLGLzrURth5ty9KU-8d3ED-a9sgdDkMg@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2014-10-08 at 15:51 +0530, Naveen Kumar Parna wrote:
> hcidump does not show anything when the stalls happen.

There is nothing in all logs. Do you see the problem
with single devices?

	Regards
		Oliver


