Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jan 2014 20:37:32 +0100
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, peter@hurleysoftware.com,
	"linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rfcomm: always wait for a bt connection on open()
Message-ID: <20140106193732.GA24137@sottospazio.it>
References: <1389033795-23895-1-git-send-email-gianluca@sottospazio.it>
 <1389033795-23895-4-git-send-email-gianluca@sottospazio.it>
 <4321EF0E-97F4-4236-B763-0D0213BE97A8@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4321EF0E-97F4-4236-B763-0D0213BE97A8@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 06, 2014 at 11:17:06AM -0800, Marcel Holtmann wrote:
> don’t do an if-else-else if statement here. Just break.
> 
> 	if (dev->dlc->state == BT_CLOSED) {
> 		..
> 		break;	
> 	}
> 
> 	if (dev->dlc->state == BT_CONNECTED)
> 		break;
> 
> 	if (signal_pending(..)) {
> 		..
> 		break;
> 	}

I'll change the code.

> > -	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL;
> > +	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL | CLOCAL;
> 
> Is adding CLOCAL by default intentional?

Yes, I removed it before because I relied on the carrier_raised() tty_port
method. But it turned out it wasn't a good idea because some code (wvdial
for example) set that flag on exit, leaving a non-working tty for subsequent
open() calls.

Now I restored the original flags, even if CLOCAL is actually ignored by the
code.

I will shortly send a third iteration with the fixed if statements.

Thanks,
Gianluca

> > 	rfcomm_tty_driver->init_termios.c_lflag &= ~ICANON;
> > 	tty_set_operations(rfcomm_tty_driver, &rfcomm_ops);
> 
> Regards
> 
> Marcel
> 
