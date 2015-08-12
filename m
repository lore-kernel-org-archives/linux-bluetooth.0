Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: improve use of gpios API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1439364056-8564-1-git-send-email-u.kleine-koenig@pengutronix.de>
Date: Wed, 12 Aug 2015 07:39:31 -0700
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	linux-next@vger.kernel.org,
	inux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org, kernel@pengutronix.de
Message-Id: <342A6333-EC23-4743-8BD2-FC220A2F8B82@holtmann.org>
References: <20150812165949.0d66f2be@canb.auug.org.au> <1439364056-8564-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Uwe,

> devm_gpiod_get currently has an optional parameter to set initial
> direction and value for the requested gpio. Make use of this to simplify
> the driver and make it not fail to build when this parameter is made
> mandatory (which is scheduled for 4.3-rc1).
> 
> Moreover use the _optional variant of devm_gpiod_get to simplify error
> handling (which also gets more strict for free).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this is needed on top of commit 0395ffc1ee05 ("Bluetooth: hci_bcm: Add
> PM for BCM devices") incombination with b17d1bf16cc7 ("gpio: make flags
> mandatory for gpiod_get functions") which is currently sitting in next.
> 
> Stephen fixed it up with a simpler patch, which works fine, but doesn't
> benefit from the nice things devm_gpiod_get et al offer.

patch has been applied to bluetooth-next tree.

Regards

Marcel

