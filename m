Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 00/13] Bluetooth: L2CAP cleanups and fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 29 Apr 2013 10:07:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C9C690AB-DBFC-402B-8547-9DB60BB9E8B0@holtmann.org>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This set of patches contains some cleanups and fixes for future L2CAP
> work. The L2CAP usage in coming core spec versions will no longer be as
> constrined as it has so far with extensions to the LE signalling
> channel etc. This means that we really do need separate code paths for
> LE signalling instead of sharing BR/EDR related signalling code. The
> patches to split this up keep the same functionality as before (for now)
> but ensure that we have dedicated functions and structs for LE.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (13):
>      Bluetooth: Handle LE L2CAP signalling in its own function
>      Bluetooth: Create independent LE signalling defines and structs
>      Bluetooth: Rename L2CAP_CID_LE_DATA to L2CAP_CID_ATT
>      Bluetooth: Fix LE vs BR/EDR selection when connecting
>      Bluetooth: Fix EBUSY condition test in l2cap_chan_connect
>      Bluetooth: Fix hardcoding ATT CID in __l2cap_chan_add()
>      Bluetooth: Add clarifying comment to l2cap_conn_ready()
>      Bluetooth: Fix duplicate call to l2cap_chan_ready()
>      Bluetooth: Remove useless sk variable in l2cap_le_conn_ready
>      Bluetooth: Remove unnecessary L2CAP channel state check
>      Bluetooth: Simplify hci_conn_hold/drop logic for L2CAP
>      Bluetooth: Remove useless hci_conn disc_timeout setting
>      Bluetooth: Fix multiple LE socket handling
> 
> include/net/bluetooth/l2cap.h |   36 ++++++++--
> net/bluetooth/l2cap_core.c    |  145 ++++++++++++++++++++++++++---------------
> net/bluetooth/l2cap_sock.c    |    4 +-
> 3 files changed, 126 insertions(+), 59 deletions(-)

the whole set looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

