Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH 00/13] Bluetooth: Cleanups & fixes from the UPF
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 21 Oct 2015 19:02:25 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5AACD92D-670D-4641-B410-8A1636FB00FC@holtmann.org>
References: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's the left-over set of patches from the UPF which are not as
> critical as the other ones that were already applied. I didn't (yet)
> spend time sorting or splitting these more logically, but I decided to
> send what I have now to get an early review round for them.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (13):
>      Bluetooth: Add le_addr_type() helper function
>      Bluetooth: Add hci_conn_hash_lookup_le() helper function
>      Bluetooth: Use hci_conn_hash_lookup_le() when possible
>      Bluetooth: 6lowpan: Use hci_conn_hash_lookup_le() when possible
>      Bluetooth: Remove unnecessary indentation in unpair_device()
>      Bluetooth: Disable auto-connection parameters when unpairing
>      Bluetooth: Introduce hci_req helper to abort a connection
>      Bluetooth: Take advantage of connection abort helpers
>      Bluetooth: Remove redundant (and possibly wrong) flag clearing
>      Bluetooth: Make hci_disconnect() behave correctly for all states
>      Bluetooth: Add hdev helper variable to hci_le_create_connection_cancel
>      Bluetooth: Remove unnecessary hci_explicit_connect_lookup function
>      Bluetooth: Fix crash in SMP when unpairing
> 
> include/net/bluetooth/hci_core.h |  27 ++++++-
> net/bluetooth/6lowpan.c          |   2 +-
> net/bluetooth/hci_conn.c         | 115 ++++++--------------------
> net/bluetooth/hci_core.c         |  17 ----
> net/bluetooth/hci_event.c        |   3 +-
> net/bluetooth/hci_request.c      |  86 ++++++++++++++++++++
> net/bluetooth/hci_request.h      |   4 +
> net/bluetooth/mgmt.c             | 164 ++++++++++++++++----------------------
> net/bluetooth/smp.c              |  27 ++++++-
> net/bluetooth/smp.h              |   1 +
> 10 files changed, 236 insertions(+), 210 deletions(-)

so far I applied patches 1-5, 9 and 11-12 to bluetooth-next tree.

Regards

Marcel

