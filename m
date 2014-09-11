Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Sep 2014 22:27:42 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] core: Fix storing connection parameters without
 store hint set
Message-ID: <20140911052742.GA14192@t440s>
References: <1410379987-4265-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410379987-4265-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Sep 10, 2014, Szymon Janc wrote:
> If store hint is not set those should not be stored persistently.
> ---
> 
> I've decided to leave storing in adapter.c to keep it similar to new
> keys events. Memebers in device.c were used only for storing anyway.
> 
>  src/adapter.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Both patches have been applied. Thanks.

Johan
