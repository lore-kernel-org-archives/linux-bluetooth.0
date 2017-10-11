Return-Path: <frederic.danis.oss@gmail.com>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>
To: robh@kernel.org,
	marcel@holtmann.org,
	sre@kernel.org,
	loic.poulain@gmail.com,
	johan@kernel.org,
	lukas@wunner.de,
	hdegoede@redhat.com,
	rafael@kernel.org,
	greg@kroah.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	frederic.danis.oss@gmail.com
Subject: [PATCH v3 0/2] ACPI serdev support
Date: Wed, 11 Oct 2017 10:32:12 +0200
Message-Id: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Add ACPI support for serial attached devices.

Currently, serial devices are not set as enumerated during ACPI scan for SPI
or i2c buses (but not for UART). This should also be done for UART serial
devices.
I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.

This needs Johan Hovold's "serdev: fix registration of second slave" patch.

Tested on T100TA with Broadcom BCM2E39.

Since v2:
  - Remove ctrl->serdev set to NULL in acpi_serdev_register_device() in favor
    of Johan's patch
  - Fallback to ctrl->serdev check when acpi_walk_namespace() returns an error
    to prevent memory leak
  - Remove a change in dev_dbg() call in serdev_controller_add(), this will
    be done in separate patch
Since v1:
  - Check if a serdev device as been allocated during acpi_walk_namespace() to
    prevent serdev controller registration instead of the tty-class device.
  - Reword dev_dbg() strings replacing Serial by serdev
  - Removing redundant "serdev%d" in dev_dbg() calls in serdev_controller_add()
Since RFC:
  - Add or reword commit messages
  - Rename *serial_slave* to *serial_bus_slave*
  - Add specific check for Apple in acpi_is_serial_bus_slave(), thanks to
    Lukas Wunner
  - Update comment in acpi_default_enumeration()
  - Remove patch 3 "Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39"
    in favor of patches from Hans de Goede

Frédéric Danis (2):
  serdev: Add ACPI support
  ACPI / scan: Fix enumeration for special UART devices

 drivers/acpi/scan.c       |  37 ++++++++---------
 drivers/tty/serdev/core.c | 100 +++++++++++++++++++++++++++++++++++++++++++---
 include/acpi/acpi_bus.h   |   2 +-
 3 files changed, 113 insertions(+), 26 deletions(-)

-- 
2.7.4
