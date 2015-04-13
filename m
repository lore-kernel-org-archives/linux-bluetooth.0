Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/2] Add serial console input handler support
Date: Mon, 13 Apr 2015 15:43:08 +0300
Message-Id: <1428928990-3016-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Input handler can be used to interact with OS from test scripts.
It is used for bluetooth testing at the moment.

Changes:
	* v1: Use CONFIG_CONSOLE_* declarations, do init in system.c,
	use correct error.
	* RFCv3: Fix overflow bug
	* RFCv2: change callback type to void, rename ISR.

Andrei Emeltchenko (2):
  Add serial console input handler
  Add UART_HOSTDRV_INTERRUPT_DRIVEN configure option

 arch/x86/bsp/driver_static_irq_stubs.s | 14 ++++++
 drivers/console/uart_console.c         | 91 ++++++++++++++++++++++++++++++++++
 drivers/console/uart_console.h         |  1 +
 make/target/kconfig/modules/io.kconf   | 16 ++++++
 4 files changed, 122 insertions(+)

-- 
2.1.0

