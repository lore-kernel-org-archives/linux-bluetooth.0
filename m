Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Feb 2010 16:07:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org,
	bugme-daemon@bugzilla.kernel.org, cijoml@volny.cz
Subject: Re: [Bugme-new] [Bug 15360] New: Bluetooth dongle can't be put into
 UP state
Message-Id: <20100222160711.50085d16.akpm@linux-foundation.org>
In-Reply-To: <bug-15360-10286@http.bugzilla.kernel.org/>
References: <bug-15360-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sat, 20 Feb 2010 08:00:33 GMT bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=15360
> 
>            Summary: Bluetooth dongle can't be put into UP state
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.32.3
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Bluetooth
>         AssignedTo: drivers_bluetooth@kernel-bugs.osdl.org
>         ReportedBy: cijoml@volny.cz
>         Regression: Yes
> 
> 
> In 2.6.31:
> hci0:   Type: USB
>         BD Address: 00:15:AF:FA:36:04 ACL MTU: 1021:8 SCO MTU: 64:1
>         UP RUNNING PSCAN
>         RX bytes:1348156 acl:3392 sco:0 events:1253 errors:0
>         TX bytes:306309 acl:2175 sco:0 commands:42 errors:0
> 
> In 2.6.32:
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 1021:8 SCO MTU: 64:1
>         UP RUNNING PSCAN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:42 errors:0
> 
> Eee901:/home/cijoml# lsusb
> Bus 004 Device 002: ID 0b05:b700 ASUSTek Computer, Inc. Broadcom Bluetooth 2.1

It's a 2.6.31 -> 2.6.32 regression.  Is it likely to be in
drivers/bluetooth, or in drivers/usb?

