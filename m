Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1296039665-3948-2-git-send-email-michalski.raf@gmail.com>
References: <1296039665-3948-1-git-send-email-michalski.raf@gmail.com>
	<1296039665-3948-2-git-send-email-michalski.raf@gmail.com>
Date: Wed, 26 Jan 2011 13:19:43 +0200
Message-ID: <AANLkTik4Rt-XPkiaFucaVp1aEQsgs6ND0WQzi7J-Pn+M@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fix fetching non-empty single owner vCard
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 26, 2011 at 1:01 PM, Rafal Michalski
<michalski.raf@gmail.com> wrote:
> Previously only empty owner vCard fetching was handled.
> This patch makes that fetching empty (by default) and non-empty
> (filled somehow by the user) single owner vCard is handled.
> ---
>  plugins/phonebook-tracker.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index aee159c..8fe8ade 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -1922,7 +1922,9 @@ void *phonebook_get_entry(const char *folder, const char *id,
>        data->cb = cb;
>        data->vcardentry = TRUE;
>
> -       if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0)
> +       if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0 ||
> +               strncmp(id, TRACKER_DEFAULT_CONTACT_ME,
> +               strlen(TRACKER_DEFAULT_CONTACT_ME)) == 0)
>                query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
>                                                id, id, id, id, id, id, id, id,
>                                                id, id);

The strncmp combine with strlen looks like it could be replaced by
g_str_has_prefix, also the code that you are adding it probably need
to be a full match not just the prefix than use g_strcmp0 otherwise
g_str_has_prefix can probably be used there too.

-- 
Luiz Augusto von Dentz
Computer Engineer
