Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 11:05:11 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: Initialize the SMP workqueue
Message-ID: <20110822140510.GA15726@piper>
References: <1313798415-8555-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798415-8555-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798415-8555-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 21:00 Fri 19 Aug, Vinicius Costa Gomes wrote:
> The SMP workqueue is initialized along with the L2CAP module if the
> enable_smp parameter is enabled, and destroyed along the L2CAP module.
> 

The commit message is wrong. Please disconsider it, will fix it before
sending a new version.

> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/l2cap_core.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 00e93d1..3082a0e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4293,6 +4293,10 @@ int __init l2cap_init(void)
>  	if (err < 0)
>  		return err;
>  
> +	err = smp_crypto_init();
> +	if (err < 0)
> +		BT_DBG("SMP Initialization falied");
> +
>  	err = hci_register_proto(&l2cap_hci_proto);
>  	if (err < 0) {
>  		BT_ERR("L2CAP protocol registration failed");
> @@ -4310,6 +4314,7 @@ int __init l2cap_init(void)
>  	return 0;
>  
>  error:
> +	smp_crypto_exit();
>  	l2cap_cleanup_sockets();
>  	return err;
>  }
> @@ -4318,6 +4323,8 @@ void l2cap_exit(void)
>  {
>  	debugfs_remove(l2cap_debugfs);
>  
> +	smp_crypto_exit();
> +
>  	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
>  		BT_ERR("L2CAP protocol unregistration failed");
>  
> -- 
> 1.7.6
> 

Cheers,
-- 
Vinicius
