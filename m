Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352372667-18288-1-git-send-email-sunil.behera@samsung.com>
References: <1352372667-18288-1-git-send-email-sunil.behera@samsung.com>
Date: Fri, 9 Nov 2012 12:03:34 +0200
Message-ID: <CABBYNZ+K+R_i6ofgCP9rgsOPP2rBVk_9RKG=Q1v4BVRO_RCRCw@mail.gmail.com>
Subject: Re: [PATCH obexd v1 2/3] MAP: Add MSETime application parameter
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

On Thu, Nov 8, 2012 at 1:04 PM, Sunil Kumar Behera
<sunil.behera@samsung.com> wrote:
> MSETime application parameter shall be used in the response
> to report the Local Time basis of the MSE.
> ---
>  plugins/mas.c      |    4 +++-
>  plugins/messages.h |    1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/mas.c b/plugins/mas.c
> index 319c87f..bdf2b6b 100644
> --- a/plugins/mas.c
> +++ b/plugins/mas.c
> @@ -284,7 +284,7 @@ static const char *yesorno(gboolean a)
>  }
>
>  static void get_messages_listing_cb(void *session, int err, uint16_t size,
> -                                       gboolean newmsg,
> +                                       gboolean newmsg, gchar *msetime,
>                                         const struct messages_message *entry,
>                                         void *user_data)
>  {
> @@ -403,6 +403,8 @@ proceed:
>                 mas->outparams = g_obex_apparam_set_uint8(mas->outparams,
>                                                 MAP_AP_NEWMESSAGE,
>                                                 newmsg ? 1 : 0);
> +               mas->outparams = g_obex_apparam_set_string(mas->outparams,
> +                                               MAP_AP_MSETIME, msetime);
>         }
>
>         if (err != -EAGAIN)
> diff --git a/plugins/messages.h b/plugins/messages.h
> index 00a16b1..2ab4ba1 100644
> --- a/plugins/messages.h
> +++ b/plugins/messages.h
> @@ -226,6 +226,7 @@ int messages_get_folder_listing(void *session, const char *name, uint16_t max,
>   */
>  typedef void (*messages_get_messages_listing_cb)(void *session, int err,
>                                         uint16_t size, gboolean newmsg,
> +                                       gchar *msetime,
>                                         const struct messages_message *message,
>                                         void *user_data);

Do we really need to do this in the backend? We could possible
generate the timestamp on get_messages_listing_cb and which should
avoid having duplicate code doing the same for each backend.

-- 
Luiz Augusto von Dentz
