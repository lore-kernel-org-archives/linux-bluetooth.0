Return-Path: <cyrus@holtmann.org>
From: pavan-savoy@ti.com
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
        Pavan Savoy <pavan_savoy@ti.com>
Subject: [PATCH 0/2] Bluetooth driver for TI WiLink 7
Date: Wed,  6 Oct 2010 18:34:51 -0400
Message-Id: <1286404493-23816-1-git-send-email-pavan-savoy@ti.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Pavan Savoy <pavan_savoy@ti.com>

Marcel/Johan and the linux-bluetooth list,

I have begun cleaning up the code for the Bluetooth drivers for
Texas Instrument's WiLink 7 chips.
This driver works on top the Texas Instrument's shared transport line
discipline driver.

So, apart from the transport part of it, the driver is like other regular
bluetooth drivers.
These patches is to move it out of staging/ into the drivers/bluetooth/

Please review and provide comments.

Pavan Savoy (2):
  drivers:bluetooth: TI_ST bluetooth driver
  drivers:bluetooth: Kconfig & Makefile for TI BT

 drivers/bluetooth/Kconfig      |   11 +
 drivers/bluetooth/Makefile     |    1 +
 drivers/bluetooth/bt_ti.c      |  464 ++++++++++++++++++++++++++++++++++++
 drivers/staging/ti-st/Kconfig  |   14 -
 drivers/staging/ti-st/Makefile |    5 -
 drivers/staging/ti-st/bt_drv.c |  509 ----------------------------------------
 drivers/staging/ti-st/bt_drv.h |   61 -----
 7 files changed, 476 insertions(+), 589 deletions(-)
 create mode 100644 drivers/bluetooth/bt_ti.c
 delete mode 100644 drivers/staging/ti-st/Kconfig
 delete mode 100644 drivers/staging/ti-st/Makefile
 delete mode 100644 drivers/staging/ti-st/bt_drv.c
 delete mode 100644 drivers/staging/ti-st/bt_drv.h
