Return-Path: <cyrus@holtmann.org>
Message-ID: <1331313058.14217.16.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: trivial: Fix endian conversion mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 09 Mar 2012 09:10:58 -0800
In-Reply-To: <1331302710-29225-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331302710-29225-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> In L2CAP we use le16 format so change direction of conversion
> from le16_to_cpu to cpu_to_le16.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index cf0b166..eb72f5a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2413,9 +2413,9 @@ done:
>  			chan->remote_mps = size;
>  
>  			rfc.retrans_timeout =
> -				le16_to_cpu(L2CAP_DEFAULT_RETRANS_TO);
> +				cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
>  			rfc.monitor_timeout =
> -				le16_to_cpu(L2CAP_DEFAULT_MONITOR_TO);
> +				cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);

and here we should also use the __constant version.

Regards

Marcel


