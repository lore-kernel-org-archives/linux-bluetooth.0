Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v2 0/3] Bluetooth: Bluetooth: LE CoC fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415868919-12040-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 15 Nov 2014 09:51:37 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A60E8E0A-F61C-44F4-AA21-F3D8F51D820C@holtmann.org>
References: <1415868919-12040-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's v2 of this patch set, now without the l2cap_chan locking hack
> thanks to the nesting level patches that were already applied.
> 
> From the original cover letter:
> 
> This patch set contains various fixes for LE CoC. The biggest functional
> change is in the last patch proper reaction to the insufficient
> authentication/encryption connection responses is implemented.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Fix sending incorrect LE CoC PDU in BT_CONNECT2 state
>      Bluetooth: Add key preference parameter to smp_sufficient_security
>      Bluetooth: Trigger SMP for the appropriate LE CoC errors
> 
> net/bluetooth/l2cap_core.c | 29 ++++++++++++++++++++++++++---
> net/bluetooth/smp.c        | 20 +++++++++++---------
> net/bluetooth/smp.h        |  9 ++++++++-
> 3 files changed, 45 insertions(+), 13 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

