Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Sep 2011 14:58:40 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Add functions to initialize the SMP
 workqueue
Message-ID: <20110902175840.GD12684@joana>
References: <1313798415-8555-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798415-8555-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798415-8555-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-19 21:00:13 -0300]:

> SMP crypto function crypto_blkcypher_setkey() may sleep, so we need
> to move that part of the SMP procedure inside a workqueue.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/smp.h |    3 +++
>  net/bluetooth/smp.c         |   24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
> index 46c4576..884ed41 100644
> --- a/include/net/bluetooth/smp.h
> +++ b/include/net/bluetooth/smp.h
> @@ -120,4 +120,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
>  int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
>  int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
>  
> +int smp_crypto_init(void);
> +void smp_crypto_exit(void);
> +
>  #endif /* __SMP_H */
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index f911930..9edd317 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -20,6 +20,7 @@
>     SOFTWARE IS DISCLAIMED.
>  */
>  
> +#include <linux/errno.h>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/l2cap.h>
> @@ -30,6 +31,8 @@
>  
>  #define SMP_TIMEOUT 30000 /* 30 seconds */
>  
> +static struct workqueue_struct *crypto_wq;
> +

Let's use hdev->workqueue instead of creating a new one.

	Gustavo
