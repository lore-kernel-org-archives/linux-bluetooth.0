Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 10:43:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Remove unneeded textfile header include
Message-ID: <20120530074315.GE6539@x220>
References: <1338299726-25822-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338299726-25822-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, May 29, 2012, Claudio Takahasi wrote:
> ---
>  src/device.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index 0961ff6..7ff09aa 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -44,7 +44,6 @@
>  #include <gdbus.h>
>  
>  #include "log.h"
> -#include "textfile.h"
>  
>  #include "att.h"
>  #include "hcid.h"

Applied. Thanks.

Johan
