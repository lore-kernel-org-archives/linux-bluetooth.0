Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: hci_bcm: For serdev case close serdev on failure to set power
Date: Mon, 22 Jan 2018 12:53:23 +0100
Message-Id: <20180122115325.28960-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Here is a v2 of my recent patch-set with the 2 patches swapped in order as
you requested.

Note that 2/2 really is just an RFC / for future reference for now, since
we first need to fix the Edison SOM still using a platform_device + tty
instead of a serdev.

Regards,

Hans
