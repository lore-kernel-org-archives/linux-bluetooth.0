Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 0/3] Bluetooth: hci_conn related fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418327146-15899-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 11 Dec 2014 21:00:46 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6E1E9926-9B62-4631-A83A-3B5F69F1358D@holtmann.org>
References: <1418327146-15899-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This set of patches contains fixes for various issues introduced by the
> generic cmd_complete callback mechanism for pending mgmt commands.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Fix calling hci_conn_put too early
>      Bluetooth: Fix incorrect pending cmd removal in pairing_complete()
>      Bluetooth: Fix notifying mgmt power off before flushing connection list
> 
> net/bluetooth/hci_core.c | 14 ++++++--------
> net/bluetooth/mgmt.c     | 42 +++++++++++++++++++++++++++---------------
> 2 files changed, 33 insertions(+), 23 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

