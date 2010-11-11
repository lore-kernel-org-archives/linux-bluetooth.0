Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 12:25:49 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Split up pbap object and pbap session
Message-ID: <20101111102549.GI4132@jh-x301>
References: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Nov 11, 2010, Dmitriy Paliy wrote:
> +static void *vobject_create(void *user_data)

There's no reason for the void * types here. Use specific types instead.

> @@ -718,10 +736,13 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
>  		cb = query_result;
>  
>  	ret = phonebook_pull(name, pbap->params, cb, pbap);
> +
>  	if (ret < 0)
>  		goto fail;

No need to add the empty line.

>  
> -	return pbap;
> +	obj = vobject_create(pbap);
> +
> +	return obj;

Just do "return vobject_create(pbap);"

> +	obj = vobject_create(pbap);
> +
> +	return obj;

Same here.

> +	obj = vobject_create(pbap);
> +
> +	return obj;

And here.

Johan
