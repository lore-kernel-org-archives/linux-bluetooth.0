Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jan 2014 18:21:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared: Fix not calling destroy callback while clearing
 up handlers
Message-ID: <20140109162102.GA23401@x220.p-661hnu-f1>
References: <1389281160-17452-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389281160-17452-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Jan 09, 2014, Szymon Janc wrote:
> @@ -191,8 +191,10 @@ bool io_set_read_handler(struct io *io, io_callback_func_t callback,
>  
>  done:
>  	io->read_callback = callback;
> -	io->read_destroy = destroy;
> -	io->read_data = user_data;
> +	if (callback) {
> +		io->read_destroy = destroy;
> +		io->read_data = user_data;
> +	}
>  
>  	return true;
>  }

You're already checking for the value of callback earlier in the
function, so to avoid another check how about just move these
assignments right before the done: label?

> @@ -252,8 +254,10 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
>  
>  done:
>  	io->write_callback = callback;
> -	io->write_destroy = destroy;
> -	io->write_data = user_data;
> +	if (callback) {
> +		io->write_destroy = destroy;
> +		io->write_data = user_data;
> +	}
>  
>  	return true;
>  }

Same here.

Johan
