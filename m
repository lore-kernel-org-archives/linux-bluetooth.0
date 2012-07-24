Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 20:01:24 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: ramm@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix for double free of st buffer.
Message-ID: <20120724230124.GL20029@joana>
References: <1342511370-26470-1-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342511370-26470-1-git-send-email-ramm@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ram,

* ramm@ti.com <ramm@ti.com> [2012-07-17 10:49:30 +0300]:

> From: Ram Malovany <ramm@ti.com>
> 
> When the Shared Transport line discipline driver (st_core) get data it
> pushes the skb received to the relevant protocol stacks , it then
> excepts that the relevant protocol stacks should handle the buffer ,
> and if it cannot then the stack should respond with an error.
> In our case the Bluetooth driver for shared transport (btwilink) should
> always be able to handle the buffer , in case of an error it will
> release it , thus we always should return 0.
> 
> Signed-off-by: Ram Malovany <ramm@ti.com>
> ---
>  drivers/bluetooth/btwilink.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
> index 8869469..1f60d84 100644
> --- a/drivers/bluetooth/btwilink.c
> +++ b/drivers/bluetooth/btwilink.c
> @@ -94,18 +94,22 @@ static void st_reg_completion_cb(void *priv_data, char data)
>  }
>  
>  /* Called by Shared Transport layer when receive data is
> - * available */
> + * available
> + * Return:
> + * 0 if buffer handled (affectivly allways even if error found)
> + * if return !=0 the buffer will be freed by the st
> + */
>  static long st_receive(void *priv_data, struct sk_buff *skb)
>  {
>  	struct ti_st *lhst = priv_data;
>  	int err;
>  
>  	if (!skb)
> -		return -EFAULT;
> +		return 0;
>  
>  	if (!lhst) {
>  		kfree_skb(skb);

If you remove this call to kfree_skb() from here doesn't it fixes your
problem?

	Gustavo
