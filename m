Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2 3/5] Bluetooth: hci_uart: Support operational speed during setup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431008699-6419-3-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 7 May 2015 17:13:28 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F52177DA-151A-436D-85A5-51FABF054B24@holtmann.org>
References: <1431008699-6419-1-git-send-email-frederic.danis@linux.intel.com> <1431008699-6419-3-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Add default and operational speeds.
> Change to operational speed as soon as possible.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 26 ++++++++++++++++++++++++++
> drivers/bluetooth/hci_uart.h  |  4 ++++
> 2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 2b5d946..071f09c 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -265,11 +265,37 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	return 0;
> }
> 
> +void hci_uart_set_baudrate(struct hci_uart *hu, unsigned long speed)
> +{
> +	struct tty_struct *tty = hu->tty;
> +	struct ktermios ktermios;
> +
> +	ktermios = tty->termios;
> +	ktermios.c_cflag &= ~CBAUD;
> +	ktermios.c_cflag |= BOTHER;
> +	tty_termios_encode_baud_rate(&ktermios, speed, speed);
> +
> +	tty_set_termios(tty, &ktermios);
> +
> +	BT_DBG("%s: New tty speed: %d", hu->hdev->name, tty->termios.c_ispeed);
> +}
> +
> static int hci_uart_setup(struct hci_dev *hdev)
> {
> 	struct hci_uart *hu = hci_get_drvdata(hdev);
> 	struct hci_rp_read_local_version *ver;
> 	struct sk_buff *skb;
> +	int err;
> +
> +	if (hu->proto->default_speed)
> +		hci_uart_set_baudrate(hu, hu->proto->default_speed);
> +
> +	if (hu->proto->set_baudrate && hu->proto->operational_speed) {
> +		err = hu->proto->set_baudrate(hu, hu->proto->operational_speed);
> +		if (err)
> +			return err;
> +		hci_uart_set_baudrate(hu, hu->proto->operational_speed);
> +	}
> 
> 	if (hu->proto->setup)
> 		return hu->proto->setup(hu);
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 72120a5..572ac04 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -58,10 +58,13 @@ struct hci_uart;
> struct hci_uart_proto {
> 	unsigned int id;
> 	const char *name;
> +	unsigned long default_speed;
> +	unsigned long operational_speed;

I get the feeling we want init_speed and oper_speed here to keep it shorter.
 
> 	int (*open)(struct hci_uart *hu);
> 	int (*close)(struct hci_uart *hu);
> 	int (*flush)(struct hci_uart *hu);
> 	int (*setup)(struct hci_uart *hu);
> +	int (*set_baudrate)(struct hci_uart *hu, int speed);

So what is the speed now? int or unsigned long?

> 	int (*recv)(struct hci_uart *hu, const void *data, int len);
> 	int (*enqueue)(struct hci_uart *hu, struct sk_buff *skb);
> 	struct sk_buff *(*dequeue)(struct hci_uart *hu);
> @@ -96,6 +99,7 @@ int hci_uart_register_proto(const struct hci_uart_proto *p);
> int hci_uart_unregister_proto(const struct hci_uart_proto *p);
> int hci_uart_tx_wakeup(struct hci_uart *hu);
> int hci_uart_init_ready(struct hci_uart *hu);
> +void hci_uart_set_baudrate(struct hci_uart *hu, unsigned long speed);

Regards

Marcel

