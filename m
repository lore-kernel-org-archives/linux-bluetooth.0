Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 May 2009 23:50:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Michael Buesch <mb@bu3sch.de>
Cc: bugzilla-daemon@bugzilla.kernel.org,
	bugme-daemon@bugzilla.kernel.org, Alex Dubov <oakad@yahoo.com>
Subject: Re: [Bugme-new] [Bug 13320] New: ohci_hcd: unable to attach device
 - device descriptor read/64, error -62
Message-Id: <20090527235045.7c78d688.akpm@linux-foundation.org>
In-Reply-To: <bug-13320-10286@http.bugzilla.kernel.org/>
References: <bug-13320-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sat, 16 May 2009 09:51:39 GMT bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13320
> 
>            Summary: ohci_hcd: unable to attach device - device descriptor
>                     read/64, error -62
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.29
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: USB
>         AssignedTo: greg@kroah.com
>         ReportedBy: oakad@yahoo.com
>         Regression: Yes
> 
> 
> Created an attachment (id=21373)
>  --> (http://bugzilla.kernel.org/attachment.cgi?id=21373)
> dmesg dump of the problem
> 
> Device in question - built-in USB bluetooth controller.
> 
> Used to work flawlessly in older kernel.
> 
> Stopped working when Sonics Silicon backplane driver was merged (ohci_hcd
> refused to work when ssb.ko was loaded before it or at all).
> 
> The problem was fixed at some point.
> 
> In 2.6.29 it comes back.

I'm not sure who to toss this at, so I cc'ed everyone I ever met.

Do you know which kernel version we regressed in?  I guess 2.6.8 was OK?
