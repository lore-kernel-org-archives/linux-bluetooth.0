Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Feb 2011 06:58:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix refcount in btd_adapter_any_request_path()
Message-ID: <20110204045848.GD1551@jh-x301>
References: <1296792331-467-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296792331-467-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Feb 04, 2011, Anderson Lizardo wrote:
> adapter_any_refcount was not being incremented when a pointer to
> allocated buffer was returned.
> ---
>  src/adapter.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 08098a5..3e609c1 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3428,11 +3428,10 @@ const char *adapter_any_get_path(void)
>  
>  const char *btd_adapter_any_request_path(void)
>  {
> -	if (adapter_any_refcount > 0)
> +	if (adapter_any_refcount++ > 0)
>  		return adapter_any_path;
>  
>  	adapter_any_path = g_strdup_printf("%s/any", manager_get_base_path());
> -	adapter_any_refcount++;
>  
>  	return adapter_any_path;
>  }

Nice catch. The patch has been pushed upstream. Thanks.

Johan
