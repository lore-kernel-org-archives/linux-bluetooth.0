Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 16:32:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix not calling SetConfiguration on hfp/hsp endpoints
 before connected
Message-ID: <20101216143229.GA13322@jh-x301>
References: <1292508801-15581-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292508801-15581-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 16, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This cause some clients like PulseAudio to fail to find a proper
> transport since connected state is send before transport configuration
> is set.
> 
> To fix this now SetConfiguration is called early on when headset is still
> in connecting phase, this matches sink/source where SetConfiguration is
> also called before connected.
> ---
>  audio/media.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)

Pushed upstream. Thanks.

Johan
