Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Oct 2014 02:49:06 -0700 (PDT)
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/mcaptest: Add missing mainloop quit
Message-ID: <8788486.a4c0tCSBXT@leonov>
In-Reply-To: <1414507356-7620-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1414507356-7620-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 28 of October 2014 15:42:36 Grzegorz Kolodziejczyk wrote:
> MCAP test should quit from main loop if mcl disconnects or if can't
> create mdl, mcl. Tested with PTS 5.3 test cases.
> ---
>  tools/mcaptest.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/mcaptest.c b/tools/mcaptest.c
> index 5ef030c..dd638c9 100644
> --- a/tools/mcaptest.c
> +++ b/tools/mcaptest.c
> @@ -151,6 +151,8 @@ static void mcl_disconnected(struct mcap_mcl *mcl,
> gpointer data) {
>  	/* TODO */
>  	printf("MCL disconnected\n");
> +
> +	g_main_loop_quit(mloop);
>  }
> 
>  static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
> @@ -174,6 +176,7 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl,
> uint8_t type, GError *gerr, if (gerr) {
>  		printf("MDL error: %s\n", gerr->message);
> 
> +		g_main_loop_quit(mloop);
>  		return;
>  	}
> 
> @@ -186,6 +189,8 @@ static void create_mdl_cb(struct mcap_mdl *mcap_mdl,
> uint8_t type, GError *gerr, NULL, &err)) {
>  		printf("Error connecting to mdl: %s\n", err->message);
>  		g_error_free(err);
> +
> +		g_main_loop_quit(mloop);
>  	}
>  }
> 
> @@ -255,6 +260,7 @@ static void create_mcl_cb(struct mcap_mcl *mcap_mcl,
> GError *err, gpointer data) if (err) {
>  		printf("Could not connect MCL: %s\n", err->message);
> 
> +		g_main_loop_quit(mloop);
>  		return;
>  	}

Applied, thanks.

-- 
BR
Szymon Janc
