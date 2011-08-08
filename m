Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Aug 2011 11:30:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix memory issues in EDS PBAP
Message-ID: <20110808083043.GA8902@dell>
References: <1312658839-26919-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312658839-26919-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Sat, Aug 06, 2011, Bartosz Szatkowski wrote:
> --- a/plugins/phonebook-ebook.c
> +++ b/plugins/phonebook-ebook.c
> @@ -58,6 +58,7 @@ struct query_context {
>  	unsigned queued_calls;
>  	void *user_data;
>  	GSList *ebooks;
> +	gboolean canceled;
>  };
>  
>  static char *attribute_mask[] = {
> @@ -172,6 +173,9 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
>  		goto done;
>  	}
>  
> +	if (data->canceled)
> +		goto canceled;
> +
>  	DBG("");
>  
>  	/*
> @@ -217,6 +221,9 @@ done:
>  						0, TRUE, data->user_data);
>  
>  		g_string_free(buf, TRUE);
> +
> +canceled:
> +		free_query_context(data);
>  	}
>  }

Here you're jumping from a higher level into a deeper level
if-statement. Please don't do that. If you use goto stay on the same
level, otherwise the code flow & logic become too hard to follow.

> @@ -233,6 +240,9 @@ static void ebook_entry_cb(EBook *book, const GError *gerr,
>  		goto done;
>  	}
>  
> +	if (data->canceled)
> +		goto canceled;
> +
>  	DBG("");
>  
>  	evcard = E_VCARD(contact);
> @@ -255,6 +265,7 @@ done:
>  			data->contacts_cb(NULL, 0, 1, 0, TRUE,
>  						data->user_data);
>  
> +canceled:
>  		free_query_context(data);
>  	}
>  }

Same here.

> @@ -300,6 +311,9 @@ static void cache_cb(EBook *book, const GError *gerr, GList *contacts,
>  		goto done;
>  	}
>  
> +	if (data->canceled)
> +		goto canceled;
> +
>  	DBG("");
>  
>  	for (l = contacts; l; l = g_list_next(l)) {
> @@ -338,15 +352,20 @@ done:
>  	g_list_free_full(contacts, g_object_unref);
>  
>  	data->queued_calls--;
> -	if (data->queued_calls == 0)
> +	if (data->queued_calls == 0) {
>  		data->ready_cb(data->user_data);
> +
> +canceled:
> +		free_query_context(data);
> +	}
>  }

And here.

Johan
