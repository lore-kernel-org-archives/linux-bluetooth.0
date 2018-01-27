Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 27 Jan 2018 11:14:41 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Brown <sbrown@cortland.com>
Cc: linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH V2] mesh: meshctl: Add set heartbeat subscription command
Message-ID: <20180127191441.GA13291@x1c>
References: <20180117124432.14612-1-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180117124432.14612-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Wed, Jan 17, 2018, Steve Brown wrote:
> [config: Target = 0100]# hb-sub-set 0077 0100 2
> 
> Heartbeat subscription status for node 0100 status: Success
> Source:		0077
> Destination:	0100
> Period:		01
> Count:		00
> Min Hops:	7f
> Max Hops:	00
> ---
>  mesh/config-client.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 4 deletions(-)

Sorry, forgot about this one. Thanks for the ping. The patch has now
been applied upstream.

Johan
