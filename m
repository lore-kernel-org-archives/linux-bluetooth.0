Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [RFC v3 0/4] Broadcom Bluetooth UART device driver
Date: Wed, 13 May 2015 17:50:19 -0400
Message-ID: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The next version of the driver changed as per Marcel's comments.

Ilya Faenson (4):
  Broadcom Bluetooth UART Device Tree bindings
  Broadcom Bluetooth UART Platform Driver
  Broadcom Bluetooth protocol UART support
  BlueZ Broadcom UART Protocol

 .../devicetree/bindings/net/bluetooth/btbcm.txt    |  54 ++
 drivers/bluetooth/Kconfig                          |   9 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/btbcm.c                          | 155 ++++-
 drivers/bluetooth/btbcm.h                          |  13 +
 drivers/bluetooth/btbcm_uart.c                     | 705 +++++++++++++++++++++
 drivers/bluetooth/btbcm_uart.h                     | 116 ++++
 drivers/bluetooth/hci_bcm.c                        | 528 ++++++++++++++-
 8 files changed, 1561 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
 create mode 100644 drivers/bluetooth/btbcm_uart.c
 create mode 100644 drivers/bluetooth/btbcm_uart.h

-- 
1.9.1

