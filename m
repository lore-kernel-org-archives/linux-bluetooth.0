Return-Path: <cyrus@holtmann.org>
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Maxim Krasnyansky <maxk@qualcomm.com>,
        bluez-devel@lists.sourceforge.net
Subject: [PATCH] drivers/bluetooth/: Spelling fixes
Date: Mon, 17 Dec 2007 11:30:30 -0800
Message-Id: <1197919875-5288-31-git-send-email-joe@perches.com>
Message-Id: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918890.git.joe@perches.com>
List-ID: <bluez-devel.lists.sourceforge.net>


Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/bluetooth/btuart_cs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 08f48d5..dade162 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -383,7 +383,7 @@ static void btuart_change_speed(btuart_info_t *info, unsigned int speed)
 	outb(lcr, iobase + UART_LCR);	/* Set 8N1  */
 	outb(fcr, iobase + UART_FCR);	/* Enable FIFO's */
 
-	/* Turn on interrups */
+	/* Turn on interrupts */
 	outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
 
 	spin_unlock_irqrestore(&(info->lock), flags);
-- 
1.5.3.7.949.g2221a6
