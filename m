Return-Path: <cyrus@holtmann.org>
Message-ID: <1327959928.1955.172.camel@aeonflux>
Subject: Re: [PATCH v3 6/6] Bluetooth: Fix indentation
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 13:45:28 -0800
In-Reply-To: <1327531949-29463-7-git-send-email-andre.guedes@openbossa.org>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
	 <1327531949-29463-7-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

please fix the commit message to at least mention where.

> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 0a1fa4c..e7033c1 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -44,7 +44,7 @@
>  #define LE_SCAN_INT			0x12
>  #define LE_SCAN_TIMEOUT_LE_ONLY		10240	/* TGAP(gen_disc_scan_min) */
>  
> -#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
> +#define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
>  
>  #define SERVICE_CACHE_TIMEOUT (5 * 1000)
>  

Otherwise this is fine.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


