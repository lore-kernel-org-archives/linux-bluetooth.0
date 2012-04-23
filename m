Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 13:15:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] input: add error message when auth fails
Message-ID: <20120423101535.GA8903@x220>
References: <1334943375-23475-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334943375-23475-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Apr 20, 2012, Gustavo Padovan wrote:
> ---
>  input/server.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/input/server.c b/input/server.c
> index cea08d1..ed09a73 100644
> --- a/input/server.c
> +++ b/input/server.c
> @@ -176,6 +176,8 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
>  	if (ret == 0)
>  		return;
>  
> +	error("Authorization failed(%d): %s", -ret, strerror(-ret));
> +
>  	g_io_channel_unref(server->confirm);
>  	server->confirm = NULL;

Thanks, applied after making the message a bit more informative.
Remember that error() doesn't include any context info like DBG() does,
i.e. you wouldn't even know that the error message is from the input
plugin.

Johan
