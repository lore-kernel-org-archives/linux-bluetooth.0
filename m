Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v4 4/5] Bluetooth: Remove useless rx_lock spinlock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442305868-6203-5-git-send-email-frederic.danis@linux.intel.com>
Date: Wed, 16 Sep 2015 04:59:39 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <09AB7A04-33F5-4160-B08D-FF29B93601A7@holtmann.org>
References: <1442305868-6203-1-git-send-email-frederic.danis@linux.intel.com> <1442305868-6203-5-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> rx_lock spinlock is only used in hci_uart_tty_receive() which is the
> receive_buf ldisc callback.
> In drivers/tty/tty_buffer.c we can see that flush_to_ldisc (work) locks
> a mutex (&buf->lock) and push the data to ldisc via receive_buf.

please be a bit more verbose why this is correct.

> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 5 -----
> drivers/bluetooth/hci_uart.h  | 1 -
> 2 files changed, 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 0d5a05a..dbb0a78 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -470,8 +470,6 @@ static int hci_uart_tty_open(struct tty_struct *tty)
> 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
> 	INIT_WORK(&hu->write_work, hci_uart_write_work);
> 
> -	spin_lock_init(&hu->rx_lock);
> -
> 	/* Flush any pending characters in the driver and line discipline. */
> 
> 	/* FIXME: why is this needed. Note don't use ldisc_ref here as the
> @@ -569,14 +567,11 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
> 	if (!test_bit(HCI_UART_PROTO_SET, &hu->flags))
> 		return;
> 
> -	spin_lock(&hu->rx_lock);

And here I would add a comment why we do not need the lock.

> 	hu->proto->recv(hu, data, count);
> 
> 	if (hu->hdev)
> 		hu->hdev->stat.byte_rx += count;
> 
> -	spin_unlock(&hu->rx_lock);
> -
> 	tty_unthrottle(tty);
> }
> 
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 495b9ef..2f7bb35 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -85,7 +85,6 @@ struct hci_uart {
> 
> 	struct sk_buff		*tx_skb;
> 	unsigned long		tx_state;
> -	spinlock_t		rx_lock;
> 
> 	unsigned int init_speed;
> 	unsigned int oper_speed;

Regards

Marcel

