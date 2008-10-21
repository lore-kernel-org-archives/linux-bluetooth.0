Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Oct 2008 17:24:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-bluetooth@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, rbrito@ime.usp.br
Subject: Re: [Bugme-new] [Bug 11779] New: No way to disable bluetooth
Message-Id: <20081020172426.4e28ba79.akpm@linux-foundation.org>
In-Reply-To: <bug-11779-10286@http.bugzilla.kernel.org/>
References: <bug-11779-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

(tap, tap - is this thing turned on?)

On Sat, 18 Oct 2008 02:55:03 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11779
> 
>            Summary: No way to disable bluetooth
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.27
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Bluetooth
>         AssignedTo: drivers_bluetooth@kernel-bugs.osdl.org
>         ReportedBy: rbrito@ime.usp.br
> 
> 
> Distribution: Ubuntu intrepid
> Hardware Environment: Notebook Itautec N8320
> Software Environment: Ubuntu userland
> Problem Description:
> 
> (This mail was sent to the linux-bluetooth@vger.kernel.org on the 8th of
> October no answer was received).
> 
> Dear developers,
> 
> I got this past july a notebook that has what seems to be a strange way
> of dealing with wireless devices: there is a button (which I suspect is
> called rfkill) that, when pressed, enables *both* bluetooth and wifi,
> with the respective leds being lit.
> 
> I don't have any bluetooth device. Saving energy here is paramount as
> the battery life is quite short.
> 
> According to the manual, under Windows Vista (which is what came with
> the box, but which I never used), this button is supposed to cycle
> between 4 states:
> 
> * both disabled;
> * bluetooth enabled & wifi enabled;
> * bluetooth disabled & wifi enabled;
> * bluetooth enabled & wifi disabled.
> 
> Unfortunately, under Linux (tested with Ubuntu's 8.10 pre-releases,
> which includes a kernel based on 2.6.27-rc*, if I understand it
> correctly), it is all or nothing: both disabled or both enabled.
> 
> If I launch powertop, it recommends to disable bluetooth with
> "hciconfig hci down; rmmod hci_usb", but the led of bluetooth is still
> lit and I fear that the device is still drawing power from the battery.
> (Actually, it seems that the modules for bluetooth go renamed also).
> 
> Is there any way to get it to disable completely the device?
> 
> Just as extra information, this is an Itautec Note N8320 notebook, with
> a Core 2 Duo T7250 CPU, ICH8 chipset and Intel's 3945abg wifi and a
> Realtek GigE driven by r8169 module (which I still have not had the
> opportunity to use).
> 
> If any further information is desired, please let me know. I can post
> the dmesg logs, lspci output, lsusb, as I am really willing to get this
> situation settled (and possibly working as on Windows as it was reported
> by the support people from the manufacturer).
> 
> Again, if any further information is needed, please let me know. I can
> recompile the kernel to use a vanilla kernel, if needed.
> 

