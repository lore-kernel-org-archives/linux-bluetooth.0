Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171214120300.20018-1-luiz.dentz@gmail.com>
References: <20171214120300.20018-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Dec 2017 09:53:29 -0200
Message-ID: <CABBYNZ+Jhcm6P4eSiFyKN2zKUgQWtzWNkuiTrcLtA77MGR5Dig@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] monitor: Detect string format
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 14, 2017 at 10:02 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> User may enter UUID in string format other then 128 bits.
> ---
>  monitor/uuid.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/uuid.c b/monitor/uuid.c
> index 9839d03be..bc638a2f3 100644
> --- a/monitor/uuid.c
> +++ b/monitor/uuid.c
> @@ -27,6 +27,7 @@
>  #endif
>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <string.h>
>
>  #include "uuid.h"
> @@ -735,12 +736,28 @@ const char *uuid32_to_str(uint32_t uuid)
>  const char *uuidstr_to_str(const char *uuid)
>  {
>         uint32_t val;
> +       size_t len;
>         int i;
>
>         if (!uuid)
>                 return NULL;
>
> -       if (strlen(uuid) != 36)
> +       len = strlen(uuid);
> +
> +       if (len < 36) {
> +               char *endptr = NULL;
> +
> +               val = strtol(uuid, &endptr, 0);
> +               if (!endptr || *endptr != '\0')
> +                       return NULL;
> +
> +               if (val > UINT16_MAX)
> +                       return uuid32_to_str(val);
> +
> +               return uuid16_to_str(val);
> +       }
> +
> +       if (len != 36)
>                 return NULL;
>
>         for (i = 0; uuid128_table[i].str; i++) {
> --
> 2.13.6

Patches 1-9 have been applied.


-- 
Luiz Augusto von Dentz
