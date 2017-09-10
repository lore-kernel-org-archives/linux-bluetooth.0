Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Sep 2017 12:26:02 -0700
Message-ID: <CA+55aFztG626Np=z2WUzeVS1O3nmoTj76QRUBPg0J-FBELO7vw@mail.gmail.com>
Subject: btusb "firmware request while host is not available" at resume
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Sukumar Ghorai <sukumar.ghorai@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

This seems to be a new problem at resume for the Intel btusb driver,
but I'm not seeing anything in that driver itself that looks like a
likely trigger, so I wonder if it's some driver core change, a generic
resume path issue, or a workqueue change that has made it trigger for
me.

It might also just be a timing difference, maybe it's always been there?

Does anybody have any ideas? It does't happen on every resume, and the
machine works despite this (but no bluetooth - the *next* resume might
bring it back, though).

                 Linus

--

  ACPI: Low-level resume complete
  ACPI: EC: EC started
  PM: Restoring platform NVS memory
  Enabling non-boot CPUs ...
  x86: Booting SMP configuration:
  smpboot: Booting Node 0 Processor 1 APIC 0x2
   cache: parent cpu1 should not be sleeping
  CPU1 is up
  smpboot: Booting Node 0 Processor 2 APIC 0x1
   cache: parent cpu2 should not be sleeping
  CPU2 is up
  smpboot: Booting Node 0 Processor 3 APIC 0x3
   cache: parent cpu3 should not be sleeping
  CPU3 is up
  ACPI: Waking up from system sleep state S3
  ACPI: EC: event unblocked
  usb 1-3: reset full-speed USB device number 2 using xhci_hcd
  usb 1-4: reset full-speed USB device number 3 using xhci_hcd
  usb 1-5: reset high-speed USB device number 4 using xhci_hcd
  usb 1-3:1.0: rebind failed: -517
  usb 1-3:1.1: rebind failed: -517
  Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
  OOM killer enabled.
  Restarting tasks ...
  Bluetooth: hci0: Device revision is 5
  Bluetooth: hci0: Secure boot is enabled
  Bluetooth: hci0: OTP lock is enabled
  Bluetooth: hci0: API lock is enabled
  Bluetooth: hci0: Debug lock is disabled
  Bluetooth: hci0: Minimum firmware build 1 week 10 2014
  firmware request while host is not available
  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 621 at drivers/base/firmware_class.c:1250
_request_firmware+0x460/0x790
  CPU: 2 PID: 621 Comm: kworker/u9:2 Not tainted 4.13.0-10313-ge860d2c904d1 #11
  Hardware name: Dell Inc. XPS 13 9350/09JHRY, BIOS 1.4.17 05/10/2017
  Workqueue: hci0 hci_power_on [bluetooth]
  task: ffff8d3767895ac0 task.stack: ffff9d3481efc000
  RIP: 0010:_request_firmware+0x460/0x790
  Call Trace:
   request_firmware+0x37/0x50
   btusb_setup_intel_new+0x227/0x7e0 [btusb]
   hci_dev_do_open+0x3da/0x570 [bluetooth]
   hci_power_on+0x52/0x1f0 [bluetooth]
   process_one_work+0x1db/0x3d0
   worker_thread+0x47/0x3e0
   kthread+0x125/0x140
   ret_from_fork+0x22/0x30
  ---[ end trace 007b222491432927 ]---
  Bluetooth: hci0: Failed to load Intel firmware file (-112)
  [drm] RC6 on
  done.
  thermal thermal_zone11: failed to read out thermal zone (-5)
  PM: suspend exit
