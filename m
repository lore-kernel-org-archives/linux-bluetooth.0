Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 13 Feb 2018 14:09:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Brown <sbrown@cortland.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] mesh: meshctl: Add heartbeat get subscribe and
 publish
Message-ID: <20180213120908.GA32494@x1c>
References: <20180205212848.27856-1-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180205212848.27856-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Mon, Feb 05, 2018, Steve Brown wrote:
> [config: Target = 0100]# hb-pub-get
> 
> Set heartbeat for node 0100 status: Success
> Destination:	c000
> Count:		00
> Period:		00
> TTL:		ff
> Features:	0000
> Net_Idx:	0000
> 
> [config: Target = 0100]# hb-sub-get
> 
> Heartbeat subscription status for node 0100 status: Success
> Source:		0100
> Destination:	0100
> Period:		00
> Count:		00
> Min Hops:	7f
> Max Hops:	00
> ---
>  mesh/config-client.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

All three patches in this set have been applied upstream. Thanks.

Johan
