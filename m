Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btmrvl: process interrupt in main thread to
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Amitkumar Karwar <akarwar@marvell.com>
In-Reply-To: <1275003517-18563-1-git-send-email-bzhao@marvell.com>
References: <1275003517-18563-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 18:52:22 -0300
Message-ID: <1278625942.10421.83.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> When driver is sending a command or data and the firmware is also
> sending a sleep event, sometimes it is observed that driver will
> continue to send the command/data to firmware right after processing
> sleep event. Once sleep event is processed driver is not supposed to
> send anything because firmware is in sleep state after that. Previously
> interrupt processing was done in SDIO interrupt callback handler.
> Now it is done in btmrvl driver main thread to solve the
> cross-sending properly.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
>  drivers/bluetooth/btmrvl_drv.h  |    1 +
>  drivers/bluetooth/btmrvl_main.c |    5 ++-
>  drivers/bluetooth/btmrvl_sdio.c |   97 ++++++++++++++++++++-------------------
>  3 files changed, 55 insertions(+), 48 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


