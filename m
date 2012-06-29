Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jun 2012 14:09:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] AVDTP: Remove auto_dc flag
Message-ID: <20120629110901.GA19540@x220>
References: <1340967745-17458-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340967745-17458-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jun 29, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> auto_dc flag is no longer useful as all the users of it just reset it
> to FALSE, also this was first introduced to maintain the stream for
> some time as the clients disconnected frequently, but this is not the
> case anymore.
> ---
>  audio/avdtp.c  |   33 +--------------------------------
>  audio/avdtp.h  |    1 -
>  audio/sink.c   |    2 --
>  audio/source.c |    2 --
>  4 files changed, 1 insertion(+), 37 deletions(-)

Both patches have been applied. Thanks.

Johan
