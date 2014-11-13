Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH 1/2] Bluetooth: Fix L2CAP nesting level initialization location
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415864765-7507-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 13 Nov 2014 17:13:35 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <30503955-270D-4705-B760-71DE99A4CC5A@holtmann.org>
References: <1415864765-7507-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's no reason why all users of L2CAP would need to worry about
> initializing chan->nesting to L2CAP_NESTING_NORMAL (which is important
> since 0 is the same as NESTING_SMP). This patch moves the initialization
> to the common place that's used to create all new channels, i.e. the
> l2cap_chan_create() function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 3 +++
> net/bluetooth/l2cap_sock.c | 3 ---
> 2 files changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

