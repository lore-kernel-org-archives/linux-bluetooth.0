Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Support for Atheros AR300x serial
 Bluetooth Chip
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1279523047-4638-1-git-send-email-suraj@atheros.com>
References: <1279523047-4638-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Jul 2010 09:44:06 -0700
Message-ID: <1279557846.4572.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Implements Atheros AR300x Serial HCI protocol.
> This protocol extends H4 serial protocol to implement enhanced power management
> features supported by Atheros AR300x serial Bluetooth chipsets.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  drivers/bluetooth/Kconfig     |   12 ++
>  drivers/bluetooth/Makefile    |    1 +
>  drivers/bluetooth/hci_ath.c   |  235 +++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_ldisc.c |    6 +
>  drivers/bluetooth/hci_uart.h  |    8 ++-
>  5 files changed, 261 insertions(+), 1 deletions(-)
>  create mode 100755 drivers/bluetooth/hci_ath.c

patch has been applied. Thanks.

Regards

Marcel


