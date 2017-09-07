Return-Path: <frederic.danis.oss@gmail.com>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>
To: robh@kernel.org,
	marcel@holtmann.org,
	sre@kernel.org,
	loic.poulain@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	frederic.danis.oss@gmail.com
Subject: [RFC 0/3] ACPI serdev support
Date: Thu,  7 Sep 2017 14:10:11 +0200
Message-Id: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Add ACPI support for serial attached devices.

Currently, serial devices are not set as enumerated during ACPI scan for SPI
or i2c buses (but not for UART). This should also be done for UART serial
devices.
I renamed *spi_i2c_slave to *serial_slave to reflect this.

As this is only tested on T100TA with Broadcom BCM2E39, I moved this to a
specific acpi_match_table.

Frédéric Danis (3):
  serdev: Add ACPI support
  ACPI / scan: Fix enumeration for special UART devices
  Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39

 drivers/acpi/scan.c         | 29 ++++++-------
 drivers/bluetooth/hci_bcm.c | 10 ++++-
 drivers/tty/serdev/core.c   | 99 ++++++++++++++++++++++++++++++++++++++++++---
 include/acpi/acpi_bus.h     |  2 +-
 4 files changed, 116 insertions(+), 24 deletions(-)

-- 
2.7.4
