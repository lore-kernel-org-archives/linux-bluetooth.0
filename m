Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Ilya Faenson <ifaenson@broadcom.com>
Subject: [RFC 0/2] *** Broadcom Bluetooth UART support ***
Date: Wed, 6 May 2015 15:08:48 -0400
Message-ID: <1430939330-15071-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

*** First take on the Broadcom Bluetooth UART support ***

Ilya Faenson (2):
  Add Broadcom Bluetooth UART device support
  Device Tree config for Broadcom Bluetooth UART

 .../devicetree/bindings/net/bluetooth/btbcm.txt    |  54 ++
 drivers/bluetooth/Kconfig                          |  32 +-
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/btbcm.c                          | 170 +++-
 drivers/bluetooth/btbcm.h                          |  15 +-
 drivers/bluetooth/btbcm_uart.c                     | 684 ++++++++++++++++
 drivers/bluetooth/btbcm_uart.h                     |  94 +++
 drivers/bluetooth/hci_bcm.c                        | 865 +++++++++++++++++++--
 8 files changed, 1837 insertions(+), 78 deletions(-)
 create mode 100755 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
 create mode 100755 drivers/bluetooth/btbcm_uart.c
 create mode 100755 drivers/bluetooth/btbcm_uart.h

-- 
1.9.1
