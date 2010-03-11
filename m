Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Added support for Atheros AR300x Bluetooth Chip
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>,
	Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <4B98ED8F.2020000@atheros.com>
References: <20100209114231.GA6587@ATH-LT-538>
	 <4B98ED8F.2020000@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Mar 2010 09:15:44 -0800
Message-ID: <1268327744.3712.88.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Signed-off-by: Suraj <suraj@atheros.com>
> 
> ---
> drivers/bluetooth/Kconfig | 11 ++
> drivers/bluetooth/Makefile | 1 +
> drivers/bluetooth/hci_ath.c | 353 +++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/hci_ldisc.c | 6 +
> drivers/bluetooth/hci_uart.h | 8 +-
> 5 files changed, 378 insertions(+), 1 deletions(-)
> create mode 100755 drivers/bluetooth/hci_ath.c
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 058fbcc..81abeff 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -58,6 +58,17 @@ config BT_HCIUART_BCSP
> 
> Say Y here to compile support for HCI BCSP protocol.
> 
> +config BT_HCIUART_ATH
> + bool "Atheros AR300x Board support"
> + depends on BT_HCIUART
> + help
> + HCIATH (HCI Atheros) is a serial protocol for communication
> + between Bluetooth device and host with support for Atheros AR300x
> + power management feature. This protocol is required for
> + serial Bluetooth devices that are based on Atheros AR300x chips.
> +
> + Say Y here to compile support for Atheros AR300x Chips.

your patch is messed up. Make sure your mailer doesn't mess with tabs
and whitespaces.

Regards

Marcel


