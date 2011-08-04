Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312410038-21169-1-git-send-email-dforsi@gmail.com>
References: <1312410038-21169-1-git-send-email-dforsi@gmail.com>
Date: Thu, 4 Aug 2011 11:23:44 +0300
Message-ID: <CABBYNZ+BAH-FzFRRFzObK7q3aA94iKuG=OHyGL53NvTffoNRiA@mail.gmail.com>
Subject: Re: [PATCH obexd] Fix compilation when NEED_G_SLIST_FREE_FULL is defined
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Daniele Forsi <dforsi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniele,

On Thu, Aug 4, 2011 at 1:20 AM, Daniele Forsi <dforsi@gmail.com> wrote:
> From: Daniele Forsi <daniele@forsi.it>
>
> To use the replacement for g_slist_free_full() both compat.h and
> glib-helper.h need to be included.
>
> Fixes:
> gobex/gobex.c:911: error: implicit declaration of function 'g_slist_free_full'
> tools/test-server.c:344: error: implicit declaration of function ‘g_slist_free_full’
> ---
>  gobex/gobex.c       |    5 +++++
>  tools/test-server.c |    4 ++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index 2a64849..ff35830 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -19,11 +19,16 @@
>  *
>  */
>
> +#ifdef HAVE_CONFIG_H
> +# include "config.h"
> +#endif
> +
>  #include <unistd.h>
>  #include <string.h>
>  #include <errno.h>
>
>  #include "gobex.h"
> +#include "glib-helper.h"
>
>  #define G_OBEX_DEFAULT_MTU     4096
>  #define G_OBEX_MINIMUM_MTU     255
> diff --git a/tools/test-server.c b/tools/test-server.c
> index 87742ec..6096737 100644
> --- a/tools/test-server.c
> +++ b/tools/test-server.c
> @@ -19,6 +19,10 @@
>  *
>  */
>
> +#ifdef HAVE_CONFIG_H
> +# include "config.h"
> +#endif
> +
>  #include <sys/types.h>
>  #include <sys/socket.h>
>  #include <fcntl.h>
> --
> 1.7.1
>
> --

Thank you for catching this.


-- 
Luiz Augusto von Dentz
