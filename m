Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408525581-2679-1-git-send-email-ncopa@alpinelinux.org>
References: <CBEB55B4-D5B1-4C9E-AA29-63D2F72B5F61@holtmann.org>
	<1408525581-2679-1-git-send-email-ncopa@alpinelinux.org>
Date: Wed, 20 Aug 2014 13:41:28 +0300
Message-ID: <CABBYNZJm9haBNL=u7BoXUS1E5ARRbbOVPuMD7gD5DKwzEuusbQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools: fix headers for bcm43xx
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natanael,

On Wed, Aug 20, 2014 at 12:06 PM, Natanael Copa <ncopa@alpinelinux.org> wrote:
> PATH_MAX is defined in limits.h so include it explicitly.
>
> This fixes the following compile error on musl libc (Alpine Linux):
> tools/hciattach_bcm43xx.c: In function 'bcm43xx_locate_patch':
> tools/hciattach_bcm43xx.c:313:14: error: 'PATH_MAX' undeclared (first use in this function)
>     char path[PATH_MAX];
>                   ^
> ---
> This is a delayed follow-up of:
> http://comments.gmane.org/gmane.linux.bluez.kernel/47523
>
> Changes since v1:
>  - remove signed-off-by line
>  - fix typo in commit message
>
>  tools/hciattach_bcm43xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
> index ad9b239..cb4bfb9 100644
> --- a/tools/hciattach_bcm43xx.c
> +++ b/tools/hciattach_bcm43xx.c
> @@ -34,6 +34,7 @@
>  #include <errno.h>
>  #include <dirent.h>
>  #include <time.h>
> +#include <limits.h>
>
>  #include <bluetooth/bluetooth.h>
>  #include <bluetooth/hci.h>
> --
> 2.1.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
