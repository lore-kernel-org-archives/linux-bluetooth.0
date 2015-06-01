Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Jun 2015 13:11:18 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] bnep: Fix using uninitialized variable
Message-ID: <20150601101116.GA31534@comms>
References: <1432893859-32620-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432893859-32620-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Fri, May 29, 2015 at 01:04:19PM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  profiles/network/bnep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 59599e4..9bf0b18 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -634,8 +634,11 @@ static int bnep_server_add_legacy(int sk, uint16_t dst, char *bridge,
>  		bnep_del_from_bridge(iface, bridge);
>  		bnep_conndel(addr);
>  		rsp = BNEP_CONN_NOT_ALLOWED;
> +		goto reply;
>  	}
>  
> +	rsp = BNEP_SUCCESS;
> +
>  reply:
>  	if (bnep_send_ctrl_rsp(sk, BNEP_SETUP_CONN_RSP, rsp) < 0) {
>  		err = -errno;
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
