Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1305734288-4317-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1305734288-4317-1-git-send-email-dmitriy.paliy@nokia.com>
Date: Thu, 19 May 2011 10:27:43 +0300
Message-ID: <BANLkTin6Lzdb8dESq7Oz8djhar9wc6VPdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Move phonebook_req_finalize
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, May 18, 2011 at 6:58 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> It is used in successive patch.
> ---
>  plugins/phonebook-tracker.c |   40 ++++++++++++++++++++--------------------
>  1 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index 9431d8a..9c60ec3 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -1905,26 +1905,6 @@ done:
>        return path;
>  }
>
> -void phonebook_req_finalize(void *request)
> -{
> -       struct phonebook_data *data = request;
> -
> -       DBG("");
> -
> -       if (!data)
> -               return;
> -
> -       /* canceling asynchronous operation on tracker if any is active */
> -       if (data->query_canc) {
> -               g_cancellable_cancel(data->query_canc);
> -               g_object_unref(data->query_canc);
> -       }
> -
> -       free_data_contacts(data);
> -       g_free(data->req_name);
> -       g_free(data);
> -}
> -
>  static gboolean find_checked_number(GSList *numbers, const char *number)
>  {
>        GSList *l;
> @@ -1996,6 +1976,26 @@ done:
>        return 0;
>  }
>
> +void phonebook_req_finalize(void *request)
> +{
> +       struct phonebook_data *data = request;
> +
> +       DBG("");
> +
> +       if (!data)
> +               return;
> +
> +       /* canceling asynchronous operation on tracker if any is active */
> +       if (data->query_canc) {
> +               g_cancellable_cancel(data->query_canc);
> +               g_object_unref(data->query_canc);
> +       }
> +
> +       free_data_contacts(data);
> +       g_free(data->req_name);
> +       g_free(data);
> +}
> +
>  void *phonebook_pull(const char *name, const struct apparam_field *params,
>                                phonebook_cb cb, void *user_data, int *err)
>  {
> --

It should be fine to have 1 and 2 together, it is less troublesome if
somebody is using git blame to check the history.

-- 
Luiz Augusto von Dentz
Computer Engineer
