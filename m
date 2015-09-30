Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Revert "serial: 8250_dma: don't bother DMA with small
 transfers"
To: Frederic Danis <frederic.danis@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1443617191-21013-1-git-send-email-frederic.danis@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org
From: Peter Hurley <peter@hurleysoftware.com>
Message-ID: <560BE919.9020803@hurleysoftware.com>
Date: Wed, 30 Sep 2015 09:52:25 -0400
MIME-Version: 1.0
In-Reply-To: <1443617191-21013-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[ + Andy Shevchenko ]

On 09/30/2015 08:46 AM, Frederic Danis wrote:
> This reverts commit 9119fba0cfeda6d415c9f068df66838a104b87cb.

Hi Frederic,

It's customary to mail the commit author in patches which revert
their work.

> This commit prevents from sending "big" file using Bluetooth.
> When sending a lot of data quickly through the Bluetooth interface, and
> after a variable amount of data sent, transfer fails with error:
>     kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00

Hmmm, was there any other information regarding why this happened?
Eg., did the driver mistakenly re-order i/o (DMA occurred after PIO)?
Or, might there be some race condition in the dmaengine driver on this
platform?

Regards,
Peter Hurley

> Found on T100TA.
> 
> After reverting this commit, send works fine for any file size.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 21d01a4..e508939 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -80,10 +80,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
>  		return 0;
>  
>  	dma->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> -	if (dma->tx_size < p->port.fifosize) {
> -		ret = -EINVAL;
> -		goto err;
> -	}
>  
>  	desc = dmaengine_prep_slave_single(dma->txchan,
>  					   dma->tx_addr + xmit->tail,
> 

