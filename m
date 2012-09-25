Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347892917-13013-1-git-send-email-sunil.behera@samsung.com>
References: <1347892917-13013-1-git-send-email-sunil.behera@samsung.com>
Date: Tue, 25 Sep 2012 11:22:16 +0300
Message-ID: <CABBYNZKde0LyRh9Adxu1UoA6MXSqZ4tyhP3qK22S9NF457-Kfw@mail.gmail.com>
Subject: Re: [PATCH obexd] MAP: Add Notification Registration support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

On Mon, Sep 17, 2012 at 5:41 PM, Sunil Kumar Behera
<sunil.behera@samsung.com> wrote:
> This feature allows the MCE to set the notification mode
> on the MSE side.
> ---
>  plugins/mas.c              |   50 ++++++++++++++++++++++++++++++++++++++++++--
>  plugins/messages-dummy.c   |    6 ++----
>  plugins/messages-tracker.c |    6 ++----
>  plugins/messages.h         |   17 +++++++--------
>  4 files changed, 60 insertions(+), 19 deletions(-)
>
> diff --git a/plugins/mas.c b/plugins/mas.c
> index 186d267..977e5a1 100644
> --- a/plugins/mas.c
> +++ b/plugins/mas.c
> @@ -119,6 +119,8 @@ struct mas_session {
>         GObexApparam *inparams;
>         GObexApparam *outparams;
>         gboolean ap_sent;
> +       uint8_t notification_status;
> +       char *remote_addr;
>  };
>
>  static const uint8_t MAS_TARGET[TARGET_SIZE] = {
> @@ -167,12 +169,14 @@ static void reset_request(struct mas_session *mas)
>  static void mas_clean(struct mas_session *mas)
>  {
>         reset_request(mas);
> +       g_free(mas->remote_addr);
>         g_free(mas);
>  }
>
>  static void *mas_connect(struct obex_session *os, int *err)
>  {
>         struct mas_session *mas;
> +       char *address;
>
>         DBG("");
>
> @@ -184,6 +188,9 @@ static void *mas_connect(struct obex_session *os, int *err)
>
>         manager_register_session(os);
>
> +       if (obex_getpeername(os, &address) == 0)
> +               mas->remote_addr = address;
> +
>         return mas;
>
>  failed:
> @@ -695,6 +702,45 @@ static void *message_set_status_open(const char *name, int oflag, mode_t mode,
>         return mas;
>  }
>
> +static void *notification_registration_open(const char *name, int oflag,
> +                                               mode_t mode, void *driver_data,
> +                                               size_t *size, int *err)
> +{
> +       struct mas_session *mas = driver_data;
> +       uint8_t status;
> +
> +       if (oflag == O_RDONLY) {
> +               *err = -EBADR;
> +               return NULL;
> +       }
> +
> +       if (!g_obex_apparam_get_uint8(mas->inparams, MAP_AP_NOTIFICATIONSTATUS,
> +                                                               &status)) {
> +               *err = -EBADR;
> +               return NULL;
> +       }
> +
> +       *err = 0;
> +       mas->notification_status = status;
> +       mas->finished = TRUE;
> +       return mas;
> +}
> +
> +static int notification_registration_close(void *obj)
> +{
> +       struct mas_session *mas = obj;
> +
> +       DBG("");
> +
> +       messages_set_notification_registration(mas->backend_data,
> +                                               mas->remote_addr,
> +                                               mas->notification_status, mas);
> +
> +       reset_request(mas);
> +
> +       return 0;
> +}
> +
>  static ssize_t any_get_next_header(void *object, void *buf, size_t mtu,
>                                                                 uint8_t *hi)
>  {
> @@ -820,8 +866,8 @@ static struct obex_mime_type_driver mime_notification_registration = {
>         .target = MAS_TARGET,
>         .target_size = TARGET_SIZE,
>         .mimetype = "x-bt/MAP-NotificationRegistration",
> -       .open = any_open,
> -       .close = any_close,
> +       .open = notification_registration_open,
> +       .close = notification_registration_close,
>         .read = any_read,
>         .write = any_write,
>  };
> diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
> index 4c66f51..ecbe894 100644
> --- a/plugins/messages-dummy.c
> +++ b/plugins/messages-dummy.c
> @@ -251,10 +251,8 @@ void messages_disconnect(void *s)
>         g_free(session);
>  }
>
> -int messages_set_notification_registration(void *session,
> -               void (*send_event)(void *session,
> -                       const struct messages_event *event, void *user_data),
> -               void *user_data)
> +int messages_set_notification_registration(void *session, char *address,
> +                                               uint8_t status, void *user_data)
>  {
>         return -ENOSYS;
>  }
> diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
> index 2c7541b..aa62870 100644
> --- a/plugins/messages-tracker.c
> +++ b/plugins/messages-tracker.c
> @@ -180,10 +180,8 @@ void messages_disconnect(void *s)
>         g_free(session);
>  }
>
> -int messages_set_notification_registration(void *session,
> -               void (*send_event)(void *session,
> -                       const struct messages_event *event, void *user_data),
> -               void *user_data)
> +int messages_set_notification_registration(void *session, char *address,
> +                                               uint8_t status, void *user_data)
>  {
>         return -ENOSYS;
>  }
> diff --git a/plugins/messages.h b/plugins/messages.h
> index 00a16b1..0fe5cc3 100644
> --- a/plugins/messages.h
> +++ b/plugins/messages.h
> @@ -169,18 +169,17 @@ void messages_disconnect(void *session);
>   * value is used to set the error code in OBEX response.
>   ******************************************************************************/
>
> -/* Registers for messaging events notifications.
> +/* Registers Message Client for receiving message event reports.
>   *
>   * session: Backend session.
> - * send_event: Function that will be called to indicate a new event.
> - *
> - * To unregister currently registered notifications, call this with send_event
> - * set to NULL.
> + * address: Remote device address that request notification registration.
> + * status: To indicate message notification registraton status
> + * user_data: User data if any to be sent.
>   */
> -int messages_set_notification_registration(void *session,
> -               void (*send_event)(void *session,
> -                       const struct messages_event *event, void *user_data),
> -               void *user_data);
> +
> +int messages_set_notification_registration(void *session, char *address,
> +                                               uint8_t status,
> +                                               void *user_data);
>
>  /* Changes current directory.
>   *
> --
> 1.7.9.5


The plan is to merge client with server so we don't have to call each
other daemon to connect the notification service.


-- 
Luiz Augusto von Dentz
