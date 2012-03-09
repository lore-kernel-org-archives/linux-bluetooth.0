Return-Path: <cyrus@holtmann.org>
Message-ID: <1331312993.14217.15.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Convert error codes to le16
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 09 Mar 2012 09:09:53 -0800
In-Reply-To: <1331302037-29095-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331302037-29095-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Create Chan Rsp shall put result and status in le format.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 428e0b0..cf0b166 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3300,8 +3300,8 @@ static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
>  	/* Placeholder: Always reject */
>  	rsp.dcid = 0;
>  	rsp.scid = cpu_to_le16(scid);
> -	rsp.result = L2CAP_CR_NO_MEM;
> -	rsp.status = L2CAP_CS_NO_INFO;
> +	rsp.result = cpu_to_le16(L2CAP_CR_NO_MEM);
> +	rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);

you can use the __constant version of the macro here.

Regards

Marcel


