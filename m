Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1442584177-17918-1-git-send-email-luiz.dentz@gmail.com>
References: <1442584177-17918-1-git-send-email-luiz.dentz@gmail.com>
Date: Sat, 19 Sep 2015 14:33:32 +0300
Message-ID: <CABBYNZKGKk0mjNEqUSMe0Oh__Z-3CbVjv+Mz2_NmhX3+epgH=Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/gatt-client: Fix WriteValue always failing
 after first request
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 18, 2015 at 4:49 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> WriteValue may use write without response proceduce in case it is
> supported but since that don't have any response write_id is left set
> after first request preventing blocking any new request.
> ---
>  src/gatt-client.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 399133a..6c10a82 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -946,11 +946,11 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                 goto fail;
>
>         supported = true;
> -       chrc->write_id = bt_gatt_client_write_without_response(gatt,
> +
> +       if (bt_gatt_client_write_without_response(gatt,
>                                         chrc->value_handle,
>                                         chrc->props & BT_GATT_CHRC_PROP_AUTH,
> -                                       value, value_len);
> -       if (chrc->write_id)
> +                                       value, value_len))
>                 return dbus_message_new_method_return(msg);
>
>  fail:
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
