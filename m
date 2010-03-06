Return-Path: <cyrus@holtmann.org>
Date: Sat, 6 Mar 2010 18:30:30 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jan Ceuleers <jan.ceuleers@computer.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Young <hidave.darkstar@gmail.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Roger Quadros <ext-roger.quadros@nokia.com>,
	Bing Zhao <bzhao@marvell.com>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] bluetooth: debugfs changes use too much stack
Message-ID: <20100306153030.GU4958@bicker>
References: <20100306111552.GK4958@bicker> <4B92695F.60601@computer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B92695F.60601@computer.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Mar 06, 2010 at 03:40:31PM +0100, Jan Ceuleers wrote:
> Dan Carpenter wrote:
> 
> Error handling?
> 
> > The original code would break with a 4K stack.
> > 
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> > This was compile tested only.  Sorry about that.
> > 
> > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > index 1a79a6c..835758f 100644
> > --- a/net/bluetooth/hci_sysfs.c
> > +++ b/net/bluetooth/hci_sysfs.c
> > @@ -417,9 +417,11 @@ static ssize_t inquiry_cache_read(struct file *file, char __user *userbuf,
> >  	struct hci_dev *hdev = file->private_data;
> >  	struct inquiry_cache *cache = &hdev->inq_cache;
> >  	struct inquiry_entry *e;
> > -	char buf[4096];
> > +	char *buf;
> >  	int n = 0;
> > +	ssize_t ret;
> >  
> > +	buf = kmalloc(4096, GFP_KERNEL);
> 
> Could this kmalloc not fail?

Grr...  I'm really sorry about that.

I will send an updated patch tomorrow.

regards,
dan carpenter
