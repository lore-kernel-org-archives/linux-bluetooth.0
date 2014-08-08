Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 0/5] Bluetooth: Add dedicated SMP (de)initialization functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 8 Aug 2014 10:47:30 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <47B15D32-48CE-4D2C-B6C9-9DCDE04632B0@holtmann.org>
References: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> For us to have a clean way to create the root (per-adapter) SMP L2CAP
> channel it's best to move the code responsible for this to specialized
> functions in smp.c. For now this only involves the AES crypto context
> creation and destruction.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (5):
>      Bluetooth: Fix hci_update_random_address() error return for no crypto
>      Bluetooth: Fix IRK lookup when tfm_aes is not available
>      Bluetooth: Refactor SMP (de)initialization into separate functions
>      Bluetooth: Move SMP initialization after HCI init
>      Bluetooth: Move SMP (de)initialization to smp.c
> 
> net/bluetooth/hci_core.c | 27 +++++++++++++--------------
> net/bluetooth/smp.c      | 26 ++++++++++++++++++++++++++
> net/bluetooth/smp.h      |  3 +++
> 3 files changed, 42 insertions(+), 14 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

