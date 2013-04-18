Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Apr 2013 19:31:32 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, andrei.emeltchenko@intel.com,
	akarwar@marvell.com, bzhao@marvell.com
Subject: Re: [PATCH 2/2] Bluetooth: btmrvl: report error if
 verify_fw_download times out.
Message-ID: <20130418223132.GC15279@joana>
References: <1366301890-14100-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1366301890-14100-3-git-send-email-andreas.fenkart@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366301890-14100-3-git-send-email-andreas.fenkart@streamunlimited.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andreas,

* Andreas Fenkart <andreas.fenkart@streamunlimited.com> [2013-04-18 18:18:09 +0200]:

> Fw does the synchronization of the different modules during init.
> It will report different modules, that it is ready at different times.
> The download 'winner' will be reported 'fw ready' first. Without this
> patch, btmrvl is continuing before the fw tells it to. Probably on behalf
> of the 'winner' which then never sees the fw as ready and times out.
> 
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 6b6abb2..2ec0841 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -245,6 +245,7 @@ static int btmrvl_sdio_verify_fw_download(struct btmrvl_sdio_card *card,
>  			break;
>  		} else {
>  			msleep(10);
> +			ret = -1;

Can we have a proper error code here?

	Gustavo
