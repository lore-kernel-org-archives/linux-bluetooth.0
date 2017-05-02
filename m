Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: add a check for kmalloc() failure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170502092903.u7no6pizkakf454o@mwanda>
Date: Tue, 2 May 2017 19:58:11 +0200
Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-Id: <26554315-C6A5-4B85-B535-E6EB91499A61@holtmann.org>
References: <20170502092903.u7no6pizkakf454o@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> We should check to see if this kmalloc() fails.
> 
> Fixes: e7c404c96c74 ("Bluetooth: allocate data for kpp on heap")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
> index 80184476ff74..c8535845813d 100644
> --- a/net/bluetooth/ecdh_helper.c
> +++ b/net/bluetooth/ecdh_helper.c
> @@ -59,11 +59,15 @@ bool compute_ecdh_secret(const u8 public_key[64], const u8 private_key[32],
> 	struct ecdh p;
> 	struct ecdh_completion result;
> 	struct scatterlist src, dst;
> -	u8 *tmp = kmalloc(64, GFP_KERNEL);
> +	u8 *tmp;
> 	u8 *buf;
> 	unsigned int buf_len;
> 	int err = -ENOMEM;
> 
> +	tmp = kmalloc(64, GFP_KERNEL);
> +	if (!tmp)
> +		goto out;
> +

I thought that I already fixed this. Is this issue still present in bluetooth-next tree?

Regards

Marcel

