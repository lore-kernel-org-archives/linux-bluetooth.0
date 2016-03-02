Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Cathy Luo" <cluo@marvell.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nishant Sarmukadam <nishants@marvell.com>,
	Ganapathi Bhat <gbhat@marvell.com>
Subject: RE: [PATCH v3] Bluetooth: hci_uart: Support firmware download for
 Marvell
Date: Wed, 2 Mar 2016 06:47:50 +0000
Message-ID: <f04d2664b8c54469a64495cc44445b79@SC-EXCH04.marvell.com>
References: <1456852109-14298-1-git-send-email-akarwar@marvell.com>
 <20160301215924.6b884508@lxorguk.ukuu.org.uk>
In-Reply-To: <20160301215924.6b884508@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

> From: One Thousand Gnomes [mailto:gnomes@lxorguk.ukuu.org.uk]
> Sent: Wednesday, March 02, 2016 3:29 AM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; Cathy Luo; linux-
> kernel@vger.kernel.org; Nishant Sarmukadam; Ganapathi Bhat
> Subject: Re: [PATCH v3] Bluetooth: hci_uart: Support firmware download
> for Marvell
> 
> O
> > +/* Get standard baud rate, given the speed */ static unsigned int
> > +get_baud_rate(unsigned int speed) {
> > +	switch (speed) {
> > +	case 9600:
> > +		return B9600;
> > +	case 19200:
> > +		return B19200;
> > +	case 38400:
> > +		return B38400;
> > +	case 57600:
> > +		return B57600;
> > +	case 115200:
> > +		return B115200;
> > +	case 230400:
> > +		return B230400;
> > +	case 460800:
> > +		return B460800;
> > +	case 921600:
> > +		return B921600;
> > +	case 2000000:
> > +		return B2000000;
> > +	case 3000000:
> > +		return B3000000;
> > +	default:
> > +		return -1;
> > +	}
> > +}
> 
> 
> NAK. Please use the existing kernel helpers for this
> 
> 
>  +
> > +/* Set terminal properties */
> > +static int mrvl_set_term_baud(struct tty_struct *tty, unsigned int
> speed,
> > +			      unsigned char flow_ctl)
> > +{
> > +	struct ktermios old_termios = tty->termios;
> > +	int baud;
> > +
> > +	tty->termios.c_cflag &= ~CBAUD;
> > +	baud = get_baud_rate(speed);
> > +
> > +	if (baud == -1) {
> > +		BT_ERR("Baud rate not supported");
> > +		return -1;
> > +	}
> > +
> > +	tty->termios.c_cflag |= baud;
> > +
> 
> This isn't the correct way to do any of this, just do
> 
> 	tty_termios_encode_baud_rate(&tty->termios, speed, speed)
> 
> 
> > +	if (flow_ctl)
> > +		tty->termios.c_cflag |= CRTSCTS;
> > +	else
> > +		tty->termios.c_cflag &= ~CRTSCTS;
> > +
> > +	tty->ops->set_termios(tty, &old_termios);
> 
> Call the provided kernel helpers that get the locking right.
> 
> tty_set_termios(tty, &new_termios);
> 
> You should also do your error checking here and see what baud rate was
> actually provided by the hardware (tty_get_baud_rate(tty)) by checking
> the value actually selected by the tty.
> 
> > +	/* restore uart settings */
> > +	new_termios = tty->termios;
> > +	tty->termios.c_cflag = old_termios.c_cflag;
> > +	tty->ops->set_termios(tty, &new_termios);
> > +	clear_bit(HCI_UART_DNLD_FW, &hu->flags);
> 
> Again use the proper helpers
> 
> > +
> > +set_baud:
> > +	ret = mrvl_set_baud(hu);
> > +	if (ret)
> > +		goto fail;
> > +
> > +	mdelay(MRVL_DNLD_DELAY);
> 
> Why not msleep() ?
> 
> > +
> > +	return ret;
> > +fail:
> > +	/* restore uart settings */
> > +	new_termios = tty->termios;
> > +	tty->termios.c_cflag = old_termios.c_cflag;
> > +	tty->ops->set_termios(tty, &new_termios);
> > +	clear_bit(HCI_UART_DNLD_FW, &hu->flags);
> > +
> 

Thanks for review. We will work on these comments.

Regards,
Amitkumar
