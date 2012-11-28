Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Nov 2012 14:23:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gdbus: Fix crash error when calling
 g_dbus_remove_all_watches
Message-ID: <20121128122318.GA30710@x220.ger.corp.intel.com>
References: <1345802959-11774-1-git-send-email-tomasz.bursztyka@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345802959-11774-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomasz,

On Fri, Aug 24, 2012, Tomasz Bursztyka wrote:
> ---
> Hi,
> 
> While using gdbus on some other code, I found out that bug around g_dbus_remove_all_watches() usage.
> 
> Tomasz
> 
>  gdbus/watch.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index d749176..968a38a 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -298,6 +298,9 @@ static void filter_data_call_and_free(struct filter_data *data)
>  		g_free(cb);
>  	}
>  
> +	g_slist_free(data->callbacks);
> +	data->callbacks = NULL;
> +
>  	filter_data_free(data);
>  }

It seems this patch never got applied. Is it so that no-one else has
seen the issue. Could someone (through basic static analysis) confirm if
the patch is correct? It'd be nice if we could also have a back trace of
the crash in the commit message.

Johan
