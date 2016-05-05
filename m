Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ganapathi Bhat <gbhat@marvell.com>
Subject: RE: [PATCH v10 3/3] Bluetooth: hci_uart: Support firmware download
 for Marvell
Date: Thu, 5 May 2016 15:34:53 +0000
Message-ID: <14835803c03d47bebec4537e985180fc@SC-EXCH04.marvell.com>
References: <1462460902-25439-1-git-send-email-akarwar@marvell.com>
	<1462460902-25439-3-git-send-email-akarwar@marvell.com>
 <20160505162238.44f7ed6d@lxorguk.ukuu.org.uk>
In-Reply-To: <20160505162238.44f7ed6d@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

> From: One Thousand Gnomes [mailto:gnomes@lxorguk.ukuu.org.uk]
> Sent: Thursday, May 05, 2016 8:53 PM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> Ganapathi Bhat
> Subject: Re: [PATCH v10 3/3] Bluetooth: hci_uart: Support firmware
> download for Marvell
> 
> > +/* Send ACK/NAK to the device */
> > +static void mrvl_send_ack(struct hci_uart *hu, unsigned char ack) {
> > +	struct tty_struct *tty = hu->tty;
> > +
> > +	tty->ops->write(tty, &ack, sizeof(ack)); }
> 
> You don't know if the device has a write method, and it should be
> locked.
> This should go via your ldisc not directly.
> 

Thanks for review. We will take care of this.

Regards,
Amitkumar
