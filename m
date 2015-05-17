Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 May 2015 10:31:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] adapter: Fix memory leak
Message-ID: <20150517073124.GA27593@t440s.P-661HNU-F1>
References: <1431700064-21419-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431700064-21419-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, May 15, 2015, Andrei Emeltchenko wrote:
> In case of error with dbus stuff free allocated memory and set filter
> to NULL.
> ---
>  src/adapter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 8ee5b5b..7035a69 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2219,8 +2219,11 @@ static bool parse_discovery_filter_dict(struct discovery_filter **filter,
>  
>  	dbus_message_iter_init(msg, &iter);
>  	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
> -	    dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_DICT_ENTRY)
> +	    dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_DICT_ENTRY) {
> +		g_free(*filter);
> +		*filter = NULL;
>  		return false;
> +	}

Good catch, but I think 'goto invalid_args;' would be a cleaner thing to
do. The extra g_slise_free_full call is fine since NULL is the same as
an empty list.

Johan
