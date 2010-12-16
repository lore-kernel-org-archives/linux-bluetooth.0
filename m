Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 16:33:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix sending duplicate speaker/microphone gains to the
 headset
Message-ID: <20101216143332.GB13322@jh-x301>
References: <1292508801-15581-1-git-send-email-luiz.dentz@gmail.com>
 <1292508801-15581-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292508801-15581-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 16, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Current code only prevent duplicate D-Bus signals, so in case headset
> changes the volume a client may set the same volume level again which
> would be send as new volume level.
> 
> To fix this headset_set_gain now return -EALREADY if nothing has changed
> so code using it can just ignore the change instead of sending to remote
> device.
> ---
>  audio/headset.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)

This one has also been pushed upstream. Thanks.

Johan
