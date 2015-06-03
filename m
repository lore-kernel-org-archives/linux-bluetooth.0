Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH 0/5] Broadcom Bluetooth UART device driver
Date: Wed, 3 Jun 2015 17:01:39 -0400
Message-ID: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This is a merge of the Broadcom Bluetooth UART logic with
the latest line discipline and protocol enhancements implemented
by Frederic Danis of Intel.

Ilya Faenson (5):
  Broadcom Bluetooth UART Device Tree bindings
  Intel based H4 line discipline enhancements
  Broadcom Bluetooth UART Platform Driver
  Broadcom Bluetooth protocol UART support
  BlueZ Broadcom UART Protocol

 .../devicetree/bindings/net/bluetooth/btbcm.txt    |  82 +++
 drivers/bluetooth/Kconfig                          |   9 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/btbcm.c                          | 142 ++++-
 drivers/bluetooth/btbcm.h                          |  21 +-
 drivers/bluetooth/btbcm_uart.c                     | 673 +++++++++++++++++++++
 drivers/bluetooth/btbcm_uart.h                     |  89 +++
 drivers/bluetooth/hci_bcm.c                        | 481 ++++++++++++++-
 drivers/bluetooth/hci_ldisc.c                      | 110 +++-
 drivers/bluetooth/hci_uart.h                       |   6 +
 10 files changed, 1565 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
 create mode 100755 drivers/bluetooth/btbcm_uart.c
 create mode 100755 drivers/bluetooth/btbcm_uart.h

-- 
1.9.1
