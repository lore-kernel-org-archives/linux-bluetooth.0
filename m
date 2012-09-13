Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347516406-28378-1-git-send-email-sunil.behera@samsung.com>
References: <1347516406-28378-1-git-send-email-sunil.behera@samsung.com>
Date: Thu, 13 Sep 2012 11:37:54 +0300
Message-ID: <CABBYNZJXksoxNvjqWyFjwj9wSLQ2q4x4w5U+6CH74hQRCCLKJw@mail.gmail.com>
Subject: Re: [PATCH obexd 2/3] MAP: Add set read status function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

On Thu, Sep 13, 2012 at 9:06 AM, Sunil Kumar Behera
<sunil.behera@samsung.com> wrote:
> This function will inform MAP server to modify the
> read status of a given message.
> ---
>  plugins/mas.c              |   25 +++++++++++++++++++++++++
>  plugins/messages-dummy.c   |    8 ++++++++
>  plugins/messages-tracker.c |    8 ++++++++
>  plugins/messages.h         |   17 +++++++++++++++++
>  4 files changed, 58 insertions(+)
>
> diff --git a/plugins/mas.c b/plugins/mas.c
> index f2ff9e6..182dc6b 100644
> --- a/plugins/mas.c
> +++ b/plugins/mas.c
> @@ -46,6 +46,8 @@
>
>  #include "messages.h"
>
> +#define READ_STATUS_REQ 0
> +
>  /* Channel number according to bluez doc/assigned-numbers.txt */
>  #define MAS_CHANNEL    16
>
> @@ -499,6 +501,20 @@ static void update_inbox_cb(void *session, int err, void *user_data)
>                 obex_object_set_io_flags(mas, G_IO_OUT, 0);
>  }
>
> +static void set_read_status_cb(void *session, int err, void *user_data)
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
> @@ -677,6 +693,15 @@ static void *message_set_status_open(const char *name, int oflag, mode_t mode,
>                 return NULL;
>         }
>
> +       if (indicator == READ_STATUS_REQ)
> +               *err = messages_set_read_status(mas->backend_data, name,
> +                                       value, set_read_status_cb, mas);
> +       else
> +               *err = -EBADR;
> +
> +       if (*err < 0)
> +               return NULL;
> +
>         return mas;
>  }
>
> diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
> index a47f143..627f87a 100644
> --- a/plugins/messages-dummy.c
> +++ b/plugins/messages-dummy.c
> @@ -353,6 +353,14 @@ int messages_update_inbox(void *session, messages_update_inbox_cb callback,
>         return -ENOSYS;
>  }
>
> +int messages_set_read_status(void *session, const char *handle,
> +                                       uint8_t value,
> +                                       messages_set_read_status_cb callback,
> +                                       void *user_data)
> +{
> +       return -ENOSYS;
> +}
> +
>  void messages_abort(void *s)
>  {
>         struct session *session = s;
> diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
> index 92c1767..13c113e 100644
> --- a/plugins/messages-tracker.c
> +++ b/plugins/messages-tracker.c
> @@ -327,6 +327,14 @@ int messages_update_inbox(void *session, messages_update_inbox_cb callback,
>         return -ENOSYS;
>  }
>
> +int messages_set_read_status(void *session, const char *handle,
> +                                       uint8_t value,
> +                                       messages_set_read_status_cb callback,
> +                                       void *user_data)
> +{
> +       return -ENOSYS;
> +}
> +
>  void messages_abort(void *session)
>  {
>  }
> diff --git a/plugins/messages.h b/plugins/messages.h
> index 669f7c2..02d4f37 100644
> --- a/plugins/messages.h
> +++ b/plugins/messages.h
> @@ -280,6 +280,23 @@ typedef void (*messages_update_inbox_cb)(void *session, int err,
>  int messages_update_inbox(void *session, messages_update_inbox_cb callback,
>                                                         void *user_data);
>
> +/* Informs Message Server to modify read status of a given message.
> + *
> + * session: Backend session.
> + * handle: Unique identifier to the message.
> + * value: Indicates the new value of the read status for a given message.
> + * Callback shall be called for every read status update request
> + *     recieved from MCE.
> + * user_data: User data if any to be sent.
> + */
> +typedef void (*messages_set_read_status_cb)(void *session, int err,
> +               void *user_data);
> +
> +int messages_set_read_status(void *session, const char *handle,
> +                                       uint8_t value,
> +                                       messages_set_read_status_cb callback,
> +                                       void *user_data);

We can simplify here and just name this function messages_set_read and
messages_set_read_cb for the callbackl. Also I noticed that you are
not aligning to the right when you need to split due to 80 columns,
can you fix that as well?


-- 
Luiz Augusto von Dentz
