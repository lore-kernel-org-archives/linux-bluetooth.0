Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH bluetooth-next] bluetooth: 6lowpan: fix skb_unshare behaviour
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412756693-19410-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 8 Nov 2014 11:03:28 -0800
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
Message-Id: <094FC9D5-F770-45B5-9BFC-B936CB6F1C69@holtmann.org>
References: <1412756693-19410-1-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> This patch reverts commit:
> 
> a7807d73 ("Bluetooth: 6lowpan: Avoid memory leak if memory allocation
> fails")
> 
> which was wrong suggested by Alexander Aring. The function skb_unshare
> run also kfree_skb on failure.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> compile tested only.
> 
> net/bluetooth/6lowpan.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

