Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 0/5] Bluetooth: Encryption Key Size fixes & improvements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434019950-24959-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 12 Jun 2015 11:41:18 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C07D0734-A59F-4DC8-96F3-6F297D3DB4EA@holtmann.org>
References: <1434019950-24959-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This set of patches:
> 
> - adds greater control of the LE Encryption Key Size through debugfs
> - adds reading of the encryption key size for BR/EDR connections and
>   uses the result appropriately for generating LTKs with SMP over
>   BR/EDR
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (5):
>      Bluetooth: Add debugfs support for max LE encryption key size
>      Bluetooth: Add debugfs support for min LE encryption key size
>      Bluetooth: Move SC-only check outside of BT_CONFIG branch
>      Bluetooth: Read encryption key size for BR/EDR connections
>      Bluetooth: Use actual encryption key size for SMP over BR/EDR
> 
> include/net/bluetooth/hci.h |  10 ++++
> net/bluetooth/hci_event.c   | 111 ++++++++++++++++++++++++++++++++++++-----
> net/bluetooth/smp.c         | 114 ++++++++++++++++++++++++++++++++++++++++---
> 3 files changed, 217 insertions(+), 18 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

