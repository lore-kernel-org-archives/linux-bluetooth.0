Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 May 2012 15:25:30 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH BlueZ v2 2/6] audio: Add multiple device search to manager
Message-ID: <20120502182529.GB4019@samus>
References: <1335776199-16704-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1335776199-16704-3-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335776199-16704-3-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On 10:56 Mon 30 Apr, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> This method is useful to search or than one device fulfulling certain

I guess you meant "for more than one".

Other than this nitpick the patch looks good.

> criteria.
> ---
>  audio/manager.c |   25 ++++++++++++++++++++++---
>  audio/manager.h |    6 ++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/audio/manager.c b/audio/manager.c
> index 20453e6..9c7d0d3 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -1300,12 +1300,13 @@ void audio_manager_exit(void)
>  	btd_unregister_device_driver(&audio_driver);
>  }
>  
> -struct audio_device *manager_find_device(const char *path,
> +GSList *manager_find_devices(const char *path,
>  					const bdaddr_t *src,
>  					const bdaddr_t *dst,
>  					const char *interface,
>  					gboolean connected)
>  {
> +	GSList *result = NULL;
>  	GSList *l;
>  
>  	for (l = devices; l != NULL; l = l->next) {
> @@ -1343,10 +1344,28 @@ struct audio_device *manager_find_device(const char *path,
>  		if (connected && !audio_device_is_active(dev, interface))
>  			continue;
>  
> -		return dev;
> +		result = g_slist_append(result, dev);
>  	}
>  
> -	return NULL;
> +	return result;
> +}
> +
> +struct audio_device *manager_find_device(const char *path,
> +					const bdaddr_t *src,
> +					const bdaddr_t *dst,
> +					const char *interface,
> +					gboolean connected)
> +{
> +	struct audio_device *result;
> +	GSList *l;
> +
> +	l = manager_find_devices(path, src, dst, interface, connected);
> +	if (l == NULL)
> +		return NULL;
> +
> +	result = l->data;
> +	g_slist_free(l);
> +	return result;
>  }
>  
>  struct audio_device *manager_get_device(const bdaddr_t *src,
> diff --git a/audio/manager.h b/audio/manager.h
> index cfc646c..f1d3021 100644
> --- a/audio/manager.h
> +++ b/audio/manager.h
> @@ -46,6 +46,12 @@ struct audio_device *manager_find_device(const char *path,
>  					const char *interface,
>  					gboolean connected);
>  
> +GSList *manager_find_devices(const char *path,
> +					const bdaddr_t *src,
> +					const bdaddr_t *dst,
> +					const char *interface,
> +					gboolean connected);
> +
>  struct audio_device *manager_get_device(const bdaddr_t *src,
>  					const bdaddr_t *dst,
>  					gboolean create);
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
