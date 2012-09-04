Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Sep 2012 15:52:11 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: szymon.janc@tieto.com, linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: Use GFP_KERNEL in read_index_list
Message-ID: <20120904185151.GA2344@joana>
References: <20120904162137.GA11841@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120904162137.GA11841@elgon.mountain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Carpenter <dan.carpenter@oracle.com> [2012-09-04 19:21:37 +0300]:

> Hello Szymon Janc,
> 
> The patch 7cfeb868eb85: "Bluetooth: Use GFP_KERNEL in
> read_index_list" from Aug 31, 2012, leads to the following warning:
> net/bluetooth/mgmt.c:343 read_index_list()
> 	 error: scheduling with locks held:  'read_lock:hci_dev_list_lock'
> 
> This patch should be reverted because we're not allowed to schedule
> while holding the read lock.  The way to avoid these bugs in the future
> is to test with CONFIG_DEBUG_ATOMIC_SLEEP=y.  It will give a big splat.

I reverted this patch earlier this morning. It should be ok now.

	Gustavo
