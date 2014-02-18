Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 0/7] Bluetooth: More privacy related patches
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 18 Feb 2014 11:49:08 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <42CA9FB9-4A3D-4A9F-B373-84DB32287882@holtmann.org>
References: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here are some updated patches from the previous set that still didn't
> make it upstream as well as some new ones. I'm now starting to be at the
> point where the next inevitable step is to add the New IRK mgmt event
> (which I've been postponing so far).
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (7):
>      Bluetooth: Remove SMP data specific crypto context
>      Bluetooth: Track the LE Identity Address in struct hci_conn
>      Bluetooth: Fix updating Identity Address in L2CAP channels
>      Bluetooth: Wait for SMP key distribution completion when pairing
>      Bluetooth: Don't try to look up private addresses as Identity Address
>      Bluetooth: Look up RPA for connection requests with Identity Address
>      Bluetooth: Use Identity Address in Device Found event
> 
> include/net/bluetooth/hci_core.h |  1 +
> include/net/bluetooth/l2cap.h    |  1 +
> net/bluetooth/hci_conn.c         | 19 +++++++++++++-----
> net/bluetooth/hci_core.c         |  4 ++++
> net/bluetooth/hci_event.c        |  8 ++++++++
> net/bluetooth/l2cap_core.c       | 17 +++++++++++++++++
> net/bluetooth/mgmt.c             | 37 ++++++++++++++++++++++++++++--------
> net/bluetooth/smp.c              | 36 ++++++++++++++++++++++++-----------
> net/bluetooth/smp.h              |  2 +-
> 9 files changed, 100 insertions(+), 25 deletions(-)

all 7 patches have been applied to bluetooth-next tree.

Regards

Marcel

