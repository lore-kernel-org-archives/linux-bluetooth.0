Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Nov 2011 13:39:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2] syncevolution: fix missing header file
Message-ID: <20111117113950.GA5884@fusion.localdomain>
References: <1321526525-2727-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1321526525-2727-1-git-send-email-mikel.astiz@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Nov 17, 2011, Mikel Astiz wrote:
> This missing include directive makes the syncevolution plugin fail to
> compile. In Fedora 16 with gcc version 4.6.1 20110908, the output is:
> 
> make --no-print-directory all-am
>   CC     plugins/syncevolution.o
> In file included from plugins/syncevolution.c:40:0:
> ./src/mimetype.h:33:46: error: unknown type name ‘mode_t’
> plugins/syncevolution.c:277:54: error: unknown type name ‘mode_t’
> plugins/syncevolution.c:438:2: error: unknown field ‘open’ specified in initializer
> plugins/syncevolution.c:438:10: error: ‘synce_open’ undeclared here (not in a function)
> make[1]: *** [plugins/syncevolution.o] Error 1
> ---
>  src/mimetype.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/src/mimetype.h b/src/mimetype.h
> index 79529b8..374dcac 100644
> --- a/src/mimetype.h
> +++ b/src/mimetype.h
> @@ -21,6 +21,8 @@
>   *
>   */
>  
> +#include <sys/types.h>
> +
>  typedef gboolean (*obex_object_io_func) (void *object, int flags, int err,
>  							void *user_data);

mimetype.h also contains usage of uint8_t and gboolean, yet it doesn't
include glib.h nor stdint.h. Either the .h file should include all of
its dependencies or none of them. Since including all of them hasn't
been the practice so far I'd say the right place for the missing include
is syncevolution.c.

Johan
