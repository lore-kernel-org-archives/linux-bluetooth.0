Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Fix potential double-frees of L2CAP skbs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381404817-5645-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 10 Oct 2013 14:01:54 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <29312C56-952E-44B9-A83D-0D3E7CD771CA@holtmann.org>
References: <1381404817-5645-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The l2cap_recv_frame function is expected to take ownership and
> eventually free the skb passed to it. We need to ensure that the
> conn->rx_skb pointer is no longer reachable when calling
> l2cap_recv_frame so that no other function, such as l2cap_conn_del, may
> think that it can free conn->rx_skb.
> 
> An actual situation when this can happen is when smp_sig_channel (called
> from l2cap_recv_frame) fails and l2cap_conn_del gets called as a
> consequence. The l2cap_conn_del function would then try to free
> conn->rx_skb, but as the same skb was just passed to smp_sig_channel and
> freed we get a double-free.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

