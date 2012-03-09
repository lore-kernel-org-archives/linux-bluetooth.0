Return-Path: <cyrus@holtmann.org>
Message-ID: <1331313201.14217.18.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: mgmt: Add missing endian conversion
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 09 Mar 2012 09:13:21 -0800
In-Reply-To: <1331305549-3066-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331305549-3066-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Add missing endian conversion for page scan interval and window.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/mgmt.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 97b5b6c..06d2eaf 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2523,13 +2523,18 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
>  
>  	if (cp->val) {
>  		type = PAGE_SCAN_TYPE_INTERLACED;
> -		acp.interval = 0x0024;	/* 22.5 msec page scan interval */
> +
> +		/* 22.5 msec page scan interval */
> +		acp.interval = cpu_to_le16(0x0024);
>  	} else {
>  		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
> -		acp.interval = 0x0800;	/* default 1.28 sec page scan */
> +
> +		/* default 1.28 sec page scan */
> +		acp.interval = cpu_to_le16(0x0800);
>  	}
>  
> -	acp.window = 0x0012;	/* default 11.25 msec page scan window */
> +	/* default 11.25 msec page scan window */
> +	acp.window = cpu_to_le16(0x0012);

please use __constant_cpu_to_le16.

Regards

Marcel


