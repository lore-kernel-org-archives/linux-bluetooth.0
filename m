Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix memory corruption of ipv6 destination address
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1461341171-2951-1-git-send-email-glennrubenbakke@nordicsemi.no>
Date: Tue, 26 Apr 2016 08:08:48 +0900
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
Message-Id: <3652E85C-C347-44D3-98B6-2CF7F2A508DD@holtmann.org>
References: <1461341171-2951-1-git-send-email-glennrubenbakke@nordicsemi.no>
To: Glenn Ruben Bakke <glennrubenbakke@nordicsemi.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Glenn,

> The memcpy of ipv6 header destination address to the skb control block
> (sbk->cb) in header_create() results in currupted memory when bt_xmit()
> is issued. The skb->cb is "released" in the return of header_create()
> making room for lower layer to minipulate the skb->cb.
> 
> The value retrieved in bt_xmit is not persistent across header creation
> and sending, and the lower layer will overwrite portions of skb->cb,
> making the copied destination address wrong.
> 
> The memory corruption will lead to non-working multicast as the first 4
> bytes of the copied destination address is replaced by a value that
> resolves into a non-multicast prefix.
> 
> The issue has also been observed in kernel 4.5.
> 
> This fix removes the dependency on the skb control block between header
> creation and send, by moving the destination address memcpy to the send
> function path (setup_create, which is called from bt_xmit).
> 
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> ---
> net/bluetooth/6lowpan.c | 11 ++++-------
> 1 file changed, 4 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

