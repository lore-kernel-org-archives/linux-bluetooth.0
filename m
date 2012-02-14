Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 12:49:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v2 0/3] Minor audio-related fixes
Message-ID: <20120214104915.GA2846@x220>
References: <1329210394-31405-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329210394-31405-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 14, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> This patch series includes minor modifications that have been useful
> while testing the Media API for HFP use-cases.
> 
> These three patches were acked by Luiz Augusto von Dentz the 15-12-2011.
> 
> The first patch has been removed from the previous proposal, given
> that it doesn't really solve the underlying problem. According to Luiz
> (15-12-2011):
> 
> "gateway_suspend_stream as it is useless, but I think we should fix it
> to work similarly to headset_suspend_stream so we properly wait until
> the socket is closed before we unlock and reply, this is necessary in
> order to properly synchronize switching profiles otherwise
> gateway_suspend_complete maybe called without SCO being completely
> disconnected. Also when a fd is passed over to another process calling
> close/g_io_channel_shutdown is not enough since this only release our
> reference, in this case shutdown must be called."
> 
> This issue is not tackled here.
> 
> Mikel Astiz (3):
>   audio: gateway_unlock together with in_use = FALSE
>   a2dp: return NotSupported error if no server found
>   audio: do not disconnect on gateway SCO failure
> 
>  audio/a2dp.c      |    2 +-
>  audio/gateway.c   |    2 +-
>  audio/transport.c |    3 ++-
>  3 files changed, 4 insertions(+), 3 deletions(-)

All three patches have been applied. Thanks.

Johan
