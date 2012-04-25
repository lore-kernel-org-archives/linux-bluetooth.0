Return-Path: <cyrus@holtmann.org>
Message-ID: <1335336081.16897.407.camel@aeonflux>
Subject: Re: [PATCH RESEND 1/2] Bluetooth: btmrvl: configure default host
 sleep parameters
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Date: Wed, 25 Apr 2012 08:41:21 +0200
In-Reply-To: <1335310301-11600-1-git-send-email-bzhao@marvell.com>
References: <1335310301-11600-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> Currently debugfs commands "hscfgcmd" and "gpiogap" are provided
> for host sleep configuration. But if user doesn't configure host
> sleep parameters using these commands, host sleep activation is
> failed during suspend (support for suspend and resume handlers is
> added in next patch).
> 
> Default host sleep configuration is done during driver initialisation
> in this patch.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> ---
> Last 2 patches were sent to Gustavo's old e-mail address.
> Resending...
> 
>  drivers/bluetooth/btmrvl_drv.h  |    1 +
>  drivers/bluetooth/btmrvl_main.c |   53 ++++++++++++++++++++++----------------
>  drivers/bluetooth/btmrvl_sdio.c |    3 ++
>  3 files changed, 35 insertions(+), 22 deletions(-)

Regards

Marcel


