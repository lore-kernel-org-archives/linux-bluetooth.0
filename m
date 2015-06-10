Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH v2 0/5] Broadcom Bluetooth UART device driver
Date: Wed, 10 Jun 2015 16:05:15 -0400
Message-ID: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

v2 - Release upon the acceptance of Fred's updates,
	updated as per the latest comments from Marcel.
v1 - Original release against the Fred Danis' updates.

Ilya Faenson (5):
  Broadcom Bluetooth UART Device Tree bindings
  H4 line discipline enhancements
  Broadcom Bluetooth UART Platform Driver
  Support the BCM4354 Bluetooth UART device
  BlueZ Broadcom UART Protocol

 .../devicetree/bindings/net/bluetooth/btbcm.txt    |  82 +++
 drivers/bluetooth/Kconfig                          |   9 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/btbcm.c                          |   2 +
 drivers/bluetooth/btbcm_uart.c                     | 673 +++++++++++++++++++++
 drivers/bluetooth/btbcm_uart.h                     |  89 +++
 drivers/bluetooth/hci_bcm.c                        | 400 +++++++++++-
 drivers/bluetooth/hci_ldisc.c                      |  66 +-
 drivers/bluetooth/hci_uart.h                       |   1 +
 9 files changed, 1305 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
 create mode 100644 drivers/bluetooth/btbcm_uart.c
 create mode 100644 drivers/bluetooth/btbcm_uart.h

-- 
1.9.1
