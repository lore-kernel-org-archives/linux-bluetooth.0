Return-Path: <cyrus@holtmann.org>
Message-ID: <1337771107.15105.74.camel@aeonflux>
Subject: Re: [PATCH trivial 2/4] Bluetooth: Define L2CAP conf continuation
 flag
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 23 May 2012 13:05:07 +0200
In-Reply-To: <1337761883-3190-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337761883-3190-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1337761883-3190-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Define Continuation flag which the only flag used from Flags field
> in L2CAP Configuration Request and Response.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 +++
>  net/bluetooth/l2cap_core.c    |   10 +++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 7bc4019..8980cbf 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -271,6 +271,9 @@ struct l2cap_conf_rsp {
>  #define L2CAP_CONF_PENDING	0x0004
>  #define L2CAP_CONF_EFS_REJECT	0x0005
>  
> +/* configuration req/rsp continuation flag */
> +#define L2CAP_CONF_FLAG_CONTINUATION	0
> +
>  struct l2cap_conf_opt {
>  	__u8       type;
>  	__u8       len;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b644f40..75a8b66 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2963,7 +2963,7 @@ done:
>  	}
>  
>  	req->dcid  = cpu_to_le16(chan->dcid);
> -	req->flags = cpu_to_le16(0);
> +	req->flags = __constant_cpu_to_le16(0);
>  
>  	return ptr - data;
>  }
> @@ -3183,7 +3183,7 @@ done:
>  	}
>  	rsp->scid   = cpu_to_le16(chan->dcid);
>  	rsp->result = cpu_to_le16(result);
> -	rsp->flags  = cpu_to_le16(0x0000);
> +	rsp->flags  = __constant_cpu_to_le16(0);
>  
>  	return ptr - data;
>  }
> @@ -3282,7 +3282,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
>  	}
>  
>  	req->dcid   = cpu_to_le16(chan->dcid);
> -	req->flags  = cpu_to_le16(0x0000);
> +	req->flags  = __constant_cpu_to_le16(0);
>  
>  	return ptr - data;
>  }
> @@ -3637,7 +3637,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>  	memcpy(chan->conf_req + chan->conf_len, req->data, len);
>  	chan->conf_len += len;
>  
> -	if (flags & 0x0001) {
> +	if (flags & BIT(L2CAP_CONF_FLAG_CONTINUATION)) {

do we really wanna do the BIT() over just defining it as 0x01.
Especially since there is only one flag right now. And the BIT() only
makes real sense if we use an enum.

Regards

Marcel


