Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-serial@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Revert "serial: 8250_dma: don't bother DMA with small transfers"
Date: Wed, 30 Sep 2015 14:46:31 +0200
Message-Id: <1443617191-21013-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit 9119fba0cfeda6d415c9f068df66838a104b87cb.

This commit prevents from sending "big" file using Bluetooth.
When sending a lot of data quickly through the Bluetooth interface, and
after a variable amount of data sent, transfer fails with error:
    kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00

Found on T100TA.

After reverting this commit, send works fine for any file size.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 21d01a4..e508939 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -80,10 +80,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 		return 0;
 
 	dma->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
-	if (dma->tx_size < p->port.fifosize) {
-		ret = -EINVAL;
-		goto err;
-	}
 
 	desc = dmaengine_prep_slave_single(dma->txchan,
 					   dma->tx_addr + xmit->tail,
-- 
1.9.1

