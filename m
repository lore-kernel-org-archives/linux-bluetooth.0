Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414497485-24300-1-git-send-email-bharat.panda@samsung.com>
References: <1414497485-24300-1-git-send-email-bharat.panda@samsung.com>
Date: Wed, 29 Oct 2014 14:02:36 +0200
Message-ID: <CABBYNZK2zKXW-HChKB3B-1JwK0j4x0xZb+BTBfKys3KOt5gWsA@mail.gmail.com>
Subject: Re: [PATCH ] obexd/mas: Handle register notification open
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 28, 2014 at 1:58 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Changes made to handle method open for mime_notification_registration
> ---
>  obexd/plugins/mas.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> index db40509..08d6ce7 100644
> --- a/obexd/plugins/mas.c
> +++ b/obexd/plugins/mas.c
> @@ -72,6 +72,7 @@ struct mas_session {
>         GObexApparam *inparams;
>         GObexApparam *outparams;
>         gboolean ap_sent;
> +       int notification_status;
>  };
>
>  static const uint8_t MAS_TARGET[TARGET_SIZE] = {
> @@ -766,6 +767,32 @@ static int any_close(void *obj)
>         return 0;
>  }
>
> +static void *notification_registration_open(const char *name, int oflag,
> +                       mode_t mode, void *driver_data, size_t *size, int *err)
> +{
> +       struct mas_session *mas = driver_data;
> +       uint8_t status;
> +
> +       DBG("");
> +
> +       if (O_RDONLY) {
> +               *err = -EBADR;
> +               return NULL;
> +       }
> +
> +       if (!g_obex_apparam_get_uint8(mas->inparams, MAP_AP_NOTIFICATIONSTATUS,
> +                               &status)) {

The line above is not aligned according to out coding style.

> +               *err = -EBADR;
> +               return NULL;
> +       }
> +
> +       mas->notification_status = status;

Please use uint8_t for notification_status if that is the value it can assume.

> +       mas->finished = TRUE;
> +       *err = 0;
> +
> +       return mas;
> +}
> +
>  static struct obex_service_driver mas = {
>         .name = "Message Access server",
>         .service = OBEX_MAS,
> @@ -824,7 +851,7 @@ static struct obex_mime_type_driver mime_notification_registration = {
>         .target = MAS_TARGET,
>         .target_size = TARGET_SIZE,
>         .mimetype = "x-bt/MAP-NotificationRegistration",
> -       .open = any_open,
> +       .open = notification_registration_open,
>         .close = any_close,
>         .read = any_read,
>         .write = any_write,
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
