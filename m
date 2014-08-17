Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 0/9] Bluetooth: Reference counting and other fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 17 Aug 2014 16:35:39 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <75FA9245-93AC-4BF3-8A67-FC6DE9586533@holtmann.org>
References: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Since we're not at the moment applying anything new to bluetooth-next
> (due to the merge window being still open) I'm sending all my pending
> patches in a single set to ease applying them in the correct order.
> 
> The two patches requiring some special consideration for 3.17 and stable
> kernel trees are the following two:
> 
>   Bluetooth: Fix incorrect LE CoC PDU length restriction based on HCI MTU
>   Bluetooth: Fix hci_conn reference counting for auto-connections
> 
> Of those two the second one is a "must have" for 3.17 whereas the first
> one would be nice to get fixed for older kernels. All other patches in
> this set are fine to wait for 3.18.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (9):
>      Bluetooth: Fix incorrect LE CoC PDU length restriction based on HCI MTU
>      Bluetooth: Remove unnecessary l2cap_chan_unlock before l2cap_chan_add
>      Bluetooth: Fix hci_conn reference counting for fixed channels
>      Bluetooth: Fix hci_conn reference counting for auto-connections
>      Bluetooth: Set addr_type only when it's needed
>      Bluetooth: Optimize connection parameter lookup for LE connections
>      Bluetooth: Improve *_get() functions to return the object type
>      Bluetooth: Fix using hci_conn_get() for hci_conn pointers
>      Bluetooth: Refactor connection parameter freeing into its own function
> 
> include/net/bluetooth/hci_core.h |  5 ++++-
> include/net/bluetooth/l2cap.h    |  3 ++-
> net/bluetooth/hci_conn.c         |  9 +++++++++
> net/bluetooth/hci_core.c         | 33 +++++++++++++++++++++++----------
> net/bluetooth/hci_event.c        | 31 +++++++++++++++++++++++--------
> net/bluetooth/hidp/core.c        | 10 ++++------
> net/bluetooth/l2cap_core.c       | 26 ++++++++++++++------------
> net/bluetooth/l2cap_sock.c       |  8 ++++++++
> net/bluetooth/mgmt.c             | 10 +++++++---
> 9 files changed, 94 insertions(+), 41 deletions(-)

all 9 patches have been applied to bluetooth-next tree.

Regards

Marcel

