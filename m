Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180419140312.22707-4-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180419140312.22707-1-grzegorz.kolodziejczyk@codecoup.pl> <20180419140312.22707-4-grzegorz.kolodziejczyk@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Apr 2018 18:11:42 +0300
Message-ID: <CABBYNZK98ZsQ8oa6DHm-CsNZvLkALR6H-Vp8eg0xSp5aU5cY4A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/4] shared/gatt-server: Fix prepare write queuing
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thu, Apr 19, 2018 at 5:03 PM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
> Multiple prepare writes may be done for multiple attributes. Queue
> mechanism must be aware of handle under which preparation is done.
> ---
>  src/shared/gatt-server.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 4b554f665..d1efa83a1 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1190,6 +1190,14 @@ static bool prep_data_new(struct bt_gatt_server *server,
>         return true;
>  }
>
> +static bool match_prep_attr_handle(const void *data, const void *match_data)
> +{
> +       const struct prep_write_data *prep_data = data;
> +       const uint16_t *match_handle = match_data;
> +
> +       return prep_data->handle == *match_handle;
> +}
> +
>  static bool store_prep_data(struct bt_gatt_server *server,
>                                         uint16_t handle, uint16_t offset,
>                                         uint16_t length, uint8_t *value)
> @@ -1200,9 +1208,10 @@ static bool store_prep_data(struct bt_gatt_server *server,
>          * Now lets check if prep write is a continuation of long write
>          * If so do aggregation of data
>          */
> -       prep_data = queue_peek_tail(server->prep_queue);
> -       if (prep_data && (prep_data->handle == handle) &&
> -                       (offset == (prep_data->length + prep_data->offset)))
> +       prep_data = queue_find(server->prep_queue, match_prep_attr_handle,
> +                                                               &handle);

If I got this right it is not that the code is broken, it just don't
group together the writes if there are other handles in the prepare
queue. Afaik that was done because the order we write the handles may
matter, so it is up to the remote stack to make the order proper if it
wants long writes to all be executed in sequence, or interleaved which
means we would have to store new chunks in the order they are
prepared.

> +       if (prep_data && (offset == (prep_data->length + prep_data->offset)))
>                 return append_prep_data(prep_data, handle, length, value);
>
>         return prep_data_new(server, handle, offset, length, value);
> --
> 2.13.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
