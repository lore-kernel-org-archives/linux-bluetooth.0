Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Par-Gunnar Hjalmdahl" <par-gunnar.p.hjalmdahl@stericsson.com>
Subject: Re: [PATCH 1/2] staging: Add ST-Ericsson CG2900 driver
Date: Wed, 23 Mar 2011 15:46:09 +0100
Cc: "Greg Kroah-Hartman" <gregkh@suse.de>,
 devel@driverdev.osuosl.org,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org,
 Pavan Savoy <pavan_savoy@sify.com>,
 Vitaly Wool <vitalywool@gmail.com>,
 Alan Cox <alan@lxorguk.ukuu.org.uk>,
 Marcel Holtmann <marcel@holtmann.org>,
 Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>,
 Lee Jones <lee.jones@linaro.org>
References: <1300888771-26437-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
In-Reply-To: <1300888771-26437-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201103231546.10206.arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 23 March 2011, Par-Gunnar Hjalmdahl wrote:
> +TODO
> +----
> +
> + - Decide upon architecture. Some people consider architecture in the cg2900
> +   driver to be too complex. We consider it to be not more complex than needed.
> +
> + - Currently the cg2900_uart registers as protocol driver against hci_ldisc.c.
> +   There is however some common functionality with hci_h4.c and the cg2900 could
> +   therefore register it's vendor specific channels to hci_h4.c, but this would
> +   require adding a registration functionality in the hci_h4 file.
> +
> + - Some people demand that the cg2900 driver re-use the Bluetooth driver to send
> +   and receive BT commands and events. That is however not possible with current
> +   BT API and might not be feasible, for example when using FM only in
> +   the cg2900 chip.
> +
> + - TI has already delivered a driver for a multi-function chip called ti-st.
> +   This driver is currently located in drivers/misc/ti-st/. There has however
> +   been criticism raised against design/architecture of the driver. There
> +   currently also doesn't seem to be a way to add support for cg2900 in that
> +   driver even though some people has raised this as an alternative.

I assume that this TODO list will evolve a bit as we start resume the
driver. For now, I'm fine this patch going into staging (aside from
my comments on patch 2/2). I'll do a new review soon, please ping me
again if I haven't done it by next week.

	Arnd
