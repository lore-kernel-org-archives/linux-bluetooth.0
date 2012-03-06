Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Mar 2012 01:27:10 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org, Brian Gix <bgix@codeaurora.org>
Subject: Re: [PATCH] Bluetooth: Fix access to the STK generation methods
 matrix
Message-ID: <20120306042710.GC3869@tori.lan>
References: <1330970828-10905-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330970828-10905-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On 20:07 Mon 05 Mar, Ido Yariv wrote:
> The major index of the table is actually the remote I/O capabilities, not
> the local ones. As a result, devices with different I/O capabilities
> could have used wrong or even unsupported generation methods.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>
> CC: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/smp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 75937d7..ebf50065 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -310,7 +310,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
>  			remote_io > SMP_IO_KEYBOARD_DISPLAY)
>  		method = JUST_WORKS;
>  	else
> -		method = gen_method[local_io][remote_io];
> +		method = gen_method[remote_io][local_io];
>  
>  	/* If not bonding, don't ask user to confirm a Zero TK */
>  	if (!(auth & SMP_AUTH_BONDING) && method == JUST_CFM)
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
--
Vinicius
