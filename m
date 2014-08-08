Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 0/3] A few more cleanups for l2cap_chan based SMP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407479285-4261-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 8 Aug 2014 10:47:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E561DB56-B5F0-4D02-AC2A-3610CA29C049@holtmann.org>
References: <1407479285-4261-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here are a few more cleanups/fixes in preparation for converting SMP to
> use l2cap_chan.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Call L2CAP teardown callback before clearing chan->conn
>      Bluetooth: Call l2cap_le_conn_ready after notifying channels
>      Bluetooth: Fix using HCI_CONN_LE_SMP_PEND to check for SMP context
> 
> net/bluetooth/l2cap_core.c | 10 +++++-----
> net/bluetooth/smp.c        |  2 +-
> 2 files changed, 6 insertions(+), 6 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

