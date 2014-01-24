Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Rename L2CAP_CHAN_CONN_FIX_A2MP to L2CAP_CHAN_FIXED
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390552541-11729-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 24 Jan 2014 00:45:49 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <BABD4DC0-2D23-4FFF-A068-8546C5A24C2B@holtmann.org>
References: <1390552541-11729-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's no reason why A2MP should need or deserve its on channel type.
> Instead we should be able to group all fixed CID users under a single
> channel type and reuse as much code as possible for them. Where CID
> specific exceptions are needed the chan-scid value can be used.
> 
> This patch renames the current A2MP channel type to a generic one and
> thereby paves the way to allow converting ATT and SMP (and any future
> fixed channel protocols) to use the new channel type.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/l2cap.h |  2 +-
> net/bluetooth/a2mp.c          |  8 ++++++--
> net/bluetooth/l2cap_core.c    | 15 ++++++---------
> 3 files changed, 13 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

