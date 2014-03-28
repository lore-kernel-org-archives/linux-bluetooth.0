Return-Path: <cyrus@holtmann.org>
Message-ID: <1396038238.5349.11.camel@g-VPCF13Z1E>
Subject: Re: PATCH hid2hci for CSR 8510 A10
From: Gordon <kernel@gkr.i24.cc>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 28 Mar 2014 21:23:58 +0100
In-Reply-To: <20140328194907.GA24300@t440s.P-661HNU-F1>
References: <1388440779.28025.21.camel@g-VPCF13Z1E>
	 <1396034462.3390.5.camel@g-VPCF13Z1E>
	 <20140328194907.GA24300@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fr, 2014-03-28 at 21:49 +0200, Johan Hedberg wrote:
> Hi Gordon,
> 
> On Fri, Mar 28, 2014, Gordon wrote:
> > some time ago I sent a patch attached to following mail.
> > 
> > On Mo, 2013-12-30 at 22:59 +0100, Gordon wrote:
> > > Hi,
> > > 
> > > Could someone please review.
> > 
> > I didn't get a reply yet. Since it has been my first mail to this list I
> > wonder whether there is anything wrong with this request, or just nobody
> > is interested ?
> 
> A couple of things regarding the presentation of the patch should at
> least be fixed:
> 
>  - Send it as a proper git patch, i.e. using git commit, format-patch
>    and send-email

ok, will try.

>  - Try to follow the bluez.git coding style which is roughly the same as
>    the Linux kernel coding style. I realize the rest of hid2hci.c is
>    probably the worst reference for good BlueZ coding style (being one
>    of the oldest pieces of code with very little maintenance over the
>    years).
> 

thanks for the detailed remarks, although removed from the reply, I will
address them.

> > +		//unable to detect EALREADY
> 
> We don't generally use C++ style comments in the tree. Prefer /* .. */
> where possible. In this case I'd elaborate the comment a bit since I
> don't quite understand what it means.

I am not sure, other functions in hid2hci presumably return this when
the device is already in the mode that should be switched to. 

> 
> > +	case HID:
> > +		// currently unknown what to do here
> 

the method for switching back to hid mode is unknown, should I remove
the cases or just be more verbose in the comments ?

Thanks,

Gordon

