Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v7 0/6] Add baudrate management for Bluetooth UART
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com>
Date: Sat, 6 Jun 2015 07:48:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BFC52EE7-088F-4C85-B2DE-7955A3707EFF@holtmann.org>
References: <1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This patch set introduce baudrate management for Bluetooth UART
> Controller setup and a first implementation for Broadcom BCM4324B3
> used in Asus T100.
> 
> v6 -> v7:
> - Fix setup when firmware is missing by moving
>  request/release_firmware() out of btbcm_patchram().
> 
> v2 -> v6:
> - Fixes for __hci_cmd_sync() has been integrated (patch v5)
> - In btbcm_check_bdaddr(), merge controller address tests
> - Fix declaration of speeds to use "unsigned int" type
> - Rename default_speed to init_speed
> - Rename operational_speed to oper_speed
> - In case of error during vendor specific set_baudrate(), do not change
>  host baudrate and continue without changing speed
> - Discard changes to bcm_setup_patchram() and in btusb.c
> - Introduce helper functions btbcm_initialize() and btbcm_finalize() to
>  be used by the UART side of things.
> 
> Frederic Danis (6):
>  Bluetooth: btbcm: Move request/release_firmware()
>  Bluetooth: btbcm: Add BCM4324B3 UART device
>  Bluetooth: hci_uart: Support operational speed during setup
>  Bluetooth: btbcm: Add helper functions for UART setup
>  Bluetooth: hci_uart: Update Broadcom UART setup
>  Bluetooth: hci_uart: Add bcm_set_baudrate()
> 
> drivers/bluetooth/btbcm.c     | 135 +++++++++++++++++++++++++++++++++---------
> drivers/bluetooth/btbcm.h     |  20 ++++++-
> drivers/bluetooth/hci_bcm.c   |  86 ++++++++++++++++++++++++++-
> drivers/bluetooth/hci_ldisc.c |  26 ++++++++
> drivers/bluetooth/hci_uart.h  |   4 ++
> 5 files changed, 240 insertions(+), 31 deletions(-)

patches 1-5 have been applied to bluetooth-next tree.

However I did a few minor modifications as mentioned in the separate emails. They were mainly cosmetic and easy to do inline so that you do not have to worry about redoing the whole series. However patch 6 needs a bit of extra work.

Regards

Marcel

