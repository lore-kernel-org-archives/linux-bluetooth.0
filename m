Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1305734288-4317-2-git-send-email-dmitriy.paliy@nokia.com>
References: <1305734288-4317-1-git-send-email-dmitriy.paliy@nokia.com>
	<1305734288-4317-2-git-send-email-dmitriy.paliy@nokia.com>
Date: Thu, 19 May 2011 10:29:19 +0300
Message-ID: <BANLkTindbaG7F0Rp2PJ5g_EbR0QCJq6-pQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Fix numbers GSlist to be used in new missed calls
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, May 18, 2011 at 6:58 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> It is possible that phonebook_pull_read is invoked several times
> submitting multiple pull requests without closing PBAP object. E.g. when
> maxlistcount value is small and size of call history is large enough.
>
> The result is possibility of different data structures (gstring and
> contact_data) to be mixed in a single GSlist that may lead to undefined
> behaviour.
> ---
>  plugins/phonebook-tracker.c |   17 ++++++++++++-----
>  1 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index 9c60ec3..52ed31b 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -948,6 +948,7 @@ struct phonebook_data {
>        gboolean vcardentry;
>        const struct apparam_field *params;
>        GSList *contacts;
> +       GSList *numbers;
>        phonebook_cache_ready_cb ready_cb;
>        phonebook_entry_cb entry_cb;
>        int newmissedcalls;
> @@ -1923,6 +1924,13 @@ static void gstring_free_helper(gpointer data, gpointer user_data)
>        g_string_free(data, TRUE);
>  }
>
> +static void free_data_numbers(struct phonebook_data *data)
> +{
> +       g_slist_foreach(data->numbers, gstring_free_helper, NULL);
> +       g_slist_free(data->numbers);
> +       data->numbers = NULL;
> +}
> +
>  static int pull_newmissedcalls(const char **reply, int num_fields,
>                                                        void *user_data)
>  {
> @@ -1934,12 +1942,12 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
>        if (num_fields < 0 || reply == NULL)
>                goto done;
>
> -       if (!find_checked_number(data->contacts, reply[1])) {
> +       if (!find_checked_number(data->numbers, reply[1])) {
>                if (g_strcmp0(reply[2], "false") == 0)
>                        data->newmissedcalls++;
>                else {
>                        GString *number = g_string_new(reply[1]);
> -                       data->contacts = g_slist_append(data->contacts,
> +                       data->numbers = g_slist_append(data->numbers,
>                                                                number);
>                }
>        }
> @@ -1947,9 +1955,7 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
>
>  done:
>        DBG("newmissedcalls %d", data->newmissedcalls);
> -       g_slist_foreach(data->contacts, gstring_free_helper, NULL);
> -       g_slist_free(data->contacts);
> -       data->contacts = NULL;
> +       free_data_numbers(data);
>
>        if (num_fields < 0) {
>                data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
> @@ -1991,6 +1997,7 @@ void phonebook_req_finalize(void *request)
>                g_object_unref(data->query_canc);
>        }
>
> +       free_data_numbers(data);
>        free_data_contacts(data);
>        g_free(data->req_name);
>        g_free(data);
> --
> 1.7.4.1

Looks much better, ack.


-- 
Luiz Augusto von Dentz
Computer Engineer
