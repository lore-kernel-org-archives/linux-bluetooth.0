Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 0/7] Bluetooth: Scanning & advertising co-existence fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 8 Jul 2014 14:32:47 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F3833BE9-9124-494E-8493-FC0A7A9CD5E1@holtmann.org>
References: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This set of patches tries to improve the current behavior of LE scanning
> and advertising so that both features can be used nicely together to the
> extent that current LE hardware supports them.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (7):
>      Bluetooth: Add flag to track the real advertising state
>      Bluetooth: Remove unnecessary mgmt_advertising function
>      Bluetooth: Use real advertising state to random address update decision
>      Bluetooth: Simplify usage of the enable_advertising function
>      Bluetooth: Use the correct flag to decide to disable advertising
>      Bluetooth: Stop advertising always before initiating a connection
>      Bluetooth: Fix advertising and active scanning co-existence
> 
> include/net/bluetooth/hci.h      |  4 +-
> include/net/bluetooth/hci_core.h |  1 -
> net/bluetooth/hci_conn.c         | 29 +++++++++--
> net/bluetooth/hci_core.c         |  2 +-
> net/bluetooth/hci_event.c        | 16 ++++--
> net/bluetooth/mgmt.c             | 98 ++++++++++++++++---------------------
> 6 files changed, 83 insertions(+), 67 deletions(-)

all 7 patches have been applied to bluetooth-next tree.

Regards

Marcel

