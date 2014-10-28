Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v3 0/3] Avoiding lockdep warnings in 6lowpan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414509409-11970-1-git-send-email-jukka.rissanen@linux.intel.com>
Date: Tue, 28 Oct 2014 09:06:15 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B6A26971-A82F-4840-96A7-9D70A7762B2C@holtmann.org>
References: <1414509409-11970-1-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> v3:
> - typo in patch 2 commit message (s/ieee802162/ieee802154/)
> 
> 
> v2:
> - rebased on top of latest upstream
> - fixed indentation error in patch 1
> 
> 
> v1:
> patch 1 changes all rwlocks to RCU as suggested by Peter Hurley.
> This should help the performance.
> 
> The patch 2 is ported from ieee802154 as suggested by Alex Aring.
> This will help avoid lockdep warnings in certain transmit scenarios.
> 
> The patch 3 changes normal spin locks to spin_lock_bh() variant when
> queueing outgoing packets in hci_queue_acl(). This is needed as packets
> coming from 6lowpan link are sent from softirq. Thanks again to
> Peter Hurley pointing this out.
> 
> 
> Cheers,
> Jukka
> 
> 
> Jukka Rissanen (3):
>  Bluetooth: 6lowpan: Converting rwlocks to use RCU
>  Bluetooth: 6lowpan: Fix lockdep splats
>  Bluetooth: Wrong style spin lock used
> 
> net/bluetooth/6lowpan.c  | 241 ++++++++++++++++++++++++++++-------------------
> net/bluetooth/hci_core.c |   4 +-
> 2 files changed, 148 insertions(+), 97 deletions(-)

the first 2 patches have been applied to bluetooth-next tree. The 3rd patch needs to be updated with a proper comment.

Regards

Marcel

