Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 13:56:50 -0800
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Add return value to reply_list_foreach_t in
 phonebook-tracker
Message-ID: <20110209215650.GA11911@jh-x301>
References: <1297081658-30573-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297081658-30573-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Mon, Feb 07, 2011, Radoslaw Jablonski wrote:
> +	return -1;

Could you please use some more meaningful POSIX error codes here,
-EINVAL, etc.

> @@ -1645,13 +1652,14 @@ fail:
>  	g_free(temp_id);
>  	temp_id = NULL;
>  
> +	return -1;

Same here.

>  done:
>  	if (num_fields <= 0)
>  		data->ready_cb(data->user_data);
>  
> +	return -1;

And here.

>  	if (num_fields < 0) {
>  		data->cb(NULL, 0, num_fields, 0, data->user_data);
> -		return;
> +		return -1;

And here.

>  	}
>  
>  	if (data->params->maxlistcount == 0) {
> @@ -1880,6 +1889,8 @@ done:
>  	query_tracker(query, col_amount, pull_cb, data, &err);
>  	if (err < 0)
>  		data->cb(NULL, 0, err, 0, data->user_data);
> +
> +	return -1;
>  }

This looks a bit strange. Is it really a failure even if err is 0? I'd
expect the return statement to look like "return err;". Btw, why doesn't
query_tracker return the error in its return value?

Johan
