Return-Path: <cyrus@holtmann.org>
Message-ID: <1332258576.1870.13.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Silence sparse warning
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Mar 2012 08:49:36 -0700
In-Reply-To: <1332232345-30828-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332232345-30828-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Silence sparse warning shown below:
> ...
> net/bluetooth/mgmt.c:448:15: warning: cast to restricted __le32
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/mgmt.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b8f9016..d93f2bf 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -443,9 +443,7 @@ static u16 get_uuid16(u8 *uuid128)
>  			return 0;
>  	}
>  
> -	memcpy(&val, &uuid128[12], 4);
> -
> -	val = le32_to_cpu(val);
> +	val = get_unaligned_le32(&uuid128[12]);

I actually prefer get_unaligned_le32(uuid128 + 12) in these cases.

Regards

Marcel


