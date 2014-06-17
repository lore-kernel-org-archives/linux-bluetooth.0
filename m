Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 15/17] HDP: Fix possible memory leak
Date: Tue, 17 Jun 2014 22:51:39 +0200
Message-ID: <15088061.dzPvxLDqYO@athlon>
In-Reply-To: <1402905472-17643-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1402905472-17643-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 16 June 2014 10:57:50 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  profiles/health/hdp_util.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
> index 7185805..876a105 100644
> --- a/profiles/health/hdp_util.c
> +++ b/profiles/health/hdp_util.c
> @@ -597,6 +597,13 @@ fail:
>  	return NULL;
>  }
> 
> +static void free_hdp_list(void *list)
> +{
> +	sdp_list_t *hdp_list = list;
> +
> +	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
> +}
> +
>  static gboolean register_features(struct hdp_application *app,
>  						sdp_list_t **sup_features)
>  {
> @@ -619,16 +626,11 @@ static gboolean register_features(struct
> hdp_application *app, fail:
>  	if (hdp_feature != NULL)
>  		sdp_list_free(hdp_feature, (sdp_free_func_t)sdp_data_free);
> +	if (sup_features != NULL)
> +		sdp_list_free(*sup_features, free_hdp_list);

I have a feeling that this should be fixed in caller code ie 
register_service_sup_features.

Also sup_features was already dereferences few lines above so this check is 
not needed (or should it be *sup_features != NULL ?). 

>  	return FALSE;
>  }
> 
> -static void free_hdp_list(void *list)
> -{
> -	sdp_list_t *hdp_list = list;
> -
> -	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
> -}
> -
>  static gboolean register_service_sup_features(GSList *app_list,
>  						sdp_record_t *sdp_record)
>  {

-- 
Szymon K. Janc
szymon.janc@gmail.com
