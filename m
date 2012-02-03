Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 13:22:14 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] src/obex.h: Include stdint.h
Message-ID: <20120203212214.GA31587@x220.globalsuite.net>
References: <1328266762-23552-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328266762-23552-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Feb 03, 2012, Slawomir Bochenski wrote:
> ---
>  src/obex.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/src/obex.h b/src/obex.h
> index 7f07fd2..95e9c4e 100644
> --- a/src/obex.h
> +++ b/src/obex.h
> @@ -22,6 +22,8 @@
>   *
>   */
>  
> +#include <stdint.h>
> +
>  #define OBJECT_SIZE_UNKNOWN -1
>  #define OBJECT_SIZE_DELETE -2

This file also contains GLib usage but there's no GLib include there.
Either *all* includes should be there or *none* should be there (i.e.
expect the .c files to include the dependencies). In this case I'd just
add the stdint include to whatever file had it missing (which one was it
btw?).

Johan
