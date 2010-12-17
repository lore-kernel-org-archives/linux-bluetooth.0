Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1292585117-28584-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
References: <1292585117-28584-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
Date: Fri, 17 Dec 2010 13:02:52 +0100
Message-ID: <AANLkTimjDCF4V9wGszVcuDYqZ8Qq0CYhCzxnxEKcibxN@mail.gmail.com>
Subject: Re: [PATCH 08/11] Bluetooth: Add support for CG2900 UART
From: Vitaly Wool <vitalywool@gmail.com>
To: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: Pavan Savoy <pavan_savoy@sify.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Samuel Ortiz <sameo@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Linus Walleij <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Par,

so on the top level: this is yet another H4 implementation plus
channel-based packet routing, right?

Could you please also elaborate

More comments on the code are inlined.

> +#define MAIN_DEV =A0 =A0 =A0 =A0 =A0 =A0 =A0 (uart_info->dev)

What is that for?

> + * cg2900_uart_suspend() - Called by Linux PM to put the device in a low=
 power mode.
> + * @pdev: =A0 =A0 =A0Pointer to platform device.
> + * @state: =A0 =A0 New state.
> + *
> + * In UART case, CG2900 driver does nothing on suspend.
> + *
> + * Returns:
> + * =A0 0 - Success.
> + */
> +static int cg2900_uart_suspend(struct platform_device *pdev, pm_message_=
t state)
> +{
> + =A0 =A0 =A0 struct uart_info *uart_info =3D dev_get_drvdata(&pdev->dev)=
;
> +
> + =A0 =A0 =A0 if (uart_info->sleep_state =3D=3D CHIP_POWERED_DOWN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (uart_info->sleep_state !=3D CHIP_ASLEEP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> +
> + =A0 =A0 =A0 dev_dbg(MAIN_DEV, "New sleep_state: CHIP_SUSPENDED\n");
> + =A0 =A0 =A0 uart_info->sleep_state =3D CHIP_SUSPENDED;
> + =A0 =A0 =A0 return 0;
> +}

I don't think this is safe wrt work queue. What if it gets scheduled
when drivers are suspended?

Thanks,
   Vitaly
