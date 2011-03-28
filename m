Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Par-Gunnar Hjalmdahl" <par-gunnar.p.hjalmdahl@stericsson.com>
Subject: Re: [PATCH v2 2/2] mach-ux500: Add CG2900 devices
Date: Mon, 28 Mar 2011 15:00:38 +0200
Cc: "Greg Kroah-Hartman" <gregkh@suse.de>, devel@driverdev.osuosl.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	"Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1301302992-10671-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
In-Reply-To: <1301302992-10671-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201103281500.38954.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 28 March 2011, Par-Gunnar Hjalmdahl wrote:
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index d8e5a52..16b7343 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -417,6 +417,8 @@ static void __init mop500_init_machine(void)
>  
>         platform_device_register(&ab8500_device);
>  
> +       cg2900_init_board();
> +
>         i2c_register_board_info(0, mop500_i2c0_devices,
>                                 ARRAY_SIZE(mop500_i2c0_devices));
>         i2c_register_board_info(2, mop500_i2c2_devices,

Not exactly what I had in mind, but probably good enough for a start.
This adds a dependency from core code to the staging driver now,
which shouldn't be there. I suppose we can add

"Clean up device registration path to register the main device from board code"
 
to the TODO file.

	Arnd
