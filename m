Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 0/3] Bluetooth: Optimize bt_cb(skb) usage
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1446708701-1387-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 5 Nov 2015 18:40:24 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9F01F8D8-FBB7-4FB5-A642-13FE928027AD@holtmann.org>
References: <1446708701-1387-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This set of patches does changes to the structs behind bt_cb(skb) to
> minimize their sizes. This is important since skb->cb has a quite small
> fixed size.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Remove redundant setting to zero of bt_cb
>      Bluetooth: Compress the size of struct hci_ctrl
>      Bluetooth: bt_skb_cb: Merge force_active and incoming into flags
> 
> include/net/bluetooth/bluetooth.h | 25 ++++++++++++++-----------
> include/net/bluetooth/hci_core.h  |  2 +-
> net/bluetooth/hci_conn.c          |  4 ++--
> net/bluetooth/hci_core.c          | 29 ++++++++++++++++-------------
> net/bluetooth/hci_request.c       | 10 +++++++---
> net/bluetooth/hci_sock.c          | 12 ++++++------
> net/bluetooth/l2cap_core.c        |  7 +++++--
> 7 files changed, 51 insertions(+), 38 deletions(-)

patch 1 and 2 have been applied to bluetooth-next tree.

I am not so sure about patch 3 yet. I think that needs a deeper look into it.

Regards

Marcel

