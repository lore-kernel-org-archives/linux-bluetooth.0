Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Nov 2011 21:11:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v3] syncevolution: fix missing header file
Message-ID: <20111117191144.GA18806@fusion.localdomain>
References: <1321537565-13123-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1321537565-13123-1-git-send-email-mikel.astiz@bmw-carit.de>
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
>  plugins/syncevolution.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
> index 41386b3..8a8b531 100644
> --- a/plugins/syncevolution.c
> +++ b/plugins/syncevolution.c
> @@ -30,6 +30,7 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <glib.h>
> +#include <sys/types.h>
>  #include <dbus/dbus.h>
>  
>  #include <bluetooth/bluetooth.h>

Applied after a slight fix: the intended order for the includes is libc
first and then the rest (i.e. sys/types.h should be before glib.h).

Johan
