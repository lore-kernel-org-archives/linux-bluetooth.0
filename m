Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 23 Jan 2016 12:25:36 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
Cc: alex.aring@gmail.com, linux-bluetooth@vger.kernel.org,
	lukasz.duda@nordicsemi.no
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix kernel NULL pointer dereferences
Message-ID: <20160123122536.GA16166@t440s>
References: <1452699702-3986-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452699702-3986-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Glenn,

On Wed, Jan 13, 2016, Glenn Ruben Bakke wrote:
> The fixes provided in this patch assigns a valid net_device structure to
> skb before dispatching it for further processing.
> 
> Scenario #1:
> ============
> 
> Bluetooth 6lowpan receives an uncompressed IPv6 header, and dispatches it
> to netif. The following error occurs:
> 
> Null pointer dereference error #1 crash log:
> 
> [  845.854013] BUG: unable to handle kernel NULL pointer dereference at
>                0000000000000048
> [  845.855785] IP: [<ffffffff816e3d36>] enqueue_to_backlog+0x56/0x240
> ...
> [  845.909459] Call Trace:
> [  845.911678]  [<ffffffff816e3f64>] netif_rx_internal+0x44/0xf0
> 
> The first modification fixes the NULL pointer dereference error by
> assigning dev to the local_skb in order to set a valid net_device before
> processing the skb by netif_rx_ni().
> 
> Scenario #2:
> ============
> 
> Bluetooth 6lowpan receives an UDP compressed message which needs further
> decompression by nhc_udp. The following error occurs:
> 
> Null pointer dereference error #2 crash log:
> 
> [   63.295149] BUG: unable to handle kernel NULL pointer dereference at
>                0000000000000840
> [   63.295931] IP: [<ffffffffc0559540>] udp_uncompress+0x320/0x626
>                [nhc_udp]
> 
> The second modification fixes the NULL pointer dereference error by
> assigning dev to the local_skb in the case of a udp compressed packet.
> The 6lowpan udp_uncompress function expects that the net_device is set in
> the skb when checking lltype.
> 
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> ---
>  net/bluetooth/6lowpan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to bluetooth.git. Thanks.

Johan
