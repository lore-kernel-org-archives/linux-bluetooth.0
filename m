Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: sonnyrao@google.com
In-Reply-To: <2583063.yEXEROAGYt@linux-lqwf.site>
References: <CAPz6YkVEwWzosE5Tda+SvtmV1=0Q9g5uyW+RZsOVgOxT79c15Q@mail.gmail.com>
 <2583063.yEXEROAGYt@linux-lqwf.site>
From: Sonny Rao <sonnyrao@chromium.org>
Date: Mon, 27 Aug 2012 08:02:58 -0700
Message-ID: <CAPz6YkXjRAPs1UMGXPqGMDFYjcs_8ggxinF7sYNyjhYfgCBAAQ@mail.gmail.com>
Subject: Re: kernel crashes coming from btusb
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	vpalatin@chromium.org, keybuk@chromium.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 27, 2012 at 6:06 AM, Oliver Neukum <oliver@neukum.org> wrote:
> On Monday 27 August 2012 03:30:55 Sonny Rao wrote:
>> Hi, I've been investigating an issue where we were seeing random
>> kernel crashes soon after resume and after using the great debugging
>> facilities in SLUB I started getting output which pointed to "use
>> after free" from the btusb driver.
>
> Which kernel version?
>
>         Regards
>                 Oliver
>

Oops sorry, kernel 3.4
