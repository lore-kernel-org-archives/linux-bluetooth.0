Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170526085837.14705-1-luiz.dentz@gmail.com>
References: <20170526085837.14705-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 May 2017 16:15:10 +0300
Message-ID: <CABBYNZL+o9GmWykziW7yGRrVvv_vJZCPwXj2NR3qFuhiUwZ_1A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/gatt: Don't return an error if notification is
 already enabled
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 26, 2017 at 11:58 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In case the client is already subscribed and attempt to register again
> just return success as the handling should be the same as success.
> ---
>  src/gatt-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index b86bfe6..6c67841 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1173,7 +1173,7 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
>         client = queue_find(chrc->notify_clients, match_notify_sender, sender);
>         if (client)
>                 return client->notify_id ?
> -                               btd_error_failed(msg, "Already notifying") :
> +                               g_dbus_create_reply(msg, DBUS_TYPE_INVALID) :
>                                 btd_error_in_progress(msg);
>
>         client = notify_client_create(chrc, sender);
> --
> 2.9.4

Applied.


-- 
Luiz Augusto von Dentz
