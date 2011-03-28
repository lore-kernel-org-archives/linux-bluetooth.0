Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301302992-10671-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
References: <1301302992-10671-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
Date: Mon, 28 Mar 2011 16:40:14 +0200
Message-ID: <AANLkTimhcFNDdq0FCP2rVdDJ5V_YP+E82+80OavsuAS=@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mach-ux500: Add CG2900 devices
From: Vitaly Wool <vitalywool@gmail.com>
To: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, Pavan Savoy <pavan_savoy@sify.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus Walleij <linus.walleij@stericsson.com>, Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 28, 2011 at 11:03 AM, Par-Gunnar Hjalmdahl
<par-gunnar.p.hjalmdahl@stericsson.com> wrote:
>
> +/* Function located in drivers/staging/cg2900 */
> +extern void cg2900_init_board(void);
> +

I'm confused. Where in the drivers/staging is this function? Couldn't
find it in the previous patch.

~Vitaly
