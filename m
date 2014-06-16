Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 0/6] Bluetooth: Various SMP cleanups & fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402905633-470-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Jun 2014 18:33:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AB754789-4D96-489C-B719-612F19668153@holtmann.org>
References: <1402905633-470-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a set of cleanups and fixes for the SMP code I've come accross
> while working with it.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (6):
>      Bluetooth: Fix missing NULL check for smp_chan_create() return value
>      Bluetooth: Remove unnecessary SMP STK define
>      Bluetooth: Remove HCI prefix from SMP LTK defines
>      Bluetooth: Remove unused LTK authentication defines
>      Bluetooth: Convert SMP flags into an enum
>      Bluetooth: Add flexible buffer byte order swapping function
> 
> include/net/bluetooth/hci.h |  9 ---------
> net/bluetooth/hci_core.c    |  2 +-
> net/bluetooth/hci_event.c   |  3 ++-
> net/bluetooth/mgmt.c        |  6 +++---
> net/bluetooth/smp.c         | 41 +++++++++++++++++++----------------------
> net/bluetooth/smp.h         |  7 +++++++
> 6 files changed, 32 insertions(+), 36 deletions(-)

all 6 patches of v2 have been applied to bluetooth-next tree.

Regards

Marcel

