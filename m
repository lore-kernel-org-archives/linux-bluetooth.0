Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 15:17:12 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] device: Fix doing sdp discovery for LE devices
Message-ID: <20120203231712.GA4095@x220.globalsuite.net>
References: <1328310405-16329-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328310405-16329-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Feb 03, 2012, Vinicius Costa Gomes wrote:
> If ReverseServiceDiscovery is enabled and we are connected to a LE
> device, we should do a Primary Service Discovery, not a SDP discovery
> (which doesn't even make sense).
> ---
> 
> This patch assumes that it makes sense to reuse the ReverseServiceDiscovery
> functionality for LE devices.
> 
> 
>  src/device.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)

Applied. Thanks. (and yes, I do think it should be fine to "reverse
discover" LE services).

Johan
