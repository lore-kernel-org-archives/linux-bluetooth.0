Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Sep 2010 21:09:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fixes potential lockup while finding latency
Message-ID: <20100921180912.GB17885@jh-x301>
References: <1285087553-11868-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1285087553-11868-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Tue, Sep 21, 2010, Elvis Pfützenreuter wrote:
> (To be applied after Jose reorganization patch)
> 
> This patch fixes a potential infinite loop while finding the
> BT/system clock read latency. If the adapter is removed exactly
> at that moment, BT clock simply can't be read and it must quit.
> This is handled as a temporary failure (if a new connection is
> made, adapter is probably in place again).
> ---
>  health/mcap_sync.c |   46 ++++++++++++++++++++++++++++++++++++++++------
>  1 files changed, 40 insertions(+), 6 deletions(-)

Thanks. This patch has also been pushed upstream. In the future please
use the format "Fix ..." instead of "Fixes ..." in the summary message
to be consistent with the rest of the commit history. I changed it
manually this time before pushing upstream.

Johan
