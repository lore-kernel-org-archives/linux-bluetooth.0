Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Nov 2009 12:22:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: -rc6: something (probably active usb bluetooth) blocks suspend
Message-ID: <20091116112254.GB12315@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Linux amd 2.6.32-rc6-00498-g05b553a-dirty #89 SMP Fri Nov 13 10:43:31
CET 2009 i686 GNU/Linux

...and yes, it is a regression. Hw is thinkpad x60.

Tried to suspend, machine came right back, used radio kill switch, and
it suspended ok. Relevant messages seem to be:

								Pavel

PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.02 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Entering mem sleep
usb 5-2: usb suspend
btusb_intr_complete: hci0 urb f3b57420 failed to resubmit (1)
uhci_hcd 0000:00:1d.3: release dev 2 ep81-INT, period 1, phase 0, 23
us
btusb_bulk_complete: hci0 urb f3b57680 failed to resubmit (1)
btusb_bulk_complete: hci0 urb f3b57718 failed to resubmit (1)
usb 5-1: usb suspend
usb 5-1: usb auto-resume
uhci_hcd 0000:00:1d.3: port 1 portsc 0095,01
usb 5-1: finish resume
uhci_hcd 0000:00:1d.3: reserve dev 2 ep81-INT, period 1, phase 0, 23
us
hub 5-0:1.0: port 1 nyet suspended
hub 5-0:1.0: suspend error -16
pm_op(): usb_dev_suspend+0x0/0x10 returns -16
PM: Device usb5 failed to suspend: error -16
PM: Some devices failed to suspend
thinkpad_acpi: ACPI backlight control delay disabled
usb 5-2: usb resume
uhci_hcd 0000:00:1d.3: port 2 portsc 00a5,01
usb 5-2: finish resume
usb usb4: usb resume
usb usb4: wakeup_rh

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
