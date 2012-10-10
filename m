Return-Path: <cyrus@holtmann.org>
Message-ID: <1349891054.27233.151.camel@aeonflux>
Subject: Re: [PATCH v3 05/10] adapter: Move pairable read to load_config()
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 19:44:14 +0200
In-Reply-To: <1349878219-14359-6-git-send-email-frederic.danis@linux.intel.com>
References: <1349878219-14359-1-git-send-email-frederic.danis@linux.intel.com>
	 <1349878219-14359-6-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>  src/adapter.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 93dc0fb..357b717 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2697,6 +2697,10 @@ static void load_config(struct btd_adapter *adapter)
>  		uint32_t class = htobl(main_opts.class);
>  		memcpy(adapter->config.class, &class, 3);
>  	}
> +
> +	/* Get pairable mode */
> +	if (read_device_pairable(&adapter->bdaddr, &adapter->pairable) < 0)
> +		adapter->pairable = TRUE;

maybe you change this later altogether, but the multiple reads here are
bad.

Regards

Marcel


