Return-Path: <cyrus@holtmann.org>
Message-ID: <4B92695F.60601@computer.org>
Date: Sat, 06 Mar 2010 15:40:31 +0100
From: Jan Ceuleers <jan.ceuleers@computer.org>
MIME-Version: 1.0
To: Dan Carpenter <error27@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Young <hidave.darkstar@gmail.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Roger Quadros <ext-roger.quadros@nokia.com>,
        Bing Zhao <bzhao@marvell.com>, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] bluetooth: debugfs changes use too much stack
References: <20100306111552.GK4958@bicker>
In-Reply-To: <20100306111552.GK4958@bicker>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Dan Carpenter wrote:

Error handling?

> The original code would break with a 4K stack.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> This was compile tested only.  Sorry about that.
> 
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 1a79a6c..835758f 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -417,9 +417,11 @@ static ssize_t inquiry_cache_read(struct file *file, char __user *userbuf,
>  	struct hci_dev *hdev = file->private_data;
>  	struct inquiry_cache *cache = &hdev->inq_cache;
>  	struct inquiry_entry *e;
> -	char buf[4096];
> +	char *buf;
>  	int n = 0;
> +	ssize_t ret;
>  
> +	buf = kmalloc(4096, GFP_KERNEL);

Could this kmalloc not fail?
