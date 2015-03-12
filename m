Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/7] profiles/network: Fix sending error in bnep server add
Date: Thu, 12 Mar 2015 17:12:50 +0100
Message-ID: <203741379.eysbgUrStt@leonov>
In-Reply-To: <1426176402-21179-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1426176402-21179-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1426176402-21179-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 12 of March 2015 17:06:36 Grzegorz Kolodziejczyk wrote:
> If bnep server add will not proceed successfully, approperiate error
> should be returned. Now it returns error if control message send will
> fail.
> ---
>  profiles/network/bnep.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index adddc33..48926b4 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -650,6 +650,7 @@ int bnep_server_add(int sk, char *bridge, char *iface,
> const bdaddr_t *addr, /* Processing BNEP_SETUP_CONNECTION_REQUEST_MSG */
>  	rsp = bnep_setup_decode(sk, req, &dst);
>  	if (rsp != BNEP_SUCCESS) {
> +		err = -rsp;
>  		error("bnep: error while decoding setup connection request: %d",
>  									rsp);
>  		goto reply;
> @@ -673,10 +674,11 @@ int bnep_server_add(int sk, char *bridge, char *iface,
> const bdaddr_t *addr, rsp = BNEP_CONN_NOT_ALLOWED;
> 
>  reply:
> -	err = bnep_send_ctrl_rsp(sk, BNEP_SETUP_CONN_RSP, rsp);
> -	if (err < 0)
> +	if (bnep_send_ctrl_rsp(sk, BNEP_SETUP_CONN_RSP, rsp) < 0) {
>  		error("bnep: send ctrl rsp error: %s (%d)", strerror(errno),
>  									errno);
> +		err = -errno;

errno should be saved before calling error().

> +	}
> 
>  	return err;
>  }

-- 
BR
Szymon Janc
