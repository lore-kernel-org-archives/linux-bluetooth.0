Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960811301800o114b9b58pafeae86c09d668e9@mail.gmail.com>
References: <35c90d960811201824o64e0d814s8cf55ba6ee145517@mail.gmail.com>
	 <1228035841.9176.9.camel@violet.holtmann.net>
	 <35c90d960811301800o114b9b58pafeae86c09d668e9@mail.gmail.com>
Date: Sun, 30 Nov 2008 18:02:20 -0800
Message-ID: <35c90d960811301802l62b26c0eq72e896e48ea917b3@mail.gmail.com>
Subject: Re: patch: Respect HCI_UART_DEBUG config in hci_ll.c
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Author: Nick Pelly <npelly@google.com>
Date:   Mon Apr 21 12:18:51 2008 -0700

  bluetooth: Respect HCI_UART_DEBUG config in hci_ll.c

  Following the pattern from hci_*.c, turn off BT_DBG messages unless
  they have been requested via HCI_UART_DEBUG

  Signed-off-by: Nick Pelly <npelly@google.com>
  Acked-by: Brian Swetland <swetland@google.com>

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index b91d45a..2d2f66e 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -51,6 +51,11 @@

 #include "hci_uart.h"

+#ifndef CONFIG_BT_HCIUART_DEBUG
+#undef  BT_DBG
+#define BT_DBG( A... )
+#endif
+
 /* HCILL commands */
 #define HCILL_GO_TO_SLEEP_IND  0x30
 #define HCILL_GO_TO_SLEEP_ACK  0x31
