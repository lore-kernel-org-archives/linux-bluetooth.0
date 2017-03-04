Return-Path: <sre@kernel.org>
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Nokia H4+ support
Date: Sat,  4 Mar 2017 12:58:23 +0100
Message-Id: <20170304115833.3538-1-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

As the title suggest here is another try to get the Nokia bluetooth
supported mainline. The driver is based on the serdev work from Rob
Herring, which got merged into 4.11-rc1 (this patchset is based on
recent master branch from torvalds).

The driver was tested on N950 (I can connect to different devices
with bluetoothctl and fetch their info). It does not yet run completly
stable (especially on N900), but its better than no device support
at all.

-- Sebastian

Rob Herring (1):
  Bluetooth: hci_uart: add serdev driver support library

Sebastian Reichel (9):
  ARM: dts: N9/N950: add bluetooth
  ARM: dts: N900: Add bluetooth
  Bluetooth: hci_uart: add support for word alignment
  Bluetooth: hci_serdev: do not open device in hci open
  tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init
  serdev: add serdev_device_wait_until_sent
  serdev: add serdev_device_get_cts
  serdev: add serdev_device_set_rts
  Bluetooth: add nokia driver

 .../devicetree/bindings/net/nokia-bluetooth.txt    |  51 ++
 arch/arm/boot/dts/omap3-n900.dts                   |  23 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  32 +
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   3 +
 drivers/bluetooth/hci_h4.c                         |  17 +
 drivers/bluetooth/hci_ldisc.c                      |   4 +
 drivers/bluetooth/hci_nokia.c                      | 839 +++++++++++++++++++++
 drivers/bluetooth/hci_serdev.c                     | 365 +++++++++
 drivers/bluetooth/hci_uart.h                       |   7 +
 drivers/tty/serdev/core.c                          |  33 +
 drivers/tty/serdev/serdev-ttyport.c                |  62 +-
 drivers/tty/serial/omap-serial.c                   |   3 +
 include/linux/serdev.h                             |  12 +
 14 files changed, 1460 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
 create mode 100644 drivers/bluetooth/hci_nokia.c
 create mode 100644 drivers/bluetooth/hci_serdev.c

-- 
2.11.0
