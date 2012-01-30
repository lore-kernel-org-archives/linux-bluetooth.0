Return-Path: <cyrus@holtmann.org>
Message-ID: <1327960875.1955.183.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: btusb: Remove device lock on release
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Date: Mon, 30 Jan 2012 14:01:15 -0800
In-Reply-To: <1327682242-2988-1-git-send-email-dh.herrmann@googlemail.com>
References: <1327682242-2988-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> Recently we changed the way how we release driver-data. A driver is now
> responsible of destroying the data so we no longer need the device lock
> on deinitialization in btusb driver.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/btusb.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


