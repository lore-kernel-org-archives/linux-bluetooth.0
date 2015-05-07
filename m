Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [RFC 0/2] *** Broadcom Bluetooth UART Driver ***
Date: Thu, 7 May 2015 16:25:27 -0400
Message-ID: <1431030329-22929-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*** Broadcom Bluetooth UART Driver changed as per checkpatch.pl ***

Ilya Faenson (2):
  Bluetooth UART Device Tree bindings
  Broadcom Bluetooth UART device driver

 .../devicetree/bindings/net/bluetooth/btbcm.txt    |  54 ++
 drivers/bluetooth/Kconfig                          |  35 +-
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/btbcm.c                          | 173 ++++-
 drivers/bluetooth/btbcm.h                          |  19 +-
 drivers/bluetooth/btbcm_uart.c                     | 679 +++++++++++++++++
 drivers/bluetooth/btbcm_uart.h                     |  90 +++
 drivers/bluetooth/hci_bcm.c                        | 838 +++++++++++++++++++--
 8 files changed, 1799 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
 create mode 100644 drivers/bluetooth/btbcm_uart.c
 create mode 100644 drivers/bluetooth/btbcm_uart.h

-- 
1.9.1

