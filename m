Return-Path: <pavel@ucw.cz>
Date: Fri, 26 Aug 2016 22:12:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Loic Poulain <loic.poulain@intel.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/6] serio: serport: add support for buffered write
 and receive
Message-ID: <20160826201202.GA27227@amd>
References: <20160824232437.9446-1-robh@kernel.org>
 <20160824232437.9446-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160824232437.9446-6-robh@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> @@ -133,26 +133,29 @@ static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *c
>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		goto out;
>  
> -	for (i = 0; i < count; i++) {
> -		if (fp) {
> -			switch (fp[i]) {
> -			case TTY_FRAME:
> -				ch_flags = SERIO_FRAME;
> -				break;
> -
> -			case TTY_PARITY:
> -				ch_flags = SERIO_PARITY;
> -				break;
> -
> -			default:
> -				ch_flags = 0;
> -				break;
> +	if (serio_buffered_mode_enabled(serport->serio)) {
> +		serio_receive_buf(serport->serio, cp, count);

Elsewhere:
+       /* Use buffer receive if the driver provides a callback */
+       if (drv->receive_buf)
+               set_bit(SERIO_MODE_BUFFERED, &drv->flags);

Could we use if (drv->receive_buf) above directly, and not require the
bitfield?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
