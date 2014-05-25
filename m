Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1400957638-18418-2-git-send-email-szymon.janc@gmail.com>
References: <1400957638-18418-1-git-send-email-szymon.janc@gmail.com>
	<1400957638-18418-2-git-send-email-szymon.janc@gmail.com>
Date: Sun, 25 May 2014 19:01:12 +0300
Message-ID: <CABBYNZJ5zb5-1ePb_snWJ5Q=eVpKRQnipER08-sh5-Ec=sr_Ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] shared/uhid: Use uhid_copy.h instead of system header
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sat, May 24, 2014 at 9:53 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> ---
>  src/shared/uhid.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/uhid.h b/src/shared/uhid.h
> index fcf5379..459a249 100644
> --- a/src/shared/uhid.h
> +++ b/src/shared/uhid.h
> @@ -23,7 +23,8 @@
>
>  #include <stdbool.h>
>  #include <stdint.h>
> -#include <linux/uhid.h>
> +
> +#include "profiles/input/uhid_copy.h"
>
>  struct bt_uhid;
>
> --
> 2.0.0.rc4

Maybe we should move uhid_copy to shared or just merge it in uhid.h,
anyway no code should be using uhid_copy alone now that we bt_uhid in
place.


-- 
Luiz Augusto von Dentz
