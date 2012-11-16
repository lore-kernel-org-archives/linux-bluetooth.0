Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Nov 2012 16:22:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio: Bump A2DP version to 1.03
Message-ID: <20121116142231.GA5656@x220>
References: <1353071513-32182-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353071513-32182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Nov 16, 2012, Luiz Augusto von Dentz wrote:
> In addition remove support of setting DelayReporting in audio.conf as
> it should always be supported in the service record since it doesn't
> mean the endpoint must support it because it is actually negotiated
> during the stream configuration.
> ---
>  profiles/audio/a2dp.c  | 19 ++++---------------
>  profiles/audio/avdtp.c | 20 +++-----------------
>  profiles/audio/avdtp.h |  2 +-
>  3 files changed, 8 insertions(+), 33 deletions(-)

Applied. Thanks.

Johan
