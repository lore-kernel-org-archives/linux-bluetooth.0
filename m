Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 07:31:44 -0700
From: Greg KH <gregkh@suse.de>
To: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: devel@driverdev.osuosl.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] staging: Add ST-Ericsson CG2900 driver
Message-ID: <20110323143144.GB17369@suse.de>
References: <1300888771-26437-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300888771-26437-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 23, 2011 at 02:59:31PM +0100, Par-Gunnar Hjalmdahl wrote:
> +TODO
> +----
> +
> + - Decide upon architecture. Some people consider architecture in the cg2900
> +   driver to be too complex. We consider it to be not more complex than needed.

What do you mean by this?  It sounds as if you do not consider this a
valid thing.  If so, why list it?

> + - Currently the cg2900_uart registers as protocol driver against hci_ldisc.c.
> +   There is however some common functionality with hci_h4.c and the cg2900 could
> +   therefore register it's vendor specific channels to hci_h4.c, but this would
> +   require adding a registration functionality in the hci_h4 file.

Putting a "but" makes it sound like this is something you will not do.
If so, why list it?

> + - Some people demand that the cg2900 driver re-use the Bluetooth driver to send
> +   and receive BT commands and events. That is however not possible with current
> +   BT API and might not be feasible, for example when using FM only in
> +   the cg2900 chip.

Again, a review comment that you are saying is not valid.  Why list it?

> + - TI has already delivered a driver for a multi-function chip called ti-st.
> +   This driver is currently located in drivers/misc/ti-st/. There has however
> +   been criticism raised against design/architecture of the driver. There
> +   currently also doesn't seem to be a way to add support for cg2900 in that
> +   driver even though some people has raised this as an alternative.

And again, the same thing.

What criticism of that driver?  It's now accepted and is working and in
the tree.

My main point here is that this looks like a rant against people who
have reviewed your code in the past and why you feel you can not address
those complaints.  That's not a valid thing for a TODO file at all.
Please list things that need to be fixed in the driver to get it merged
into the main tree.  As it is, you have a list of things that you say
you will not do, which is not encouraging at all.

> diff --git a/drivers/staging/cg2900/bluetooth/Makefile b/drivers/staging/cg2900/bluetooth/Makefile
> new file mode 100644
> index 0000000..6f4255b
> --- /dev/null
> +++ b/drivers/staging/cg2900/bluetooth/Makefile
> @@ -0,0 +1,9 @@
> +#
> +# Makefile for ST-Ericsson CG2900 connectivity combo controller
> +#
> +
> +ccflags-y :=					\
> +	-Idrivers/staging/cg2900/include
> +	

Trailing whitespace, did you run this through checkpatch.pl before
sending it to me?

thanks,

greg k-h
