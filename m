Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 0/6] Bluetooth: LE Security fixes/improvements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Mar 2014 07:52:40 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <20042F41-F90A-44D3-958C-BCEA2440CD45@holtmann.org>
References: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a set of patches I've ended up creating today due to various
> issues found with LE security handling. Most of the issues fixed have
> been in the three for a bit longer time, but the issue fixed by 3/6 was
> introduced (by me) by the change to use passkey notification instead of
> confirmation.
> 
> I've left the LTK re-encryption removal to be the last patch since it
> can be debated whether we want it or not. I've on occasion had quite
> many LTK re-encryption failures when testing against my iPhone, but
> mostly it works just fine. Removing the re-encryption drops the failures
> to 0. Today I kept getting local failures (Start Encrypt cmd_status)
> constantly with local Intel Bluetooth hardware and a Bluetooth mouse.
> Removing the re-encryption made this work again.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (6):
>      Bluetooth: Fix potential NULL pointer dereference in SMP
>      Bluetooth: Add missing cmd_status handler for LE_Start_Encryption
>      Bluetooth: Fix SMP confirmation callback handling
>      Bluetooth: Add SMP flag to track which side is the initiator
>      Bluetooth: Don't try to confirm locally initiated SMP pairing
>      Bluetooth: Remove LTK re-encryption procedure
> 
> net/bluetooth/hci_event.c | 34 +++++++++++++++++++++
> net/bluetooth/smp.c       | 71
> ++++++++++++++++---------------------------
> net/bluetooth/smp.h       |  7 ++---
> 3 files changed, 63 insertions(+), 49 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

