Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1454336002-4954-1-git-send-email-luiz.dentz@gmail.com>
References: <1454336002-4954-1-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 7 Feb 2016 18:01:35 +0200
Message-ID: <CABBYNZ+ON=U+gkW1aXPUT4cb+pe+udAwmYSwb9ngO3rYqvM9jQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] shared/gatt-client: Fix not resetting request id
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 1, 2016 at 4:13 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The request id shall be reset to 0 after bt_att_cancel has been called.
> ---
>  src/shared/gatt-client.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 06ac763..5fd0208 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1581,6 +1581,7 @@ static void complete_unregister_notify(void *data)
>          */
>         if (notify_data->att_id) {
>                 bt_att_cancel(notify_data->client->att, notify_data->att_id);
> +               notify_data->att_id = 0;
>                 goto done;
>         }
>
> --
> 2.5.0
>

Pushed.

-- 
Luiz Augusto von Dentz
