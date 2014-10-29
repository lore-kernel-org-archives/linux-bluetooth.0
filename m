Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414497544-24344-1-git-send-email-bharat.panda@samsung.com>
References: <1414497544-24344-1-git-send-email-bharat.panda@samsung.com>
Date: Wed, 29 Oct 2014 14:17:19 +0200
Message-ID: <CABBYNZ++X33-OctahrbhzV8OpgcQWMoGqhX1Zr89yH6j2Ni9Hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] obexd/mas: Handle Register Notification close
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 28, 2014 at 1:59 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Changes made to handle close method for mime_notification_registration
> ---
>  obexd/plugins/mas.c            | 19 ++++++++++++++++++-
>  obexd/plugins/messages-dummy.c | 20 +++++++++++++++++++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> index 08d6ce7..20937de 100644
> --- a/obexd/plugins/mas.c
> +++ b/obexd/plugins/mas.c
> @@ -793,6 +793,23 @@ static void *notification_registration_open(const char *name, int oflag,
>         return mas;
>  }
>
> +static int notification_registration_close(void *obj)
> +{
> +       struct mas_session *mas = obj;
> +
> +       DBG("");
> +
> +       if (!mas->finished)
> +               messages_abort(mas->backend_data);
> +
> +       messages_set_notification_registration(mas->backend_data,
> +                       NULL, &(mas->notification_status));

You probably want to pass the value itself with GUINT_TO_POINTER, etc.
The last parameter of messages_set_notification_registration is
probably useless, what you really want to do is to enable/disable the
notification by setting send_event.

> +       reset_request(mas);
> +
> +       return 0;
> +}
> +
>  static struct obex_service_driver mas = {
>         .name = "Message Access server",
>         .service = OBEX_MAS,
> @@ -852,7 +869,7 @@ static struct obex_mime_type_driver mime_notification_registration = {
>         .target_size = TARGET_SIZE,
>         .mimetype = "x-bt/MAP-NotificationRegistration",
>         .open = notification_registration_open,
> -       .close = any_close,
> +       .close = notification_registration_close,
>         .read = any_read,
>         .write = any_write,
>  };
> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
> index bb0627f..579e85d 100644
> --- a/obexd/plugins/messages-dummy.c
> +++ b/obexd/plugins/messages-dummy.c
> @@ -52,6 +52,8 @@ struct folder_listing_data {
>         void *user_data;
>  };
>
> +uint8_t notification_status;
> +
>  /* NOTE: Neither IrOBEX nor MAP specs says that folder listing needs to
>   * be sorted (in IrOBEX examples it is not). However existing implementations
>   * seem to follow the fig. 3-2 from MAP specification v1.0, and I've seen a
> @@ -251,12 +253,28 @@ void messages_disconnect(void *s)
>         g_free(session);
>  }
>
> +static gboolean register_notification(gpointer user_data)
> +{
> +       DBG("");
> +       /* TODO: Send notification registration status to DBus
> +        * application.
> +        */
> +
> +       return FALSE;
> +}
> +
>  int messages_set_notification_registration(void *session,
>                 void (*send_event)(void *session,
>                         const struct messages_event *event, void *user_data),
>                 void *user_data)
>  {
> -       return -ENOSYS;
> +       DBG("");
> +
> +       notification_status = *(uint8_t *)user_data;
> +
> +       g_idle_add(register_notification, &notification_status);
> +
> +       return 1;

If we are not gonna do anything useful with it here we should just
keep returning -ENOSYS, otherwise you need to start using send_event
if any file change, perhaps with inotify, so you can simulate a real
backend.

>  }
>
>  int messages_set_folder(void *s, const char *name, gboolean cdup)
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
