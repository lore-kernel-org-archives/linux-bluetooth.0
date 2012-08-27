Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Aug 2012 08:24:09 -0700
From: Gustavo Padovan <gustavo@padovan.org>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com, raja_mani@ti.com, patches@linaro.org
Subject: Re: [PATCH] Bluetooth: Use module_platform_driver() in btwilink.c
 file
Message-ID: <20120827152409.GC8934@joana>
References: <1344316065-2032-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344316065-2032-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sachin,

* Sachin Kamat <sachin.kamat@linaro.org> [2012-08-07 10:37:45 +0530]:

> module_platform_driver() makes the code simpler by eliminating module_init
> and module_exit calls.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> This patch is based on bluetooth-next tree and is compile tested.
> ---
>  drivers/bluetooth/btwilink.c |   16 +---------------
>  1 files changed, 1 insertions(+), 15 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
