Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Fix l2cap_chan leak in SMP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447271232-29359-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 12 Nov 2015 07:49:53 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D59921C5-E1FF-4F12-8E03-25005D4FC5E7@holtmann.org>
References: <1447271232-29359-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The L2CAP core expects channel implementations to manage the reference
> returned by the new_connection callback. With sockets this is already
> handled with each channel being tied to the corresponding socket. With
> SMP however there's no context to tie the pointer to in the
> smp_new_conn_cb function. The function can also not just drop the
> reference since it's the only one at that point.
> 
> For fixed channels (like SMP) the code path inside the L2CAP core from
> new_connection() to ready() is short and straight-forwards. The
> crucial difference is that in ready() the implementation has access to
> the l2cap_conn that SMP needs associate its l2cap_chan. Instead of
> taking a new reference in smp_ready_cb() we can simply assume to
> already own the reference created in smp_new_conn_cb(), i.e. there is
> no need to call l2cap_chan_hold().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org # 3.19+
> ---
> net/bluetooth/smp.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

