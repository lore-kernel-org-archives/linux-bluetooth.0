Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 2 May 2017 21:34:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: add a check for kmalloc() failure
Message-ID: <20170502183421.7tiazcibqcqfh2w7@mwanda>
References: <20170502092903.u7no6pizkakf454o@mwanda>
 <26554315-C6A5-4B85-B535-E6EB91499A61@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26554315-C6A5-4B85-B535-E6EB91499A61@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, May 02, 2017 at 07:58:11PM +0200, Marcel Holtmann wrote:
> Hi Dan,
> 
> > We should check to see if this kmalloc() fails.
> > 
> > Fixes: e7c404c96c74 ("Bluetooth: allocate data for kpp on heap")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
> > index 80184476ff74..c8535845813d 100644
> > --- a/net/bluetooth/ecdh_helper.c
> > +++ b/net/bluetooth/ecdh_helper.c
> > @@ -59,11 +59,15 @@ bool compute_ecdh_secret(const u8 public_key[64], const u8 private_key[32],
> > 	struct ecdh p;
> > 	struct ecdh_completion result;
> > 	struct scatterlist src, dst;
> > -	u8 *tmp = kmalloc(64, GFP_KERNEL);
> > +	u8 *tmp;
> > 	u8 *buf;
> > 	unsigned int buf_len;
> > 	int err = -ENOMEM;
> > 
> > +	tmp = kmalloc(64, GFP_KERNEL);
> > +	if (!tmp)
> > +		goto out;
> > +
> 
> I thought that I already fixed this. Is this issue still present in bluetooth-next tree?
> 

Ah yeah.  You already fixed this.

regards,
dan carpenter
