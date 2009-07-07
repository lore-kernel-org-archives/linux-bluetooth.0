Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix build with ./configure-bootstrap
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20090707091325.38dec13a@stoetzler>
References: <20090707091325.38dec13a@stoetzler>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Jul 2009 10:21:52 -0700
Message-Id: <1246987312.3384.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> hciops.c: In function ‘hciops_exit’:
> hciops.c:728: error: call to function ‘btd_adapter_cleanup_ops’
>               without a real prototype
> ---
>  plugins/hciops.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/plugins/hciops.c b/plugins/hciops.c
> index 659f754..6baed76 100644
> --- a/plugins/hciops.c
> +++ b/plugins/hciops.c
> @@ -725,7 +725,7 @@ static int hciops_init(void)
>  }
>  static void hciops_exit(void)
>  {
> -	btd_adapter_cleanup_ops(&hci_ops);
> +	btd_adapter_cleanup_ops();
>  }
>  
>  BLUETOOTH_PLUGIN_DEFINE(hciops, VERSION,

the subject is not matching the patch and I have no idea what is going
on here. I leave this to Johan or Alok to look at.

Regards

Marcel


