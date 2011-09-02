Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Sep 2011 15:01:12 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Move SMP fields to a separate structure
Message-ID: <20110902180112.GE12684@joana>
References: <1313798415-8555-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798415-8555-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-19 21:00:12 -0300]:

> The objective is to make the core to have as little as possible
> information about SMP procedures and logic. Now, all the SMP
> specific information is hidden from the core.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 -
>  include/net/bluetooth/l2cap.h    |   10 +--
>  net/bluetooth/hci_core.c         |    8 ---
>  net/bluetooth/smp.c              |  118 ++++++++++++++++++++-----------------
>  4 files changed, 67 insertions(+), 71 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 6e68e43..cc1ea91 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -195,8 +195,6 @@ struct hci_dev {
>  
>  	__u16			init_last_cmd;
>  
> -	struct crypto_blkcipher	*tfm;
> -
>  	struct inquiry_cache	inq_cache;
>  	struct hci_conn_hash	conn_hash;
>  	struct list_head	blacklist;
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 6fa1140..00e42aa 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -386,6 +386,8 @@ struct l2cap_ops {
>  	void			(*state_change) (void *data, int state);
>  };
>  
> +struct smp_chan;

Just define this on smp.h, it's easy.

	Gustavo
