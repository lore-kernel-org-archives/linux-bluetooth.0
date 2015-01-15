Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix lookup of fixed channels by local bdaddr
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1421320005-26037-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 15 Jan 2015 07:59:21 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <88D40788-F79D-426C-91C2-C5E1C792F828@holtmann.org>
References: <1421320005-26037-1-git-send-email-johan.hedberg@gmail.com> <1421320005-26037-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The comparing of chan->src should always be done against the local
> identity address, represented by hcon->src and hcon->src_type. This
> patch modifies l2cap_global_fixed_chan() to take the full hci_conn so
> that we can easily compare against hcon->src and hcon->src_type.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 15 +++++++--------
> 1 file changed, 7 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

