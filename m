Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Nov 2010 19:10:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix pull phonebook with non-zero offset parameter
Message-ID: <20101112171043.GA13442@jh-x301>
References: <1289558357-25724-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289558357-25724-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Fri, Nov 12, 2010, Rafal Michalski wrote:
> For non-zero liststartoffset parameter, contacts which index was before
> offset were indexed more than once (e.g. when contact had more than one
> phone number or address etc.), so pulling was started earlier - before
> offset index was reached. This patch fix this problem and each contact
> is indexed only once.
> ---
>  plugins/phonebook-tracker.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)

Several issues with this patch:

> @@ -1361,6 +1361,7 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
>  	int last_index, i;
>  	gboolean cdata_present = FALSE;
>  	char *home_addr, *work_addr, *other_addr;
> +	static gchar *temp_id;

Use char instead of gchar and initialize this to NULL here (static
variabled get initialized to 0 implicitly, but it's good to have this
explicit for clarity imo).

> +	if (data->index == 0)
> +		temp_id = NULL;

Is this supposed to compensate for the lack of initialization upon
declaration or do you really want to set to NULL here in case some
previous calls to the function left it as non-NULL. In the later case
you're missing a g_free call.

> @@ -1495,6 +1503,7 @@ done:
>  fail:
>  	g_slist_free(data->contacts);
>  	g_free(data);
> +	g_free(temp_id);
>  }

Since this is a static variable you don't want it keeping it's value
after freeing it. So set to NULL after the g_free.

Btw, doesn't it bother you at all that this pull_contacts function is
huge? Feel free to send a refactoring patch for it. E.g. separate
functions called add_entry and add_numbers might not be a bad idea. The
function is also inconsistent in the usage of column numbers: sometimes
a define is used and sometimes a hard coded number.

Johan
