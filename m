Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1289382461-10510-1-git-send-email-santoscadenas@gmail.com>
References: <1289358915-6612-1-git-send-email-epx@signove.com> <1289382461-10510-1-git-send-email-santoscadenas@gmail.com>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Wed, 10 Nov 2010 10:49:11 +0100
Message-ID: <AANLkTimoQRAHXJ65xa1-TMKGUfLujw8f9MhzxrxPXHmY@mail.gmail.com>
Subject: Re: [PATCH] Fix segfault in HDP during device re-creation
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/11/10 Jose Antonio Santos Cadenas <santoscadenas@gmail.com>:
> ---
>  health/hdp.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/health/hdp.c b/health/hdp.c
> index 1eba8e1..d361b27 100644
> --- a/health/hdp.c
> +++ b/health/hdp.c
> @@ -259,6 +259,7 @@ static void device_unref_mcl(struct hdp_device *hdp_device)
>        if (!hdp_device->mcl)
>                return;
>
> +       mcap_close_mcl(hdp_device->mcl, FALSE);
>        mcap_mcl_unref(hdp_device->mcl);
>        hdp_device->mcl = NULL;
>        hdp_device->mcl_conn = FALSE;
> --
> 1.7.1
>
>

Please Elvis, try this solution and tell us if it fix the segfault problem.

Regards
