Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] bnep: Fix using uninitialized variable
Date: Mon, 01 Jun 2015 13:00:39 +0200
Message-ID: <1547815.JPrmgbYs6B@leonov>
In-Reply-To: <1432893859-32620-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1432893859-32620-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 29 of May 2015 13:04:19 Andrei Emeltchenko wrote:
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
> @@ -634,8 +634,11 @@ static int bnep_server_add_legacy(int sk, uint16_t dst,
> char *bridge, bnep_del_from_bridge(iface, bridge);
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

Patch applied. Thanks.

-- 
BR
Szymon Janc
