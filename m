Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3] Bluetooth: Add new PID for Atheros 3011
From: Marcel Holtmann <marcel@holtmann.org>
To: Bala Shanmugam <sbalashanmugam@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1290773146-4705-1-git-send-email-sbalashanmugam@atheros.com>
References: <1290773146-4705-1-git-send-email-sbalashanmugam@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Dec 2010 11:44:44 +0100
Message-ID: <1291200284.4795.92.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

> Atheros 3011 has small sflash firmware and needs to be
> blacklisted in transport driver to load actual firmware
> in DFU driver.
> 
> Signed-off-by: Bala Shanmugam <sbalashanmugam@atheros.com>
> ---
>  drivers/bluetooth/ath3k.c |    4 ++++
>  drivers/bluetooth/btusb.c |    3 +++
>  2 files changed, 7 insertions(+), 0 deletions(-)

looks good to me now.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


