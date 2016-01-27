Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 3/3] Bluetooth: L2CAP: Fix setting chan src info before adding PSM/CID
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1453846751-5925-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 27 Jan 2016 16:26:15 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ED359F38-2848-4199-A605-A6D589018553@holtmann.org>
References: <1453846751-5925-1-git-send-email-johan.hedberg@gmail.com> <1453846751-5925-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> At least the l2cap_add_psm() routine depends on the source address
> type being properly set to know what auto-allocation ranges to use, so
> the assignment to l2cap_chan needs to happen before this.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

