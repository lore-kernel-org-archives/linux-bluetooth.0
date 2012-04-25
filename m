Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Apr 2012 15:50:12 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: Re: [PATCH RESEND 1/2] Bluetooth: btmrvl: configure default host
 sleep parameters
Message-ID: <20120425185012.GA2781@joana>
References: <1335310301-11600-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335310301-11600-1-git-send-email-bzhao@marvell.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

* Bing Zhao <bzhao@marvell.com> [2012-04-24 16:31:40 -0700]:

> From: Amitkumar Karwar <akarwar@marvell.com>
> 
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
> ---
> Last 2 patches were sent to Gustavo's old e-mail address.
> Resending...
> 
>  drivers/bluetooth/btmrvl_drv.h  |    1 +
>  drivers/bluetooth/btmrvl_main.c |   53 ++++++++++++++++++++++----------------
>  drivers/bluetooth/btmrvl_sdio.c |    3 ++
>  3 files changed, 35 insertions(+), 22 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
