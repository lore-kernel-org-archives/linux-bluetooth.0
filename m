Return-Path: <cyrus@holtmann.org>
Message-ID: <4B8C2CC5.8000603@oracle.com>
Date: Mon, 01 Mar 2010 13:08:21 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>
Subject: Re: linux-next: Tree for March 1 (bluetooth/hci_sysfs)
References: <20100301210210.c6f465e6.sfr@canb.auug.org.au>
In-Reply-To: <20100301210210.c6f465e6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/01/10 02:02, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20100226:
> 
> We are seeing conflicts migrate from being between 2 trees in linux-next
> to be between a tree and Linus' tree as things start to get merged.
> 
> 
> The net tree gained a conflict against Linus' tree.

static ssize_t inquiry_cache_read(struct file *file, char __user *userbuf,
						size_t count, loff_t *ppos)
{
	struct hci_dev *hdev = file->private_data;
	struct inquiry_cache *cache = &hdev->inq_cache;
	struct inquiry_entry *e;
	char buf[4096]; // <<<<<<<<<<<<<<<<<<<<<<<<<<< huh? don't do that on stack.
	int n = 0;


-- 
~Randy
