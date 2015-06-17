Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH v3 0/5] Broadcom Bluetooth UART device driver
Date: Wed, 17 Jun 2015 11:42:42 -0400
Message-ID: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

v3 -	Renamed brcm device into bcm.
	Allowed for the Broadcom protocol running without Broadcom device
		at the request of Loic Poulain.
	Introduced structure definitions for vendor specific commands.
	Transferred init-speed and oper-speed from protocol into the
		line discipline as they are configurable.
	Introduced hci_uart_init_tty function.
	Removed driver specific Kconfig menu option.
	Introduced protocol timer helper function.
	Converted single driver control dispatch routine into individual
		action routines & removed interface versioning.
	Eliminated specific firmware file name.
	Removed excessive tracing.
	Took care of numerous other comments from Marcel.
v2 -	Release upon the acceptance of Fred's updates, updated as per
		the latest comments from Marcel.
v1 -	Original release against the Fred Danis' updates.

Ilya Faenson (5):
  Broadcom Bluetooth UART Device Tree bindings
  H4 line discipline enhancements
  Broadcom Bluetooth UART Platform Driver
  Support the BCM4354 Bluetooth UART device
  BlueZ Broadcom UART Protocol

 .../devicetree/bindings/net/bluetooth/btbcm.txt    |  82 +++
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/btbcm.c                          |   2 +
 drivers/bluetooth/btbcm.h                          |  31 ++
 drivers/bluetooth/btbcm_uart.c                     | 580 +++++++++++++++++++++
 drivers/bluetooth/btbcm_uart.h                     |  74 +++
 drivers/bluetooth/hci_bcm.c                        | 340 +++++++++++-
 drivers/bluetooth/hci_ldisc.c                      |  93 +++-
 drivers/bluetooth/hci_uart.h                       |   9 +-
 9 files changed, 1195 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
 create mode 100644 drivers/bluetooth/btbcm_uart.c
 create mode 100644 drivers/bluetooth/btbcm_uart.h

-- 
1.9.1
