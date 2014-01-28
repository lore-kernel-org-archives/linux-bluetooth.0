Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 4/4] Bluetooth: Always use l2cap_chan->psm for returning PSM to user space
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390951011-30576-4-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Jan 2014 15:33:22 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <FB392A43-EDB6-4A16-BDCD-39915CFC4F5A@holtmann.org>
References: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com> <1390951011-30576-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The l2cap_chan->psm value is always set to a valid value for a
> connection oriented channel. The l2cap_chan->sport is used for tracking
> local PSM allocations but will not always have a proper value, such as
> with connected sockets derived from a listening socket. This patch fixes
> the sock_getname callback to always use chan->psm when returning address
> information.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

