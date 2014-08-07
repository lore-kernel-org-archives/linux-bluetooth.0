Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 0/9] Bluetooth: More generic L2CAP fixed channel handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 7 Aug 2014 13:10:58 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <314A6D20-E197-49B3-8F41-0F877372F1DF@holtmann.org>
References: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's v2 of my set with comments on patch 1/9 taken into account.
> 
> From the original cover letter:
> 
> "
> Here's a set of patches to make fixed L2CAP channel handling more
> generic. The main special-casing that's removed here is for ATT
> channels. The A2MP stuff is left for later since its semantics would
> change from creating the context only when there's data on the channel
> to as soon as we have a baseband link (which I'm not sure is desirable).
> 
> The main motivation for all of this work is to pave the way to convert
> SMP to fully use the l2cap_chan infrastructure.
> "
> 
> ----------------------------------------------------------------
> Johan Hedberg (9):
>      Bluetooth: Fix reference counting of global L2CAP channels
>      Bluetooth: Fix __l2cap_no_conn_pending() usage with all channels
>      Bluetooth: Resume BT_CONNECTED state after LE security elevation
>      Bluetooth: Remove special handling of ATT in l2cap_security_cfm()
>      Bluetooth: Refactor l2cap_connect_cfm
>      Bluetooth: Move L2CAP fixed channel creation into l2cap_conn_cfm
>      Bluetooth: Improve fixed channel lookup based on link type
>      Bluetooth: Remove special ATT data channel handling
>      Bluetooth: Move parts of fixed channel initialization to l2cap_add_scid
> 
> include/net/bluetooth/l2cap.h |   1 +
> net/bluetooth/l2cap_core.c    | 245 ++++++++++++++++++--------------------
> net/bluetooth/l2cap_sock.c    |  15 +--
> 3 files changed, 122 insertions(+), 139 deletions(-)

all 9 patches have been applied to bluetooth-next tree.

Regards

Marcel

