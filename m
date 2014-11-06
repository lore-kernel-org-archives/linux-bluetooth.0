Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/mcaptest: Don't block main loop when disconnection is expected
Date: Thu, 06 Nov 2014 12:23:41 +0100
Message-ID: <6103693.iikMHdRFtS@uw000953>
In-Reply-To: <1415266385-18293-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1415266385-18293-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 06 of November 2014 10:33:05 Jakub Tyszkowski wrote:
> This triggers action after timeout without using sleep which was
> blocking main loop and mcaplib.
> ---
>  tools/mcaptest.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/mcaptest.c b/tools/mcaptest.c
> index 42734eb..bebc890 100644
> --- a/tools/mcaptest.c
> +++ b/tools/mcaptest.c
> @@ -71,31 +71,44 @@ static gboolean no_close = FALSE;
>  
>  #define REQ_CLOCK_ACC 0x1400
>  
> -static void mdl_connected_cb(struct mcap_mdl *mdl, void *data)
> +static gboolean close_mdl_timeout(gpointer user_data)
>  {
> +	struct mcap_mdl *mdl = user_data;
>  	int fd = -1;

This initialization is not needed now.
>  
> +	fd = mcap_mdl_get_fd(mdl);
> +
> +	if (fd > 0)
> +		close(fd);

0 is also valid fd. Probably won't happen with command line tool but lets
be consistent on this.

> +
> +	return FALSE;
> +}
> +
> +static void mdl_connected_cb(struct mcap_mdl *mdl, void *data)
> +{
>  	printf("%s\n", __func__);
>  
> -	if (mdl_disconnect && mdl_disconnect_timeout >= 0) {
> -		sleep(mdl_disconnect_timeout);
> +	if (mdl_disconnect && mdl_disconnect_timeout >= 0)
> +		g_timeout_add(mdl_disconnect_timeout * 1000, close_mdl_timeout,
> +									mdl);
> +}
>  
> -		fd = mcap_mdl_get_fd(mdl);
> +static gboolean close_mcl_timeout(gpointer user_data)
> +{
> +	struct mcap_mcl *mcl = user_data;
>  
> -		if (fd > 0)
> -			close(fd);
> -	}
> +	mcap_close_mcl(mcl, TRUE);
> +
> +	return FALSE;
>  }
>  
>  static void mdl_closed_cb(struct mcap_mdl *mdl, void *data)
>  {
>  	printf("%s\n", __func__);
>  
> -	if (mcl_disconnect && mcl_disconnect_timeout >= 0) {
> -		sleep(mcl_disconnect_timeout);
> -
> -		mcap_close_mcl(mcl, TRUE);
> -	}
> +	if (mcl_disconnect && mcl_disconnect_timeout >= 0)
> +		g_timeout_add(mcl_disconnect_timeout * 1000, close_mcl_timeout,
> +									mcl);
>  }
>  
>  static void mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
> 

-- 
Best regards, 
Szymon Janc
