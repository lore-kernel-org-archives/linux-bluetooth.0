Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 11:28:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix segfault in HDP during device re-creation
Message-ID: <20101111092801.GA3919@jh-x301>
References: <1289358915-6612-1-git-send-email-epx@signove.com>
 <1289382461-10510-1-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289382461-10510-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 10, 2010, Jose Antonio Santos Cadenas wrote:
> ---
>  health/hdp.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/health/hdp.c b/health/hdp.c
> index 1eba8e1..d361b27 100644
> --- a/health/hdp.c
> +++ b/health/hdp.c
> @@ -259,6 +259,7 @@ static void device_unref_mcl(struct hdp_device *hdp_device)
>  	if (!hdp_device->mcl)
>  		return;
>  
> +	mcap_close_mcl(hdp_device->mcl, FALSE);
>  	mcap_mcl_unref(hdp_device->mcl);
>  	hdp_device->mcl = NULL;
>  	hdp_device->mcl_conn = FALSE;

Pushed upstream. Thanks.

Johan
