Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346239086-29543-1-git-send-email-sunil.behera@samsung.com>
References: <1346239086-29543-1-git-send-email-sunil.behera@samsung.com>
Date: Thu, 6 Sep 2012 17:51:17 +0300
Message-ID: <CABBYNZJ15tr-KNsLs0cpH=6eT+cmJ0m21XE7cacJAQs3HPWZXg@mail.gmail.com>
Subject: Re: [PATCH obexd] MAP: Add SetMessageStatus function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

On Wed, Aug 29, 2012 at 2:18 PM, Sunil Kumar Behera
<sunil.behera@samsung.com> wrote:
> SetMessageStatus function allows the MCE to modify the status
> of a message on the MSE. This function modifies the read and
> delete status of the message.
> ---
>  plugins/mas.c              |   52 +++++++++++++++++++++++++++++++++++++++++++-
>  plugins/messages-dummy.c   |    8 +++++++
>  plugins/messages-tracker.c |    8 +++++++
>  plugins/messages.h         |   20 +++++++++++++++++
>  4 files changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/mas.c b/plugins/mas.c
> index 1c9199d..26e8f7d 100644
> --- a/plugins/mas.c
> +++ b/plugins/mas.c
> @@ -499,6 +499,20 @@ static void update_inbox_cb(void *session, int err, void *user_data)
>                 obex_object_set_io_flags(mas, G_IO_OUT, 0);
>  }
>
> +static void message_status_cb(void *session, int err, void *user_data)
> +{
> +       struct mas_session *mas = user_data;
> +
> +       DBG("");
> +
> +       mas->finished = TRUE;
> +
> +       if (err < 0)
> +               obex_object_set_io_flags(mas, G_IO_ERR, err);
> +       else
> +               obex_object_set_io_flags(mas, G_IO_OUT, 0);
> +}
> +
>  static int mas_setpath(struct obex_session *os, void *user_data)
>  {
>         const char *name;
> @@ -649,6 +663,42 @@ static void *message_update_open(const char *name, int oflag, mode_t mode,
>                 return mas;
>  }
>
> +static void *message_status_open(const char *name, int oflag, mode_t mode,
> +                                       void *driver_data, size_t *size,
> +                                       int *err)
> +
> +{
> +       struct mas_session *mas = driver_data;
> +       uint8_t indicator;
> +       uint8_t value;
> +
> +       DBG("");
> +
> +       if (oflag == O_RDONLY) {
> +               *err = -EBADR;
> +               return NULL;
> +       }
> +
> +       if (!g_obex_apparam_get_uint8(mas->inparams, MAP_AP_STATUSINDICATOR,
> +                               &indicator)) {
> +               *err = -EBADR;
> +               return NULL;
> +       }
> +
> +       if (!g_obex_apparam_get_uint8(mas->inparams, MAP_AP_STATUSVALUE,
> +                               &value)) {
> +               *err = -EBADR;
> +               return NULL;
> +       }
> +
> +       *err = messages_set_message_status(mas->backend_data, name, indicator,
> +                                               value, message_status_cb, mas);
> +       if (*err < 0)
> +               return NULL;
> +       else
> +               return mas;

No need for else statement if you are returning on if statement already.

> +}
> +
>  static ssize_t any_get_next_header(void *object, void *buf, size_t mtu,
>                                                                 uint8_t *hi)
>  {
> @@ -784,7 +834,7 @@ static struct obex_mime_type_driver mime_message_status = {
>         .target = MAS_TARGET,
>         .target_size = TARGET_SIZE,
>         .mimetype = "x-bt/messageStatus",
> -       .open = any_open,
> +       .open = message_status_open,
>         .close = any_close,
>         .read = any_read,
>         .write = any_write,
> diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
> index a47f143..1a38d0d 100644
> --- a/plugins/messages-dummy.c
> +++ b/plugins/messages-dummy.c
> @@ -347,6 +347,14 @@ int messages_get_message(void *session, const char *handle,
>         return -ENOSYS;
>  }
>
> +int messages_set_message_status(void *session, const char *handle,
> +                                       int indicator, int value,
> +                                       messages_set_message_status_cb callback,
> +                                       void *user_data)
> +{
> +       return -ENOSYS;
> +}
> +
>  int messages_update_inbox(void *session, messages_update_inbox_cb callback,
>                                                         void *user_data)
>  {
> diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
> index 92c1767..7bdba1b 100644
> --- a/plugins/messages-tracker.c
> +++ b/plugins/messages-tracker.c
> @@ -321,6 +321,14 @@ int messages_get_message(void *session, const char *handle,
>         return -ENOSYS;
>  }
>
> +int messages_set_message_status(void *session, const char *handle,
> +                               int indicator, int value,
> +                               messages_set_message_status_cb callback,
> +                               void *user_data)
> +{
> +       return -ENOSYS;
> +}
> +
>  int messages_update_inbox(void *session, messages_update_inbox_cb callback,
>                                                         void *user_data)
>  {
> diff --git a/plugins/messages.h b/plugins/messages.h
> index 669f7c2..9805bb0 100644
> --- a/plugins/messages.h
> +++ b/plugins/messages.h
> @@ -268,6 +268,26 @@ int messages_get_message(void *session, const char *handle,
>                                         messages_get_message_cb callback,
>                                         void *user_data);
>
> +/* Informs Message Server to modify status of a given message.
> + *
> + * session: Backend session.
> + * handle: Unique identifier to the message.
> + * indicator: To indicate which status information is to be modified,
> + *     "readStatus" or "deleteStatus".
> + * value: To indicate the value of the indicator
> + *     read/unread for "readstatus" and deleted/undeleted for "deleteStatus".
> + * Callback shall be called for every message status update request
> + *     recieved from MCE.
> + * user_data: User data if any to be sent.
> + */
> +typedef void (*messages_set_message_status_cb)(void *session, int err,
> +                                       void *user_data);
> +
> +int messages_set_message_status(void *session, const char *handle,
> +                                       int indicator, int value,
> +                                       messages_set_message_status_cb callback,
> +                                       void *user_data);
> +

The indicator and value types seems wrong, it should be uint8_t, but
perhaps we should have dedicated functions for each of the indicators,
set_read_status/set_delete_status, so the backend don't have to decode
the indicators themselves. What do you think?



-- 
Luiz Augusto von Dentz
