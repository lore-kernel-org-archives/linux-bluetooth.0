Return-Path: <jukka.rissanen@linux.intel.com>
Message-ID: <1461576282.28077.39.camel@linux.intel.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix memory corruption of ipv6
 destination address
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Glenn Ruben Bakke <glennrubenbakke@nordicsemi.no>, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke
	 <glenn.ruben.bakke@nordicsemi.no>
Date: Mon, 25 Apr 2016 12:24:42 +0300
In-Reply-To: <1461341171-2951-1-git-send-email-glennrubenbakke@nordicsemi.no>
References: <1461341171-2951-1-git-send-email-glennrubenbakke@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Glenn,

nice fix and it makes sense.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


On Fri, 2016-04-22 at 18:06 +0200, Glenn Ruben Bakke wrote:
> The memcpy of ipv6 header destination address to the skb control
> block
> (sbk->cb) in header_create() results in currupted memory when
> bt_xmit()
> is issued. The skb->cb is "released" in the return of header_create()
> making room for lower layer to minipulate the skb->cb.
> 
> The value retrieved in bt_xmit is not persistent across header
> creation
> and sending, and the lower layer will overwrite portions of skb->cb,
> making the copied destination address wrong.
> 
> The memory corruption will lead to non-working multicast as the first
> 4
> bytes of the copied destination address is replaced by a value that
> resolves into a non-multicast prefix.
> 
> The issue has also been observed in kernel 4.5.
> 
> This fix removes the dependency on the skb control block between
> header
> creation and send, by moving the destination address memcpy to the
> send
> function path (setup_create, which is called from bt_xmit).
> 
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> ---


Cheers,
Jukka
