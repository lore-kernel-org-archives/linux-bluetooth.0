Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Sep 2012 10:49:41 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 09/17] heartrate: Enable measurement when watchers are
 registered
Message-ID: <20120905134941.GB11695@samus>
References: <1346850348-21176-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1346850348-21176-10-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346850348-21176-10-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 15:05 Wed 05 Sep, Andrzej Kaczmarek wrote:
> This patch will enable measurement notification when first watcher is
> registered or when device is connected and watcher is already registered.
> 
> Measurement will be disabled when last watcher is unregistered.
> 
> ---
>  profiles/heartrate/heartrate.c | 129 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 128 insertions(+), 1 deletion(-)
> 
> diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
> index a223fe0..5464a9f 100644
> --- a/profiles/heartrate/heartrate.c
> +++ b/profiles/heartrate/heartrate.c
> @@ -101,6 +101,22 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
>  	return -1;
>  }
>  
> +static gint cmp_char_uuid(gconstpointer a, gconstpointer b)
> +{
> +	const struct characteristic *ch = a;
> +	const char *uuid = b;
> +
> +	return g_strcmp0(ch->attr.uuid, uuid);
> +}
> +
> +static gint cmp_descriptor(gconstpointer a, gconstpointer b)
> +{
> +	const struct descriptor *desc = a;
> +	const bt_uuid_t *uuid = b;
> +
> +	return bt_uuid_cmp(&desc->uuid, uuid);
> +}
> +
>  static gint cmp_watcher(gconstpointer a, gconstpointer b)
>  {
>  	const struct watcher *watcher = a;
> @@ -181,6 +197,91 @@ static void destroy_heartrate_adapter(gpointer user_data)
>  	g_free(hra);
>  }
>  
> +static struct characteristic *
> +get_characteristic(struct heartrate *hr, const char *uuid)

Nitpick: I think it is possible to break the line after the first parameter.

> +{
> +	GSList *l;
> +
> +	l = g_slist_find_custom(hr->chars, uuid, cmp_char_uuid);
> +	if (l == NULL)
> +		return NULL;
> +
> +	return l->data;
> +}
> +

Cheers,
-- 
Vinicius
