Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 14:49:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] Fix fetching non-empty single owner vCard
Message-ID: <20110126124907.GB11799@jh-x301>
References: <1296045187-28072-1-git-send-email-michalski.raf@gmail.com>
 <1296045187-28072-2-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296045187-28072-2-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Jan 26, 2011, Rafal Michalski wrote:
> Previously only empty owner vCard fetching was handled.
> This patch makes that fetching empty (by default) and non-empty
> (filled somehow by the user) single owner vCard is handled.
> ---
>  plugins/phonebook-tracker.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Still one coding style issue here:

> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index 4e37f1c..353b5cb 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -1922,7 +1922,8 @@ void *phonebook_get_entry(const char *folder, const char *id,
>  	data->cb = cb;
>  	data->vcardentry = TRUE;
>  
> -	if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0)
> +	if (g_str_has_prefix(id, CONTACT_ID_PREFIX) == TRUE ||
> +		g_strcmp0(id, TRACKER_DEFAULT_CONTACT_ME) == 0)
>  		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
>  					id, id, id, id, id, id, id, id, id);

The split second line of the if-statment should be indented by at least
two tabs so that it's distinguishable from the rest of the code. Please
send a v3.

Johan
