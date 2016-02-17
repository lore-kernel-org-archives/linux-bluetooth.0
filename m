Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
References: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 17 Feb 2016 12:32:12 +0200
Message-ID: <CABBYNZLTehRbB-Un2DuRJy_1uiwk8YeFvZZBJHJANHC7iW2zJQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] shared/gatt-client: Add debug log if
 characteristic cannot be added
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 15, 2016 at 2:30 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If gatt_db_service_insert_characteristic fails print an error for the
> handle.
> ---
>  src/shared/gatt-client.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 20c195a..8486b09 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -588,8 +588,12 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
>                                                         chrc_data->properties,
>                                                         NULL, NULL, NULL);
>
> -               if (!attr)
> +               if (!attr) {
> +                       util_debug(client->debug_callback, client->debug_data,
> +                               "Failed to insert characteristic at 0x%04x",
> +                               chrc_data->value_handle);
>                         goto failed;
> +               }
>
>                 if (gatt_db_attribute_get_handle(attr) !=
>                                                         chrc_data->value_handle)
> --
> 2.5.0

Applied.


-- 
Luiz Augusto von Dentz
