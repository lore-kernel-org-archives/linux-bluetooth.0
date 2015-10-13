Return-Path: <cyrus@holtmann.org>
Message-ID: <1444745448.8361.618.camel@linux.intel.com>
Subject: Re: [PATCH v3] Revert "serial: 8250_dma: don't bother DMA with
 small transfers"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-serial@vger.kernel.org, peter@hurleysoftware.com,
	gregkh@linuxfoundation.org
Cc: linux-bluetooth@vger.kernel.org, heikki.krogerus@linux.intel.com,
	marcel@holtmann.org
Date: Tue, 13 Oct 2015 17:10:48 +0300
In-Reply-To: <1444403696-9223-1-git-send-email-frederic.danis@linux.intel.com>
References: 
	<1444403696-9223-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2015-10-09 at 17:14 +0200, Frederic Danis wrote:
> This reverts commit 9119fba0cfeda6d415c9f068df66838a104b87cb.
> 
> This commit prevents from sending "big" file using Bluetooth.
> When sending a lot of data quickly through the Bluetooth interface, 
> and
> after a variable amount of data sent, transfer fails with error:
>     kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00
> 
> Found on T100TA.
> 
> After reverting this commit, send works fine for any file size.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> Fixes: 9119fba0cfed (serial: 8250_dma: don't bother DMA with small
> transfers)
> Cc: stable@vger.kernel.org

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
> v3: Add Fixes and Cc tags
> v2: Re-send to correct people
> 
>  drivers/tty/serial/8250/8250_dma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c 
> b/drivers/tty/serial/8250/8250_dma.c
> index b503071..78259d3 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -77,10 +77,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
>  		return 0;
>  
>  	dma->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, 
> UART_XMIT_SIZE);
> -	if (dma->tx_size < p->port.fifosize) {
> -		ret = -EINVAL;
> -		goto err;
> -	}
>  
>  	desc = dmaengine_prep_slave_single(dma->txchan,
>  					   dma->tx_addr + xmit
> ->tail,

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
