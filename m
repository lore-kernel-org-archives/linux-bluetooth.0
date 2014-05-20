Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 0/6] Bluetooth: SMP cleanups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 20 May 2014 08:50:17 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C57C26F5-3933-40C9-9B85-FB96A97625D5@holtmann.org>
References: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a set of cleanups for the SMP code.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (6):
>      Bluetooth: Make SMP context private to smp.c
>      Bluetooth: Fix setting initial local auth_req value
>      Bluetooth: Remove unnecessary work structs from SMP code
>      Bluetooth: Rename smp->smp_flags to smp->flags
>      Bluetooth: Update smp_random to return a response code
>      Bluetooth: Update smp_confirm to return a response code
> 
> net/bluetooth/hci_conn.c |   1 +
> net/bluetooth/hci_core.c |   1 +
> net/bluetooth/mgmt.c     |   1 +
> net/bluetooth/smp.c      | 133 ++++++++++++++++++++-------------------
> net/bluetooth/smp.h      |  29 ---------
> 5 files changed, 70 insertions(+), 95 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

