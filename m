Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428927059-14345-1-git-send-email-luiz.dentz@gmail.com>
References: <1428927059-14345-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2015 16:54:38 +0300
Message-ID: <CABBYNZ+Ks2GzGXQiW-m8MKf8rcL-_p49zSRws7_KyBWz21eWAQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/gatt-database: Fix endless loop
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 13, 2015 at 3:10 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The descriptors list may contain descriptors from another services which
> should be ignored but the code did not iterate to next item causing an
> endless loop if that happen.
> ---
>  src/gatt-database.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index bbeb7cd..f182fd0 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1964,7 +1964,7 @@ static bool database_add_chrc(struct external_service *service,
>                 struct external_desc *desc = entry->data;
>
>                 if (desc->handled || g_strcmp0(desc->chrc_path, chrc->path))
> -                       continue;
> +                       goto next;
>
>                 if (!database_add_desc(service, desc)) {
>                         chrc->attrib = NULL;
> @@ -1972,6 +1972,7 @@ static bool database_add_chrc(struct external_service *service,
>                         return false;
>                 }
>
> +next:
>                 entry = entry->next;
>         }
>
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
