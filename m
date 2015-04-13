Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/2] Add UART_HOSTDRV_INTERRUPT_DRIVEN configure option
Date: Mon, 13 Apr 2015 15:43:10 +0300
Message-Id: <1428928990-3016-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1428928990-3016-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1428928990-3016-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Configure option UART_HOSTDRV_INTERRUPT_DRIVEN enables ISR support
making it possible to use CONSOLE_HANDLER and other dependent options.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 make/target/kconfig/modules/io.kconf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/make/target/kconfig/modules/io.kconf b/make/target/kconfig/modules/io.kconf
index acf6677..ec4461a 100644
--- a/make/target/kconfig/modules/io.kconf
+++ b/make/target/kconfig/modules/io.kconf
@@ -52,6 +52,14 @@ config	PRINTK
 	  Output is sent immediately, without any mutual exclusion or
 	  buffering.
 
+config	UART_HOSTDRV_INTERRUPT_DRIVEN
+	bool
+	prompt "Interrupt driven console support"
+	default n
+	help
+	  This option enables interrupt support for UART allowing console
+	  input.
+
 config	CONSOLE_HANDLER
 	bool
 	prompt "Enable console input handler"
-- 
2.1.0

