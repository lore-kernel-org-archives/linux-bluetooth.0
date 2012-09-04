Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Sep 2012 19:21:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: szymon.janc@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Subject: re: Bluetooth: Use GFP_KERNEL in read_index_list
Message-ID: <20120904162137.GA11841@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Szymon Janc,

The patch 7cfeb868eb85: "Bluetooth: Use GFP_KERNEL in
read_index_list" from Aug 31, 2012, leads to the following warning:
net/bluetooth/mgmt.c:343 read_index_list()
	 error: scheduling with locks held:  'read_lock:hci_dev_list_lock'

This patch should be reverted because we're not allowed to schedule
while holding the read lock.  The way to avoid these bugs in the future
is to test with CONFIG_DEBUG_ATOMIC_SLEEP=y.  It will give a big splat.

regards,
dan carpenter

