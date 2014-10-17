Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413281882-29686-1-git-send-email-bharat.panda@samsung.com>
References: <1413281882-29686-1-git-send-email-bharat.panda@samsung.com>
Date: Fri, 17 Oct 2014 13:58:24 +0200
Message-ID: <CABBYNZJ5Kq4z67EKhnH9pmL02jkW3begif2=s=qxYH+VeNBSzw@mail.gmail.com>
Subject: Re: [PATCH ] obexd/mas: Add Support fo MSETime filter
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 14, 2014 at 12:18 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Changes made to add support for MSE local time parameter
> along with GetMessageListing response.
> ---
>  obexd/plugins/mas.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> index fb97fe3..7f14bf8 100644
> --- a/obexd/plugins/mas.c
> +++ b/obexd/plugins/mas.c
> @@ -30,6 +30,7 @@
>  #include <glib.h>
>  #include <fcntl.h>
>  #include <inttypes.h>
> +#include <sys/time.h>
>
>  #include <gobex/gobex.h>
>  #include <gobex/gobex-apparam.h>
> @@ -228,6 +229,25 @@ static void g_string_append_escaped_printf(GString *string,
>         va_end(ap);
>  }
>
> +static gchar *get_mse_timestamp(void)
> +{
> +       struct timeval time_val;
> +       struct tm ltime;
> +       gchar *local_ts;
> +
> +       gettimeofday(&time_val, NULL);
> +
> +       if (!localtime_r(&time_val.tv_sec, &ltime))
> +               return NULL;
> +
> +       local_ts = g_strdup_printf("%04d%02d%02dT%02d%02d%02d",
> +                                       ltime.tm_year + 1900, ltime.tm_mon + 1,
> +                                       ltime.tm_mday, ltime.tm_hour,
> +                                       ltime.tm_min, ltime.tm_sec);
> +
> +       return local_ts;
> +}
> +
>  static const char *yesorno(gboolean a)
>  {
>         if (a)
> @@ -243,6 +263,7 @@ static void get_messages_listing_cb(void *session, int err, uint16_t size,
>  {
>         struct mas_session *mas = user_data;
>         uint16_t max = 1024;
> +       gchar *mse_time;
>
>         if (err < 0 && err != -EAGAIN) {
>                 obex_object_set_io_flags(mas, G_IO_ERR, err);
> @@ -358,6 +379,13 @@ proceed:
>                 mas->outparams = g_obex_apparam_set_uint8(mas->outparams,
>                                                 MAP_AP_NEWMESSAGE,
>                                                 newmsg ? 1 : 0);
> +               /* Response to report the local time of MSE */
> +               mse_time = get_mse_timestamp();
> +               if (mse_time) {
> +                       g_obex_apparam_set_string(mas->outparams,
> +                                               MAP_AP_MSETIME, mse_time);
> +                       g_free(mse_time);
> +               }
>         }
>
>         if (err != -EAGAIN)
> --
> 1.9.1

Does this works when the system has timedated running, perhaps we need
to know if the time is set in UTC or not and in case of the later we
probably need to provide the timezone as well.



-- 
Luiz Augusto von Dentz
