Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511357805.16347.43.camel@hadess.net>
Subject: Re: [PATCH BlueZ] player: Fix clearing track metadata
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Wed, 22 Nov 2017 14:36:45 +0100
In-Reply-To: <20171122133430.21672-1-luiz.dentz@gmail.com>
References: <20171122133430.21672-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-11-22 at 15:34 +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The value stored in the hashtable is the path not the actual pointer
> of
> the item.
> ---
>  profiles/audio/player.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index e499e6757..d12969bf9 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -1885,6 +1885,7 @@ struct media_item
> *media_player_set_playlist_item(struct media_player *mp,
>  {
>  	struct media_folder *folder = mp->playlist;
>  	struct media_item *item;
> +	char *path;

const char *? So it's clear why you don't free it.

>  	DBG("%" PRIu64 "", uid);
>  
> @@ -1903,7 +1904,8 @@ struct media_item
> *media_player_set_playlist_item(struct media_player *mp,
>  		mp->track = g_hash_table_ref(item->metadata);
>  	}
>  
> -	if (item == g_hash_table_lookup(mp->track, "Item"))
> +	path = g_hash_table_lookup(mp->track, "Item");
> +	if (!g_strcmp0(path, item->path))
>  		return item;
>  
>  	if (mp->process_id == 0) {
