Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Fix accepting early data on fixed channels
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424079731-21609-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Feb 2015 07:50:05 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8CD4CA63-DE42-47C4-9AC4-36FA960DEC0D@holtmann.org>
References: <1424079731-21609-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> On BR/EDR the L2CAP channel instances for fixed channels have so far
> been marked as ready only once the L2CAP information req/rsp procedure
> is complete and we have the fixed channel mask. This could however lead
> to data being dropped if we receive it on the channel before knowing the
> remote mask.
> 
> Since it is valid for a remote to send data this early, simply assume
> that the channel is supported when we receive data on it. So far this
> hasn't been noticed much because of limited use of fixed channels on
> BR/EDR, but e.g. with SMP over BR/EDR this is already now visible with
> automated tests failing randomly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

