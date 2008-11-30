Return-Path: <cyrus@holtmann.org>
Date: Sun, 30 Nov 2008 10:36:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-bluetooth@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, johannes@sipsolutions.net
Subject: Re: [Bugme-new] [Bug 12125] New: bt stops working after
 suspend/resume
Message-Id: <20081130103655.d2d202c1.akpm@linux-foundation.org>
In-Reply-To: <bug-12125-10286@http.bugzilla.kernel.org/>
References: <bug-12125-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sun, 30 Nov 2008 08:08:42 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12125
> 
>            Summary: bt stops working after suspend/resume
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.28-rc6-wl-dirty
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Bluetooth
>         AssignedTo: drivers_bluetooth@kernel-bugs.osdl.org
>         ReportedBy: johannes@sipsolutions.net
> 
> 
> Latest working kernel version: unknown
> Earliest failing kernel version: unknown
> Distribution: debian/unstable
> Hardware Environment: powerbook
> Software Environment: btusb
> Problem Description: bluetooth stops working after suspend/resume
> 
> Steps to reproduce:
> 
> suspend laptop, resume:
> 
> # hcitool scan
> Device is not available: No such device
> 
> # sdptool browse
> Inquiring ...
> Inquiry failed
> 
> 
> I'm fairly sure this used to work (most of the time at least!) with hci-usb.
> 

