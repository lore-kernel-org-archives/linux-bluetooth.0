Return-Path: <cyrus@holtmann.org>
Message-ID: <1344319961.2083.41.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Use module_platform_driver() in btwilink.c
 file
From: Marcel Holtmann <marcel@holtmann.org>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	johan.hedberg@gmail.com, raja_mani@ti.com, patches@linaro.org
Date: Mon, 06 Aug 2012 23:12:41 -0700
In-Reply-To: <1344316065-2032-1-git-send-email-sachin.kamat@linaro.org>
References: <1344316065-2032-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sachin,

> module_platform_driver() makes the code simpler by eliminating module_init
> and module_exit calls.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> This patch is based on bluetooth-next tree and is compile tested.
> ---
>  drivers/bluetooth/btwilink.c |   16 +---------------
>  1 files changed, 1 insertions(+), 15 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


