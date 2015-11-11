Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 0/3] Bluetooth: LE connection fixes & cleanups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447245899-30783-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Nov 2015 21:54:04 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <88B49EFF-3FA8-4C36-B2C1-B05064F0428C@holtmann.org>
References: <1447245899-30783-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This set of patches simplifies the LE connection logic and fixes
> outgoing connect attempts through directed advertising.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Fix specifying role for LE connections
>      Bluetooth: Move check for ongoing connect earlier in hci_connect_le()
>      Bluetooth: Remove conn_unfinished variable from hci_connect_le()
> 
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/hci_conn.c         | 60 ++++++++++++---------------------------
> net/bluetooth/l2cap_core.c       | 15 +++++-----
> net/bluetooth/mgmt.c             |  3 +-
> 4 files changed, 27 insertions(+), 53 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

