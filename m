Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 13:14:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: lkslawek@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Add actual service for Message Access Profile
Message-ID: <20110310111408.GA18256@jh-x301>
References: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
 <1299058614-8904-3-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299058614-8904-3-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, Mar 02, 2011, lkslawek@gmail.com wrote:
> +	ret = obex_get_stream_start(os, name);
> +	if (ret < 0)
> +		goto fail;
> +
> +	return 0;
> +fail:
> +	return ret;
> +}

How about just "return obex_get_stream_start(os, name);"?

> +	ret = obex_put_stream_start(os, name);
> +	if (ret < 0)
> +		goto fail;
> +
> +	return 0;
> +fail:
> +	return ret;
> +}

Same here.

> +	}
> +
> +	return 0;
> +}
> +static struct obex_service_driver mas = {

Missing empty line before "statis struct ...".

>  static int mas_init(void)
>  {
> +	int err;
> +
> +	err = obex_service_driver_register(&mas);
> +	if (err < 0)
> +		goto fail_mas_reg;
> +
>  	return 0;
> +
> +fail_mas_reg:
> +	return err;
>  }

Just "return obex_service_driver_register(&mas);" should be enough.

Johan
