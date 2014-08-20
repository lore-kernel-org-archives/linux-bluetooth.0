Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408526267-12159-1-git-send-email-ncopa@alpinelinux.org>
References: <1408526267-12159-1-git-send-email-ncopa@alpinelinux.org>
Date: Wed, 20 Aug 2014 13:41:56 +0300
Message-ID: <CABBYNZKaJy+VNNL-X2b5GRP3qHoxynCaWdVjxWMtZH1gW27atA@mail.gmail.com>
Subject: Re: [PATCH] shared: include limits.h for PATH_MAX
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natanael,

On Wed, Aug 20, 2014 at 12:17 PM, Natanael Copa <ncopa@alpinelinux.org> wrote:
> PATH_MAX is defined in limits.h so include it explicitly.
>
> This fixes the following compile error on musl libc (Alpine Linux):
> src/shared/util.c: In function 'util_get_dt':
> src/shared/util.c:99:16: error: 'PATH_MAX' undeclared (first use in this function)
>   char filename[PATH_MAX];
>                 ^
> ---
>  src/shared/util.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 8530440..74ffb08 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -32,6 +32,7 @@
>  #include <sys/stat.h>
>  #include <unistd.h>
>  #include <dirent.h>
> +#include <limits.h>
>
>  #include "src/shared/util.h"
>
> --
> 2.1.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
