Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1300888771-26437-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
References: <1300888771-26437-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
Date: Wed, 23 Mar 2011 15:53:22 +0100
Message-ID: <AANLkTiny00_uryo3UeHQX-vk2CdN9GV45QmoeFKcRotc@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: Add ST-Ericsson CG2900 driver
From: Vitaly Wool <vitalywool@gmail.com>
To: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, Pavan Savoy <pavan_savoy@sify.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus Walleij <linus.walleij@stericsson.com>, Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 23, 2011 at 2:59 PM, Par-Gunnar Hjalmdahl
<par-gunnar.p.hjalmdahl@stericsson.com> wrote:
> diff --git a/drivers/staging/cg2900/TODO b/drivers/staging/cg2900/TODO
> new file mode 100644
> index 0000000..f6fb76a
> --- /dev/null
> +++ b/drivers/staging/cg2900/TODO
> @@ -0,0 +1,21 @@
> +TODO
> +----
> +
> + - Decide upon architecture. Some people consider architecture in the cg=
2900
> + =A0 driver to be too complex. We consider it to be not more complex tha=
n needed.
> +
> + - Currently the cg2900_uart registers as protocol driver against hci_ld=
isc.c.
> + =A0 There is however some common functionality with hci_h4.c and the cg=
2900 could
> + =A0 therefore register it's vendor specific channels to hci_h4.c, but t=
his would
> + =A0 require adding a registration functionality in the hci_h4 file.
> +
> + - Some people demand that the cg2900 driver re-use the Bluetooth driver=
 to send
> + =A0 and receive BT commands and events. That is however not possible wi=
th current
> + =A0 BT API and might not be feasible, for example when using FM only in
> + =A0 the cg2900 chip.
> +
> + - TI has already delivered a driver for a multi-function chip called ti=
-st.
> + =A0 This driver is currently located in drivers/misc/ti-st/. There has =
however
> + =A0 been criticism raised against design/architecture of the driver. Th=
ere
> + =A0 currently also doesn't seem to be a way to add support for cg2900 i=
n that
> + =A0 driver even though some people has raised this as an alternative.

As someone who is definitely the part of these demotivating and
unreasonable "some people" I have to say that even though I'm okay
with this driver going into staging, I see a huge gap between the
desire of its creators to have something generic and the ability to do
so. I am absolutely sure that given the widely advertised
peculiarities of this chip, the authors should stop trying to come up
with a generic solution and just present a simplistic MFD driver for
their particular device.

Thanks,
   Vitaly
