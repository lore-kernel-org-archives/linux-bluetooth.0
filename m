Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414677465-19862-8-git-send-email-luiz.dentz@gmail.com>
References: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
	<1414677465-19862-8-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 30 Oct 2014 10:56:48 -0700
Message-ID: <CAHrH25TPXh65KVbofwR=-44TuWkOB+mK6Zu30qVqRQCNXKP+QQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 8/9] shared/gatt-db: Add gatt_db_attribute_get_start_handle
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Thu, Oct 30, 2014 at 6:57 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  src/shared/gatt-db.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 6296a82..60a1b23 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -833,7 +833,10 @@ struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
>
>  uint16_t gatt_db_attribute_get_start_handle(struct gatt_db_attribute *attrib)

Expanding on the discussion about gatt_db_attribute_get_end_handle,
should we then rename this function to gatt_db_attribute_get_handle?

>  {
> -       return 0;
> +       if (!attrib)
> +               return 0;
> +
> +       return attrib->handle;
>  }
>
>  uint16_t gatt_db_attribute_get_end_handle(struct gatt_db_attribute *attrib)
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Arman
