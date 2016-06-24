Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [v11, 2/3] Bluetooth: hci_uart: check if hdev is present before
 using it
To: Amitkumar Karwar <akarwar@marvell.com>,
	linux-bluetooth@vger.kernel.org
References: <1462548714-7971-2-git-send-email-akarwar@marvell.com>
Cc: linux-kernel@vger.kernel.org, Ganapathi Bhat <gbhat@marvell.com>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Message-ID: <576CCCD2.7070506@rock-chips.com>
Date: Fri, 24 Jun 2016 14:01:54 +0800
MIME-Version: 1.0
In-Reply-To: <1462548714-7971-2-git-send-email-akarwar@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2016-5-6 23:31, Amitkumar Karwar wrote:
> From: Ganapathi Bhat <gbhat@marvell.com>
>
> The hdev struct might not have initialized in protocol receive handler.
> This patch adds necessary checks.
>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
>   drivers/bluetooth/hci_ldisc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index b4ee682..047e786 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -154,7 +154,9 @@ restart:
>   
>   		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
>   		len = tty->ops->write(tty, skb->data, skb->len);
> -		hdev->stat.byte_tx += len;
> +
> +		if (hdev)
> +			hdev->stat.byte_tx += len;
>   
>   		skb_pull(skb, len);
>   		if (skb->len) {
> @@ -349,7 +351,7 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
>   	/* tty_set_termios() return not checked as it is always 0 */
>   	tty_set_termios(tty, &ktermios);
>   
> -	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev->name,
> +	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev ? hu->hdev->name : "",
>   	       tty->termios.c_ispeed, tty->termios.c_ospeed);
>   }
>   
>
>
This serial of patches work well on my device...

Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>

