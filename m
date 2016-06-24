Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [v11, 1/3] Bluetooth: hci_uart: add prepare callbacks to
 hci_uart_proto structure.
To: Amitkumar Karwar <akarwar@marvell.com>,
	linux-bluetooth@vger.kernel.org
References: <1462548714-7971-1-git-send-email-akarwar@marvell.com>
Cc: linux-kernel@vger.kernel.org, Ganapathi Bhat <gbhat@marvell.com>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Message-ID: <576CCCC4.9050509@rock-chips.com>
Date: Fri, 24 Jun 2016 14:01:40 +0800
MIME-Version: 1.0
In-Reply-To: <1462548714-7971-1-git-send-email-akarwar@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2016-5-6 23:31, Amitkumar Karwar wrote:
> From: Ganapathi Bhat <gbhat@marvell.com>
>
> The new callback is used to prepare the device before HCI becomes
> ready. One can use this to download firmware if the download process
> doesn't use HCI commands. Also recv_for_prepare callback is
> introduced for receiving data from devices during prepare phase.
>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
>   drivers/bluetooth/hci_ldisc.c | 11 ++++++++++-
>   drivers/bluetooth/hci_uart.h  |  3 +++
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 49b3e1e..b4ee682 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -551,8 +551,11 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
>   	if (!hu || tty != hu->tty)
>   		return;
>   
> -	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
> +	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
> +		if (hu->proto->recv_for_prepare)
> +			hu->proto->recv_for_prepare(hu, data, count);
>   		return;
> +	}
>   
>   	/* It does not need a lock here as it is already protected by a mutex in
>   	 * tty caller
> @@ -639,6 +642,12 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
>   		return err;
>   
>   	hu->proto = p;
> +	if (p->prepare) {
> +		err = p->prepare(hu);
> +		if (err)
> +			return err;
> +	}
> +
>   	set_bit(HCI_UART_PROTO_READY, &hu->flags);
>   
>   	err = hci_uart_register_dev(hu);
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 839bad1..17ba3b4 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -67,8 +67,11 @@ struct hci_uart_proto {
>   	int (*close)(struct hci_uart *hu);
>   	int (*flush)(struct hci_uart *hu);
>   	int (*setup)(struct hci_uart *hu);
> +	int (*prepare)(struct hci_uart *hu);
>   	int (*set_baudrate)(struct hci_uart *hu, unsigned int speed);
>   	int (*recv)(struct hci_uart *hu, const void *data, int len);
> +	int (*recv_for_prepare)(struct hci_uart *hu, const void *data,
> +				int len);
>   	int (*enqueue)(struct hci_uart *hu, struct sk_buff *skb);
>   	struct sk_buff *(*dequeue)(struct hci_uart *hu);
>   };
>
>
This serial of patches work well on my device...

Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>

