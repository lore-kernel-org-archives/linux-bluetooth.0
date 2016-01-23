Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 23 Jan 2016 12:27:07 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: alex.aring@gmail.com, linux-bluetooth@vger.kernel.org,
	glenn.ruben.bakke@nordicsemi.no
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix handling of uncompressed IPv6
 packets
Message-ID: <20160123122707.GB16166@t440s>
References: <1452700668-4241-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452700668-4241-1-git-send-email-lukasz.duda@nordicsemi.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Jan 13, 2016, Lukasz Duda wrote:
> This patch fixes incorrect handling of the 6lowpan packets that contain
> uncompressed IPv6 header.
> 
> RFC4944 specifies a special dispatch for 6lowpan to carry uncompressed
> IPv6 header. This dispatch (1 byte long) has to be removed during
> reception and skb data pointer has to be moved. To correctly point in
> the beginning of the IPv6 header the dispatch byte has to be pulled off
> before packet can be processed by netif_rx_in().
> 
> Test scenario: IPv6 packets are not correctly interpreted by the network
> layer when IPv6 header is not compressed (e.g. ICMPv6 Echo Reply is not
> propagated correctly to the ICMPv6 layer because the extra byte will make
> the header look corrupted).
> 
> Similar approach is done for IEEE 802.15.4.
> 
> Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> ---
>  net/bluetooth/6lowpan.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to bluetooth.git. Thanks.

Johan
