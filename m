Return-Path: <paul.gortmaker@gmail.com>
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1471058078-5579-6-git-send-email-sre@kernel.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org> <1471058078-5579-6-git-send-email-sre@kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 14 Aug 2016 19:54:28 -0400
Message-ID: <CAP=VYLo4ptVzhPjKoiiakbCgBSmpQndNzf0LHWxCZs7LiZ7PYw@mail.gmail.com>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Ville Tervo <ville.tervo@iki.fi>, =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 12, 2016 at 11:14 PM, Sebastian Reichel <sre@kernel.org> wrote:
> This driver adds support for Nokia H4+ procotol used
> for example by Nokia's internet tablets (N770 - N950).
> ---
>  drivers/bluetooth/Kconfig     |  10 +
>  drivers/bluetooth/Makefile    |   1 +
>  drivers/bluetooth/hci_ldisc.c |   6 +
>  drivers/bluetooth/hci_nokia.c | 734 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_nokia.h | 140 ++++++++
>  drivers/bluetooth/hci_uart.h  |   8 +-
>  6 files changed, 898 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/bluetooth/hci_nokia.c
>  create mode 100644 drivers/bluetooth/hci_nokia.h
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index cf50fd2e96df..c32d9d5ad1d2 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -86,6 +86,16 @@ config BT_HCIUART_H4
>
>           Say Y here to compile support for HCI UART (H4) protocol.
>
> +config BT_HCIUART_NOKIA
> +       bool "UART Nokia H4+ protocol support"

If the option is a bool, then you don't need module.h or any MODULE
macros, nor do you need any __exit or unregister related code.

Alternatively, if there is a use case for it to be modular, then maybe you
want to change the above to a tristate.

Paul.
--

> +       depends on BT_HCIUART
> +       help
> +         Nokia H4+ is serial protocol for communication between Bluetooth
> +         device and host. This protocol is required for Bluetooth devices
> +         with UART interface in Nokia devices.
> +
> +         Say Y here to compile support for Nokia's H4+ protocol.
> +
>  config BT_HCIUART_BCSP
>         bool "BCSP protocol support"
>         depends on BT_HCIUART


[...]

> +       { .compatible = "nokia,ti,wl1271-bluetooth", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
> +
> +static struct platform_driver platform_nokia_driver = {
> +       .driver = {
> +               .name = "nokia-bluetooth",
> +               .of_match_table = nokia_bluetooth_of_match,
> +       },
> +       .probe = nokia_bluetooth_probe,
> +};
> +
> +int __init nokia_init(void)
> +{
> +       platform_driver_register(&platform_nokia_driver);
> +       return hci_uart_register_proto(&nokia_proto);
> +}
> +
> +int __exit nokia_deinit(void)
> +{
> +       platform_driver_unregister(&platform_nokia_driver);
> +       return hci_uart_unregister_proto(&nokia_proto);
> +}
