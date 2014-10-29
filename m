Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v4] Bluetooth: Wrong style spin lock used
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414570560-29904-1-git-send-email-jukka.rissanen@linux.intel.com>
Date: Wed, 29 Oct 2014 08:23:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6A8DB35A-D68A-4036-93EA-C55CCBD652C8@holtmann.org>
References: <1414570560-29904-1-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Use spin_lock_bh() as the code is called from softirq in networking subsystem.
> This is needed to prevent deadlocks when 6lowpan link is in use.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> Hi,
> 
> this v4 adds a comment why spin_lock_bh() is needed here.
> 
> Cheers,
> Jukka
> 
> net/bluetooth/hci_core.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

