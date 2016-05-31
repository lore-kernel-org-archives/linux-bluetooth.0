Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1464693061.3135.48.camel@linux.intel.com>
Subject: Re: [PATCH stable backport] Bluetooth: 6lowpan: Fix memory
 corruption of ipv6 destination address
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>,
	stable@vger.kernel.org
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Date: Tue, 31 May 2016 14:11:01 +0300
In-Reply-To: <1464690195-2575-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
References: <1464690195-2575-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Glenn,

On Tue, 2016-05-31 at 12:23 +0200, Glenn Ruben Bakke wrote:
> Backport for v4.5 and v4.6 of
> commit 55441070ca1cbd47ce1ad2959bbf4b47aed9b83b upstream.
> 
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
> This fix removes the dependency on the skb control block between
> header
> creation and send, by moving the destination address memcpy to the
> send
> function path (setup_create, which is called from bt_xmit).
> 
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> ---

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

