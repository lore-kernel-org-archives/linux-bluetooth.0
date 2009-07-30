Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jul 2009 14:27:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org,
	bugme-daemon@bugzilla.kernel.org, pi3mm3@gmail.com,
	"John W. Linville" <linville@tuxdriver.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [Bugme-new] [Bug 13879] New: Bluetooth stops working after s3
 suspend/resume
Message-Id: <20090730142733.b05a95ed.akpm@linux-foundation.org>
In-Reply-To: <bug-13879-10286@http.bugzilla.kernel.org/>
References: <bug-13879-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

(added lots of cc's)

On Thu, 30 Jul 2009 15:30:31 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13879
> 
>            Summary: Bluetooth stops working after s3 suspend/resume
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.30-gentoo-r1
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Bluetooth
>         AssignedTo: drivers_bluetooth@kernel-bugs.osdl.org
>         ReportedBy: pi3mm3@gmail.com
>                 CC: acpi_platform-drivers@kernel-bugs.osdl.org
>         Regression: No
> 
> 
> Created an attachment (id=22540)
>  --> (http://bugzilla.kernel.org/attachment.cgi?id=22540)
> dmesg output
> 
> Distribution: Gentoo 2008.0 64bit
> Hardware Environment: notebook Toshiba Portege M750
> Software Environment: desktop with gnome-2.24.3, udev-141 and dbus-1.2.3
> Problem Description: After an S3 cycle the hci0 device disappears.
> 
> The only way I found to wake it up is:
> 1) patch drivers/platform/x86/toshiba_acpi.c module with the Experimental
> Toshiba Acpi Driver
> (http://memebeam.org/free-software/toshiba_acpi/toshiba_acpi-dev_toshiba_test5-linux_2.6.29.patch)
> 2) run as root "toshset -bluetooth on" (http://schwieters.org/toshset/).
> 

hm, what's all that stuff in
http://memebeam.org/free-software/toshiba_acpi/ and who wrote it and
should we be merging it into mainline?

