Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 1/2] Add serial console input handler
Date: Mon, 13 Apr 2015 15:43:09 +0300
Message-Id: <1428928990-3016-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1428928990-3016-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1428928990-3016-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Serial console handler when registered allows to interact with serial
line. It can either execute callback from ISR or defer execution to
fiber or task.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 arch/x86/bsp/driver_static_irq_stubs.s | 14 ++++++
 drivers/console/uart_console.c         | 91 ++++++++++++++++++++++++++++++++++
 drivers/console/uart_console.h         |  1 +
 make/target/kconfig/modules/io.kconf   |  8 +++
 4 files changed, 114 insertions(+)

diff --git a/arch/x86/bsp/driver_static_irq_stubs.s b/arch/x86/bsp/driver_static_irq_stubs.s
index 7ff2ab5..4c6dc44 100644
--- a/arch/x86/bsp/driver_static_irq_stubs.s
+++ b/arch/x86/bsp/driver_static_irq_stubs.s
@@ -64,6 +64,10 @@ by x86 BSPs.
 	GTEXT(_i8253IntStub)
 #endif
 
+#if defined(CONFIG_CONSOLE_HANDLER)
+	GTEXT(_console_uart_stub)
+#endif /* CONFIG_CONSOLE_HANDLER */
+
 	/* externs (internal APIs) */
 
 	GTEXT(_IntEnt)
@@ -142,4 +146,14 @@ SECTION_FUNC(TEXT, _i8253IntStub)
 	jmp     _IntExit		/* Inform kernel interrupt is done */
 #endif /* CONFIG_PIT */
 
+#if defined(CONFIG_CONSOLE_HANDLER)
+SECTION_FUNC(TEXT, _console_uart_stub)
+        call    _IntEnt            /* Inform kernel interrupt has begun */
+        pushl   $0                 /* Push dummy parameter */
+        call    console_uart_isr   /* Call actual interrupt handler */
+        call    _i8259_eoi_master  /* Inform the PIC interrupt is done */
+        addl    $4, %esp           /* Clean-up stack from push above */
+        jmp     _IntExit           /* Inform kernel interrupt is done */
+#endif /* CONFIG_CONSOLE_HANDLER */
+
 #endif /* !CONFIG_DYNAMIC_INT_STUBS */
diff --git a/drivers/console/uart_console.c b/drivers/console/uart_console.c
index 162ce7f..4088b40 100644
--- a/drivers/console/uart_console.c
+++ b/drivers/console/uart_console.c
@@ -37,8 +37,12 @@
   Hooks into the printk and fputc (for printf) modules. Poll driven.
 */
 
+#include <nanokernel.h>
+#include <nanokernel/cpu.h>
+
 #include <stdio.h>
 #include <stdint.h>
+#include <errno.h>
 
 #include <board.h>
 #include <drivers/uart.h>
@@ -106,6 +110,92 @@ extern void __printk_hook_install(int (*fn)(int));
 	} while ((0))
 #endif
 
+#if defined(CONFIG_CONSOLE_HANDLER)
+#define PACKET_MAX_SZ 1024
+static char rcv_data[PACKET_MAX_SZ];
+static uint8_t rcv_pos = 0;
+static void (*handler) (const char *string);
+
+/* Interrupt handling */
+extern void *_console_uart_stub;
+SYS_INT_REGISTER(_console_uart_stub,
+		 CONFIG_UART_CONSOLE_IRQ, CONFIG_UART_CONSOLE_INT_PRI);
+
+static int read_uart(int uart, uint8_t *buf, unsigned int size)
+{
+	int rx;
+
+	rx = uart_fifo_read(uart, buf, size);
+	if (rx < 0) {
+		/* Overrun issue. Stop the UART */
+		uart_irq_rx_disable(uart);
+
+		return -EIO;
+	}
+
+	return rx;
+}
+
+void console_uart_isr(void *unused)
+{
+	ARG_UNUSED(unused);
+
+	while (uart_irq_update(UART) && uart_irq_is_pending(UART)) {
+		/* Character(s) have been received */
+		if (uart_irq_rx_ready(UART)) {
+			int rx;
+			uint8_t byte;
+
+			rx = read_uart(UART, &byte, 1);
+			if (rx < 0)
+				return;
+
+			/* Echo back to console */
+			uart_poll_out(UART, byte);
+
+			if (byte == '\r' || rcv_pos >= sizeof(rcv_data) - 1) {
+				rcv_data[rcv_pos] = '\0';
+				uart_poll_out(UART, '\n');
+				rcv_pos = 0;
+
+				if (handler)
+					handler(rcv_data);
+			} else {
+				rcv_data[rcv_pos++] = byte;
+			}
+
+		}
+	}
+}
+
+static void console_handler_init(void)
+{
+	uint8_t c;
+
+	uart_irq_rx_disable(UART);
+	uart_irq_tx_disable(UART);
+	uart_int_connect(UART, console_uart_isr, NULL, NULL);
+
+	/* Drain the fifo */
+	while (uart_irq_rx_ready(UART))
+		uart_fifo_read(UART, &c, 1);
+
+	uart_irq_rx_enable(UART);
+}
+
+void uart_register_handler(void (*cb) (const char *string))
+{
+	handler = cb;
+}
+#else
+#define console_handler_init(x)			\
+	do {/* nothing */			\
+	} while ((0))
+#define uart_register_handler(x)		\
+	do {/* nothing */			\
+	} while ((0))
+#endif
+
 /******************************************************************************
  *
  * uartConsoleInit - initialize one UART as the console/debug port
@@ -117,4 +207,5 @@ void uartConsoleInit(void)
 {
 	__stdout_hook_install(consoleOut);
 	__printk_hook_install(consoleOut);
+	console_handler_init();
 }
diff --git a/drivers/console/uart_console.h b/drivers/console/uart_console.h
index d45b60f..bc7240c 100644
--- a/drivers/console/uart_console.h
+++ b/drivers/console/uart_console.h
@@ -40,6 +40,7 @@ extern "C" {
 #include <cputype.h>
 
 extern void uartConsoleInit(void);
+void uart_register_handler(void (*cb) (const char *string));
 
 #ifdef __cplusplus
 }
diff --git a/make/target/kconfig/modules/io.kconf b/make/target/kconfig/modules/io.kconf
index ff2cb56..acf6677 100644
--- a/make/target/kconfig/modules/io.kconf
+++ b/make/target/kconfig/modules/io.kconf
@@ -51,3 +51,11 @@ config	PRINTK
 	  rather than suppressing the generation of printk() output entirely.
 	  Output is sent immediately, without any mutual exclusion or
 	  buffering.
+
+config	CONSOLE_HANDLER
+	bool
+	prompt "Enable console input handler"
+	default n
+	help
+	  This option enables console input handler allowing to write simple
+	  interaction between serial console and OS.
-- 
2.1.0

