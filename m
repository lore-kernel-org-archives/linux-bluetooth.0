Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 5 May 2016 16:22:38 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ganapathi Bhat <gbhat@marvell.com>
Subject: Re: [PATCH v10 3/3] Bluetooth: hci_uart: Support firmware download
 for Marvell
Message-ID: <20160505162238.44f7ed6d@lxorguk.ukuu.org.uk>
In-Reply-To: <1462460902-25439-3-git-send-email-akarwar@marvell.com>
References: <1462460902-25439-1-git-send-email-akarwar@marvell.com>
	<1462460902-25439-3-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> +/* Send ACK/NAK to the device */
> +static void mrvl_send_ack(struct hci_uart *hu, unsigned char ack)
> +{
> +	struct tty_struct *tty = hu->tty;
> +
> +	tty->ops->write(tty, &ack, sizeof(ack));
> +}

You don't know if the device has a write method, and it should be locked.
This should go via your ldisc not directly.

Alan
