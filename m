Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380870086-3663-1-git-send-email-szymon.janc@tieto.com>
References: <1380870086-3663-1-git-send-email-szymon.janc@tieto.com>
Date: Fri, 4 Oct 2013 10:35:27 +0300
Message-ID: <CABBYNZLqSsYLdTzLkzmvvSw99Zm-fPMKZTD4=6kO_-pbkajv4A@mail.gmail.com>
Subject: Re: [PATCH] obexd/MAP: Fix invalid snprintf format string in map_msg_get()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Oct 4, 2013 at 10:01 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> obexd/client/map.c: In function ‘map_msg_get’:
> obexd/client/map.c:446:2: warning: format ‘%u’ expects argument of type
>      ‘unsigned int’, but argument 4 has type ‘uint64_t’ [-Wformat]
> obexd/client/map.c:446:2: warning: format ‘%u’ expects argument of type
>      ‘unsigned int’, but argument 4 has type ‘uint64_t’ [-Wformat]
> ---
>  obexd/client/map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 72c4de4..fe15bab 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -443,7 +443,7 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
>                 return g_dbus_create_error(message,
>                                 ERROR_INTERFACE ".InvalidArguments", NULL);
>
> -       if (snprintf(handle, sizeof(handle), "%u" PRIu64, msg->handle) < 0)
> +       if (snprintf(handle, sizeof(handle), "%" PRIu64, msg->handle) < 0)
>                 goto fail;
>
>         transfer = obc_transfer_get("x-bt/message", handle, target_file, &err);
> --
> 1.8.4

Applied, thanks

-- 
Luiz Augusto von Dentz
