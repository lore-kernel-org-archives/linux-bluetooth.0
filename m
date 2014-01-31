Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 0/4] Bluetooth: SMP LTK fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 30 Jan 2014 19:51:11 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <F5456509-57D4-43E6-BA8F-125B40BA8378@holtmann.org>
References: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that my LTK key distribution patch is already applied I
> unfortunately uncovered several bugs due to it. The main issue is that
> the kernel code was not accounting for the possibility of there being
> two LTKs for the same remote device in the hdev->long_term_keys list.
> 
> There are still fixes needed on the user space side which I haven't
> completely sorted out yet (to pushable form - it's more or less working
> already through). Right now the storage format doesn't allow storing two
> LTKs for the same device.
> 
> ----------------------------------------------------------------
> Johan Hedberg (4):
>      Bluetooth: Fix long_term_keys debugfs output
>      Bluetooth: Make LTK key type check more readable
>      Bluetooth: Remove unnecessary LTK type check from hci_add_ltk
>      Bluetooth: Fix differentiating stored master vs slave LTK types
> 
> include/net/bluetooth/hci_core.h |  5 +++--
> net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++----------
> net/bluetooth/hci_event.c        |  2 +-
> net/bluetooth/smp.c              |  3 ++-
> 4 files changed, 27 insertions(+), 14 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

