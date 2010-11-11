Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 12:26:52 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Code clean up: cache->folder removed
Message-ID: <20101111102652.GK4132@jh-x301>
References: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
 <1289460972-2971-3-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289460972-2971-3-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Nov 11, 2010, Dmitriy Paliy wrote:
> cache->folder is not used anywhere and therefore removed.
> ---
>  plugins/pbap.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/plugins/pbap.c b/plugins/pbap.c
> index af60741..660b17d 100644
> --- a/plugins/pbap.c
> +++ b/plugins/pbap.c
> @@ -125,7 +125,6 @@ struct aparam_header {
>  struct cache {
>  	gboolean valid;
>  	uint32_t index;
> -	char *folder;
>  	GSList *entries;
>  };
>  
> @@ -219,7 +218,6 @@ static const char *cache_find(struct cache *cache, uint32_t handle)
>  
>  static void cache_clear(struct cache *cache)
>  {
> -	g_free(cache->folder);
>  	g_slist_foreach(cache->entries, (GFunc) cache_entry_free, NULL);
>  	g_slist_free(cache->entries);
>  	cache->entries = NULL;

This one is also now upstream. Thanks.

Johan
