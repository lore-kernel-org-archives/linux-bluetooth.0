Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Aug 2015 18:19:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Gustavo Padovan
 <gustavo@padovan.org>, Frederic Danis <frederic.danis@linux.intel.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH] Bluetooth: hci_bcm: improve use of gpios API
Message-ID: <20150812181905.78ade990@canb.auug.org.au>
In-Reply-To: <1439364056-8564-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150812165949.0d66f2be@canb.auug.org.au>
	<1439364056-8564-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Uwe,

On Wed, 12 Aug 2015 09:20:56 +0200 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@p=
engutronix.de> wrote:
>
> devm_gpiod_get currently has an optional parameter to set initial
> direction and value for the requested gpio. Make use of this to simplify
> the driver and make it not fail to build when this parameter is made
> mandatory (which is scheduled for 4.3-rc1).
>=20
> Moreover use the _optional variant of devm_gpiod_get to simplify error
> handling (which also gets more strict for free).
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> this is needed on top of commit 0395ffc1ee05 ("Bluetooth: hci_bcm: Add
> PM for BCM devices") incombination with b17d1bf16cc7 ("gpio: make flags
> mandatory for gpiod_get functions") which is currently sitting in next.
>=20
> Stephen fixed it up with a simpler patch, which works fine, but doesn't
> benefit from the nice things devm_gpiod_get et al offer.
>=20
> Best regards
> Uwe
>=20
>  drivers/bluetooth/hci_bcm.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)

I will use this instead of my simple patch tomorrow if the bluetooth
maintainer has not applied it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
