Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 May 2012 14:53:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] mgmtops: Fix wrong parameter order for
 btd_event_ltk_notify()
Message-ID: <20120502115349.GA20544@x220.ger.corp.intel.com>
References: <1335538622-8271-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335538622-8271-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Apr 27, 2012, Anderson Lizardo wrote:
> The "master" parameter was in the wrong place.
> ---
>  plugins/mgmtops.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> To those interested, this was not noticed before because:
> 
> * We don't use the stored information yet (although we will probably use soon
>   the "authenticated" field for ATT requests that return "Insufficient
>   Authentication")
> * The storage types for master/authenticated/enc_size are compatible.

Applied. Thanks.

Johan
