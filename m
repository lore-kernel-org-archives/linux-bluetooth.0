Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424716380-13720-1-git-send-email-szymon.janc@tieto.com>
References: <1424716380-13720-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 24 Feb 2015 15:14:15 +0200
Message-ID: <CABBYNZJTWDoKwwfsjjv8oy-rwApVHXpPwccPGBZ_hxZVmcHf7A@mail.gmail.com>
Subject: Re: [PATCH] gdbus: Fix not calling disconnect function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Feb 23, 2015 at 8:33 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> If daemon gets disconnected from D-Bus sender is NULL. Watches that
> was explicitly added with NULL sender (ie disconnected_signal in
> g_dbus_set_disconnect_function) should be called anyway.
> ---
>  gdbus/watch.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index 0d0054c..b60f650 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -523,9 +523,7 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
>         member = dbus_message_get_member(message);
>         dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &arg, DBUS_TYPE_INVALID);
>
> -       /* Sender is always the owner */
> -       if (sender == NULL)
> -               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +       /* If sender != NULL it is always the owner */
>
>         for (current = listeners; current != NULL; current = current->next) {
>                 data = current->data;
> @@ -533,6 +531,9 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
>                 if (connection != data->connection)
>                         continue;
>
> +               if (!sender && data->owner)
> +                       continue;
> +
>                 if (data->owner && g_str_equal(sender, data->owner) == FALSE)
>                         continue;
>
> --
> 1.9.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
