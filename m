Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-usb@vger.kernel.org
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: don't print error when allocating urb fails
Date: Thu, 11 Aug 2016 22:51:33 +0200
Message-Id: <1470948695-23421-1-git-send-email-wsa@the-dreams.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wolfram Sang <wsa-dev@sang-engineering.com>

This per-subsystem series is part of a tree wide cleanup. usb_alloc_urb() uses
kmalloc which already prints enough information on failure. So, let's simply
remove those "allocation failed" messages from drivers like we did already for
other -ENOMEM cases. gkh acked this approach when we talked about it at LCJ in
Tokyo a few weeks ago.


Wolfram Sang (1):
  bluetooth: bcm203x: don't print error when allocating urb fails

 drivers/bluetooth/bcm203x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.8.1

