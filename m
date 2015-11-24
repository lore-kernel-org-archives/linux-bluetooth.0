Return-Path: <john@metanate.com>
Date: Tue, 24 Nov 2015 12:43:35 +0000
From: John Keeping <john@metanate.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/hciattach: Add support for BCM line discipline
Message-ID: <20151124124335.6047f622.john@metanate.com>
In-Reply-To: <00194B0F-4F62-445C-B8C8-1877ED61C4B7@holtmann.org>
References: <1448366171-14264-1-git-send-email-john@metanate.com>
	<BECBB818-C6C6-4A55-A8ED-804820D0337E@holtmann.org>
	<20151124122842.12ca2fba.john@metanate.com>
	<00194B0F-4F62-445C-B8C8-1877ED61C4B7@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 24 Nov 2015 13:37:22 +0100, Marcel Holtmann wrote:

> Hi John,
> 
> >>> This is similar to the "bcm43xx" option but using the kernel
> >>> driver has the advantage that the wakeup and shutdown pins on the
> >>> device can be used.    
> >> 
> >> what is wrong with just using btattach?  
> > 
> > It's marked as experimental and not installed by "make install", so
> > I assumed that it was only supposed to be used for testing.  
> 
> hmm, not installed by default.

I don't think there's any way to install it via the autotools
infrastructure since it's added to noinst_PROGRAMS in Makefile.tools
(and then only when EXPERIMENTAL is set).

>                                I do not remember the reason for that,
> but I am sure I had one. However btattach is so dead simple that it
> should be used. Seems like we should look into making sure the
> command line options are stable and we install it by default.

I'm happy to submit a patch to build (and install) btattach by default,
but I guess it will also need a man page.  I'm not sure what you mean
about the command line options, they look reasonable to me but I'm not a
bluetooth expert.


Regards,
John
