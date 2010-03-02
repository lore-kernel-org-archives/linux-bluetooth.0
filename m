Return-Path: <cyrus@holtmann.org>
Subject: Re: linux-next: Tree for March 1 (bluetooth/hci_sysfs)
From: Marcel Holtmann <marcel@holtmann.org>
To: David Miller <davem@davemloft.net>
Cc: sfr@canb.auug.org.au, randy.dunlap@oracle.com,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20100301.181415.266447389.davem@davemloft.net>
References: <20100301210210.c6f465e6.sfr@canb.auug.org.au>
	 <4B8C2CC5.8000603@oracle.com>
	 <20100302121526.36a1ea88.sfr@canb.auug.org.au>
	 <20100301.181415.266447389.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Mar 2010 23:06:18 -0800
Message-ID: <1267513578.2710.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

> >> static ssize_t inquiry_cache_read(struct file *file, char __user *userbuf,
> >> 						size_t count, loff_t *ppos)
> >> {
> >> 	struct hci_dev *hdev = file->private_data;
> >> 	struct inquiry_cache *cache = &hdev->inq_cache;
> >> 	struct inquiry_entry *e;
> >> 	char buf[4096]; // <<<<<<<<<<<<<<<<<<<<<<<<<<< huh? don't do that on stack.
> >> 	int n = 0;
> > 
> > Dave Miller is following up on that.
> 
> This looks like a job for.... SEQ FILE! :-)
> 
> I'm testing the following fix.

the patch looks good, but it doesn't do the job. I have to look into why
that is. Will try to come up with a proper patch soon.

Regards

Marcel


