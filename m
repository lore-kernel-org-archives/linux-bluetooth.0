Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 8 Sep 2010 13:58:44 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, haijun.liu@atheros.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth:  Add socket option definitions for AMP
Message-ID: <20100908165844.GH16973@vigoh>
References: <1283964374-16885-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283964374-16885-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-09-08 09:46:14 -0700]:

> This adds a new BT_AMP socket option to control the use of AMP channels.
> It is for use with the SOL_BLUETOOTH option level on L2CAP sockets.
> 
> Available option values are defined as:
> 
> BT_AMP_REQUIRE_BR_EDR
>  * Default
>  * AMP controllers cannot be used
>  * Channel move requests from the remote device are denied
>  * If the L2CAP channel is currently using AMP, move the channel to
>    BR/EDR
> 
> BT_AMP_PREFER_AMP
>  * Allow use of AMP controllers
>  * If the L2CAP channel is currently on BR/EDR and AMP controller
>    resources are available, initiate a channel move to AMP
>  * Channel move requests from the remote device are allowed
>  * If the L2CAP socket has not been connected yet, try to create
>    and configure the channel directly on an AMP controller rather
>    than BR/EDR
> 
> BT_AMP_PREFER_BR_EDR
>  * Allow use of AMP controllers
>  * If the L2CAP channel is currently on AMP, move it to BR/EDR
>  * Channel move requests from the remote device are allowed
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/bluetooth.h |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 27a902d..5e8b6c3 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -64,6 +64,31 @@ struct bt_security {
>  
>  #define BT_DEFER_SETUP	7
>  
> +
> +#define BT_AMP_POLICY		8

Please add a empty line here.

> +/* Require BR/EDR (default policy)
> + *   AMP controllers cannot be used
> + *   Channel move requests from the remote device are denied
> + *   If the L2CAP channel is currently using AMP, move the channel to BR/EDR
> + */
> +#define BT_AMP_POLICY_REQUIRE_BR_EDR	0

And here.

> +/* Prefer AMP
> + *   Allow use of AMP controllers
> + *   If the L2CAP channel is currently on BR/EDR and AMP controller
> + *     resources are available, initiate a channel move to AMP
> + *   Channel move requests from the remote device are allowed
> + *   If the L2CAP socket has not been connected yet, try to create
> + *     and configure the channel directly on an AMP controller rather
> + *     than BR/EDR
> + */
> +#define BT_AMP_POLICY_PREFER_AMP	1

And here.

> +/* Prefer BR/EDR
> + *   Allow use of AMP controllers
> + *   If the L2CAP channel is currently on AMP, move it to BR/EDR
> + *   Channel move requests from the remote device are allowed
> + */
> +#define BT_AMP_POLICY_PREFER_BR_EDR	2
> +
>  #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , ## arg)
>  #define BT_ERR(fmt, arg...)  printk(KERN_ERR "%s: " fmt "\n" , __func__ , ## arg)
>  #define BT_DBG(fmt, arg...)  pr_debug("%s: " fmt "\n" , __func__ , ## arg)
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
roFUSION embedded systems - http://profusion.mobi
